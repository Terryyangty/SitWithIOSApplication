//
//  Restaurant.h
//  Ryan
//
//  Created by Terry Yang on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
{
    NSInteger restaurant_id;
    NSString *name;
    NSString *neighborhood;
    NSString *city;
    NSString *address;
    NSString *hours;
    NSString *picture;
    NSString *yelp_url;
}

// get methods
- (NSInteger) getRestaurant_id;

- (NSString *) getName;

- (NSString *) getNeighborhood;

- (NSString *) getCity;

- (NSString *) getAddress;

- (NSString *) getHours;

- (NSString *) getPicture;

- (NSString *) getYelp_url;

// set methods
-(void)setRestaurant_id:(NSInteger)input;

-(void)setName:(NSString *)input;

-(void)setNeighborhood:(NSString *)input;

-(void)setCity:(NSString *)input;

-(void)setAddress:(NSString *)input;

-(void)setHours:(NSString *)input;

-(void)setPicture:(NSString *)input;

-(void)setYelp_url:(NSString *)input;

@end
