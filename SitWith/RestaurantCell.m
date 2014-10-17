//
//  RestaurantCell.m
//  SitWith
//
//  Created by William Lutz on 8/22/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "RestaurantCell.h"
#import "UIImageView+WebCache.h"

@implementation RestaurantCell

@synthesize restaurantNameLabel;
@synthesize restaurantNeighborhoodLabel;
@synthesize restaurantCityLabel;
@synthesize restaurantAddressLabel;
@synthesize restaurantImage;

- (RestaurantCell *) setRestaurantCell:(Restaurant *)r{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, HH:mm aaa"];
    
    restaurantNameLabel.text = [r getName];
    restaurantNeighborhoodLabel.text = [r getNeighborhood];
    restaurantCityLabel.text = [r getCity];
    restaurantAddressLabel.text = [r getAddress];
    
    NSURL *url = [NSURL URLWithString:[r getPicture]];
    [restaurantImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [self bringSubviewToFront:restaurantNameLabel];
    [self bringSubviewToFront:restaurantNeighborhoodLabel];
    return self;
}

@end
