//
//  LunchTable.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "LunchTable.h"

@implementation LunchTable

// get methods
- (NSInteger) getLunchtable_id{
    return lunchtable_id;
}

- (NSInteger) getRestaurant_id{
    return restaurant_id;
}

- (NSString *) getRestaurant_name{
    return restaurant_name;
}

- (NSDate *) getLunchtabletime{
    return lunchtabletime;
}

- (NSString *) getStatus{
    return status;
}

- (NSInteger) getCount{
    return count;
}

- (NSString *) getAddress {
    return address;
}

- (NSString *) getRestaurant_picture{
    return restaurant_picture;
}

- (NSString *) getA{
    return A;
}

- (NSString *) getB{
    return B;
}

- (NSString *) getC{
    return C;
}

- (NSString *) getD{
    return D;
}

- (NSString *) getA_name{
    return A_name;
}

- (NSString *) getB_name{
    return B_name;
}

- (NSString *) getC_name{
    return C_name;
}

- (NSString *) getD_name{
    return D_name;
}


// set methods

- (void) setLunchtable_id:(NSInteger)input {
    lunchtable_id = input;
}

- (void) setRestaurant_id:(NSInteger)input{
    restaurant_id = input;
}

- (void) setRestaurant_name:(NSString *)input{
    restaurant_name = input;
}

- (void) setLunchtabletime:(NSDate *)input{
    lunchtabletime = input;
}

- (void) setStatus:(NSString *)input{
    status = input;
}

- (void) setCount:(NSInteger)input{
    count = input;
}


- (void) setAddress:(NSString *)input{
    address = input;
}

- (void) setRestaurant_picture:(NSString *)input{
    restaurant_picture = input;
}

- (void) setA:(NSString *)input{
    A = input;
}

- (void) setB:(NSString *)input{
    B = input;
}

- (void) setC:(NSString *)input{
    C = input;
}
- (void) setD:(NSString *)input{
    D = input;
}

- (void) setA_name:(NSString *)input{
    A_name = input;
}

- (void) setB_name:(NSString *)input{
    B_name = input;
}

- (void) setC_name:(NSString *)input{
    C_name = input;
}

- (void) setD_name:(NSString *)input{
    D_name = input;
}

- (NSString *) getFirstName:(NSString *)entireName
{
    
    NSArray *firstandlast = [entireName componentsSeparatedByString:@" "];
    return [firstandlast objectAtIndex:0];
}

@end
