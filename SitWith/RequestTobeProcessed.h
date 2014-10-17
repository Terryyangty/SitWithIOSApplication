//
//  RequestTobeProcessed.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestTobeProcessed : NSObject{
    NSInteger requesttobeprocessed_id;
    NSString *user_email;
    NSString *user_name;
    NSInteger lunchtable_id;
    NSInteger restaurant_id;
    NSString *restaurant_name;
    NSString *restaurant_picture;
    NSDate *lunchtabletime;
    NSDate *requestmadetime;
    NSString *status;
}


// get methods
- (NSInteger ) getRequesttobeprocessed_id;

- (NSString *) getUser_email;

- (NSString *) getUser_name;

- (NSInteger ) getLunchtable_id;

- (NSInteger ) getRestaurant_id;

- (NSString *) getRestaurant_name;

- (NSString *) getRestaurant_picture;

- (NSDate *) getLunchtabletime;

- (NSDate *) getRequestmadetime;

- (NSString *) getStatus;

// set methods
-(void) setRequesttobeprocessed_id: (NSInteger)input;

-(void)setUser_email:(NSString *)input;

-(void)setUser_name:(NSString *)input;

-(void)setLunchtable_id:(NSInteger)input;

-(void)setRestaurant_id:(NSInteger)input;

-(void)setRestaurant_name:(NSString *)input;

-(void)setRestaurant_picture:(NSString *)input;


-(void)setLunchtabletime:(NSDate *)input;

-(void)setRequestmadetime:(NSDate *)input;

-(void)setStatus:(NSString *)input;

@end
