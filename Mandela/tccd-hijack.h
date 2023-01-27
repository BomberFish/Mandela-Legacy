//
//  tccd-hijack.h
//  Mandela
//
//  Created by Hariz Shirazi on 2023-01-27.
//

#import <Foundation/Foundation.h>

#ifndef tccd_hijack_h
#define tccd_hijack_h

void neuter_tccd(void (^completion)(NSError* _Nullable));

#endif /* tccd_hijack_h */
