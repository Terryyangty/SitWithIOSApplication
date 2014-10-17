//
//  Restaurant.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

// get methods
- (NSInteger) getRestaurant_id
{
    return restaurant_id;
}

- (NSString *) getName
{
    return name;
}

- (NSString *) getNeighborhood
{
    return neighborhood;
}

- (NSString *) getCity
{
    return city;
}

- (NSString *) getAddress
{
    return address;
}

- (NSString *) getHours
{
    return hours;
}

- (NSString *) getPicture
{
    return picture;
}

- (NSString *) getYelp_url
{
    return yelp_url;
}

// set methods
- (void) setRestaurant_id:(NSInteger)input{
    restaurant_id = input;
}

-(void)setName:(NSString *)input
{
    name = input;
}

-(void)setNeighborhood:(NSString *)input{
    neighborhood = input;
}

-(void)setCity:(NSString *)input{
    city = input;
}

-(void)setAddress:(NSString *)input
{
    address = input;
}
-(void)setHours:(NSString *)input
{
    hours = input;
}
-(void)setPicture:(NSString *)input
{
    picture = input;
}
-(void)setYelp_url:(NSString *)input{
    yelp_url = input;
}



@end
