//
//  RestaurantDetailViewController.h
//  SitWith
//
//  Created by William Lutz on 8/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "SendRequestParse.h"

@interface RestaurantDetailViewController : UIViewController<createLunchTableDelegate,UIAlertViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Restaurant *r;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_name;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_address;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_neighborhood;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *yelpButton;
@property (weak, nonatomic) IBOutlet UILabel *datePlaceholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunchtableDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunchtableTimeLabel;


@property NSDate *lunchtabledate;
@property NSString *lunchtabledateString;
@property NSString *lunchtabletimeString;
@property NSString *lunchtableDateTimeString;
@property NSArray * lunchtabletimeArray;

@property SendRequestParse *srp;
@property BOOL yelpPageYes;

@property UIActivityIndicatorView *spinner;




@property (weak, nonatomic) IBOutlet UIButton *dateButton;


@property (strong, nonatomic) UIDatePicker *datepicker;
@property (strong, nonatomic) UITableView *timepicker;

- (IBAction)pickDateAction:(id)sender;
- (IBAction)pickTimeAction:(id)sender;
- (IBAction)createAction:(id)sender;
- (IBAction)yelpPageAction:(id)sender;

-(NSArray *) initiateTimeArray:(NSArray *)arrayNeedInitiate;
- (void)removeTimeViews;

@end
