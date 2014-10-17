//
//  RestaurantListViewController.h
//  SitWith
//
//  Created by William Lutz on 8/22/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "ParseRestaurant.h"


@interface RestaurantListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,RestaurantListDelegate>

@property ParseRestaurant *pr;

@property (strong, nonatomic) NSMutableArray *restaurantArray;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;

@property UIActivityIndicatorView *spinner;



@end
