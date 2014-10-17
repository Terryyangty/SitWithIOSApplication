//
//  RequestTobeProcessed.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "RequestTobeProcessed.h"

@implementation RequestTobeProcessed


- (NSInteger) getRequesttobeprocessed_id{
    return requesttobeprocessed_id;
}

- (NSString *) getUser_email{
    return user_email;
}

- (NSString *) getUser_name{
    return user_name;
}

- (NSInteger) getLunchtable_id{
    return lunchtable_id;
}

- (NSInteger) getRestaurant_id{
    return restaurant_id;
}

- (NSString *) getRestaurant_name{
    return restaurant_name;
}

- (NSString *) getRestaurant_picture{
    return restaurant_picture;
}

- (NSDate *) getLunchtabletime{
    return lunchtabletime;
}

- (NSDate *) getRequestmadetime{
    return requestmadetime;
}

- (NSString *) getStatus{
    return status;
}

// set methods
-(void) setRequesttobeprocessed_id: (NSInteger)input{
    requesttobeprocessed_id = input;
}

-(void)setUser_email:(NSString *)input{
    user_email = input;
}

-(void)setUser_name:(NSString *)input{
    user_name = input;
}

-(void)setLunchtable_id:(NSInteger)input{
    lunchtable_id = input;
}

-(void)setRestaurant_id:(NSInteger)input{
    restaurant_id = input;
}

-(void)setRestaurant_name:(NSString *)input{
    restaurant_name = input;
}

-(void)setRestaurant_picture:(NSString *)input{
    restaurant_picture = input;
}

-(void)setLunchtabletime:(NSDate *)input{
    lunchtabletime = input;
}

-(void)setRequestmadetime:(NSDate *)input{
    requestmadetime = input;
}

-(void)setStatus:(NSString *)input{
    status = input;
}

@end
