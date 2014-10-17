//
//  LunchTable.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunchTable : NSObject

{
    NSInteger lunchtable_id;
    NSInteger restaurant_id;
    NSString *restaurant_name;
    NSDate *lunchtabletime;
    NSString *status;
    NSInteger count;
    NSString *address;
    NSString *restaurant_picture;
    NSString *A;
    NSString *B;
    NSString *C;
    NSString *D;
    NSString *A_name;
    NSString *B_name;
    NSString *C_name;
    NSString *D_name;
}

// get methods
- (NSInteger) getLunchtable_id;

- (NSInteger) getRestaurant_id;

- (NSString *) getRestaurant_name;

- (NSDate *) getLunchtabletime;

- (NSString *) getStatus;

- (NSInteger) getCount;

- (NSString *) getAddress;

- (NSString *) getRestaurant_picture;

- (NSString *) getA;

- (NSString *) getB;

- (NSString *) getC;

- (NSString *) getD;

- (NSString *) getA_name;

- (NSString *) getB_name;

- (NSString *) getC_name;

- (NSString *) getD_name;


// set methods

- (void) setLunchtable_id:(NSInteger)input;

- (void) setRestaurant_id:(NSInteger)input;

- (void) setRestaurant_name:(NSString *)input;

- (void) setLunchtabletime:(NSDate *)input;

- (void) setStatus:(NSString *)input;

- (void) setCount:(NSInteger)input;

- (void) setAddress:(NSString *)input;

- (void) setRestaurant_picture:(NSString *)input;

- (void) setA:(NSString *)input;

- (void) setB:(NSString *)input;

- (void) setC:(NSString *)input;

- (void) setD:(NSString *)input;

- (void) setA_name:(NSString *)input;

- (void) setB_name:(NSString *)input;

- (void) setC_name:(NSString *)input;

- (void) setD_name:(NSString *)input;


- (NSString *) getFirstName:(NSString *)entireName;

@end
