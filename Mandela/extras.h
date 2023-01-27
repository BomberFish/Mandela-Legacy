//
//  extras.h
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-27.
//

#ifndef extras_h
#define extras_h

char* get_temp_file_path(void);
void test_nsexpressions(void);
char* set_up_tmp_file(void);

void xpc_crasher(char* service_name);

#define ROUND_DOWN_PAGE(val) (val & ~(PAGE_SIZE - 1ULL))

#endif /* extras_h */
