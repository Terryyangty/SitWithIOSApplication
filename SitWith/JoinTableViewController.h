//
//  JoinTableController.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "LunchTable.h"
#import "ParserLunchTable.h"
#import "SendRequestParse.h"
#import "LunchCalendar.h"

@interface JoinTableViewController : UIViewController<NotFilledUpcomingLunchTableDelegate, JoinLunchTableDelegate,UIAlertViewDelegate>{
    Boolean joinFinishedAlertDismissed ;
}


@property (weak, nonatomic) IBOutlet UIButton *createLunchButton;
@property (weak, nonatomic) IBOutlet UIImageView *lunchtablePicture;
@property (weak, nonatomic) IBOutlet UILabel *lunchtableTime;
@property (weak, nonatomic) IBOutlet UILabel *lunchtableCountNumber;
@property (weak, nonatomic) IBOutlet UIImageView *lunchtableCountImage;
@property (weak, nonatomic) IBOutlet UILabel *seatsRemaiedLabel;
@property (weak, nonatomic) IBOutlet UIButton *skipLunchTableButton;
@property (weak, nonatomic) IBOutlet UIButton *joinLunchTableButton;
@property (weak, nonatomic) IBOutlet UIButton *viewLunchTableAgainButton;
@property (weak, nonatomic) IBOutlet UILabel *viewLunchTableAgainLabel;
@property (weak, nonatomic) IBOutlet UILabel *lunchtableRestaurantNameLabel;

@property ParserLunchTable *plt;
@property UIActivityIndicatorView *spinner;
//The class for sending the request
@property SendRequestParse *srp;
//The class for adding lunch into calendar
@property LunchCalendar *lc;

@property NSMutableArray *lunchtableArray;
@property NSMutableArray *lunchtablePictureArray;
@property int i;
@property NSInteger arraySize;
@property NSString *lunchtime;
@property NSString *restaurantName;

@property NSDate *addedDate;

-(void) setLunchtableLayout:(LunchTable *)lt;
- (IBAction)skipLunchTableAction:(id)sender;
- (IBAction)joinLunchTableAction:(id)sender;
- (IBAction)viewLunchTableAction:(id)sender;

@end
