//
//  JoinTableController.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "JoinTableViewController.h"
#import "ParserLunchTable.h"
#import "UIImageView+WebCache.h"
#import "LunchCalendar.h"



@interface JoinTableViewController ()

@end

@implementation JoinTableViewController

@synthesize createLunchButton;
@synthesize lunchtablePicture;
@synthesize lunchtableTime;
@synthesize lunchtableCountImage;
@synthesize lunchtableCountNumber;
@synthesize seatsRemaiedLabel;
@synthesize skipLunchTableButton;
@synthesize joinLunchTableButton;
@synthesize viewLunchTableAgainButton;
@synthesize viewLunchTableAgainLabel;
@synthesize lunchtableRestaurantNameLabel;

@synthesize lunchtableArray;
@synthesize lunchtablePictureArray;
@synthesize i;
@synthesize arraySize;
@synthesize lunchtime;
@synthesize restaurantName;

@synthesize plt;
@synthesize lc;
@synthesize spinner;
@synthesize srp;

@synthesize addedDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set the tabbar color
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    //get the upcoming lunch table data from the website
    UIImage *createButtonImage = [[UIImage imageNamed:@"blueButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *createButtonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [createLunchButton setBackgroundImage:createButtonImage forState:UIControlStateNormal];
    [createLunchButton setBackgroundImage:createButtonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *skipButtonImage = [[UIImage imageNamed:@"orangeButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *skipButtonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [skipLunchTableButton setBackgroundImage:skipButtonImage forState:UIControlStateNormal];
    [skipLunchTableButton setBackgroundImage:skipButtonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *joinButtonImage = [[UIImage imageNamed:@"greenButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *joinButtonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [joinLunchTableButton setBackgroundImage:joinButtonImage forState:UIControlStateNormal];
    [joinLunchTableButton setBackgroundImage:joinButtonImageHighlight forState:UIControlStateHighlighted];
    
    plt = [[ParserLunchTable alloc] init];
    //[[lunchtablePictureArray alloc] init];
    [plt parseNotFilledUpcomingLunchTable];
    plt._notfilledlunchtabledelegate = self;
    
    viewLunchTableAgainButton.hidden = YES;
    viewLunchTableAgainLabel.hidden = YES;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    joinFinishedAlertDismissed = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//set the specific lunchtable's data
- (void)setLunchtableLayout:(LunchTable *)lt{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, MMM d, HH:mm aaa"];
    lunchtableTime.text = [dateFormat stringFromDate:[lt getLunchtabletime]];
    [lunchtableTime setBackgroundColor:[UIColor lightGrayColor]];
    [lunchtableTime setTextColor:[UIColor whiteColor]];
    [self.view bringSubviewToFront:lunchtableTime];
    lunchtableRestaurantNameLabel.text = [lt getRestaurant_name];
    lunchtableCountNumber.text = [@(4-[lt getCount]) stringValue];
    NSURL *url = [NSURL URLWithString:[lt getRestaurant_picture]];
    [lunchtablePicture sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    lunchtime = [dateFormat stringFromDate:[lt getLunchtabletime]];
    restaurantName = [lt getRestaurant_name];
}

//This method implement the action when the skip button is pressed
- (IBAction)skipLunchTableAction:(id)sender {
    i++;
    if(i<arraySize&&arraySize>0){
        [self setLunchtableLayout:[lunchtableArray objectAtIndex: i]];
    }else{
        lunchtablePicture.hidden = YES;
        lunchtableTime.hidden = YES;
        lunchtableCountImage.hidden = YES;
        lunchtableCountNumber.hidden = YES;
        seatsRemaiedLabel.hidden = YES;
        skipLunchTableButton.hidden = YES;
        joinLunchTableButton.hidden = YES;
        lunchtableRestaurantNameLabel.hidden = YES;
        viewLunchTableAgainButton.hidden = NO;
        viewLunchTableAgainLabel.hidden = NO;
        viewLunchTableAgainLabel.text = @"You have reached the end of the List. Would you like to refresh to see more?";
    }
}

//This method implement the action when join button is pressed
- (IBAction)joinLunchTableAction:(id)sender {
    LunchTable *lt = [lunchtableArray objectAtIndex: i];
    NSString *lunchtable_id = [@([lt getLunchtable_id]) stringValue];
    NSString *restaurant_id = [@([lt getRestaurant_id]) stringValue];
    NSString *restaurant_name = [lt getRestaurant_name];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *lunchtabletime = [lt getLunchtabletime];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSString *lunchtabletimeString = [dateFormatter stringFromDate:lunchtabletime];
    
    srp = [[SendRequestParse alloc]init];
    [srp joinLunchTableParse:lunchtable_id restaurantId:restaurant_id restaurantName:restaurant_name Lunchtabletime:lunchtabletimeString];
    srp._joinlunchtabledelegate = self;
    
    addedDate = lunchtabletime;
}

//This method implement the action when the refresh button is pressed
- (IBAction)viewLunchTableAction:(id)sender {
    //[[lunchtablePictureArray alloc] init];
    [plt parseNotFilledUpcomingLunchTable];
    plt._notfilledlunchtabledelegate = self;
    
}

//This method implement when the data has finished loading
#pragma mark - ParseLunchTable delegate
- (void) processCompleted: (ParserLunchTable *) sender{
    self.lunchtableArray = plt.getNotFilledUpcomingLunchTable;
    
    arraySize = [lunchtableArray count];
    lunchtablePictureArray = [[NSMutableArray alloc] init];
    for (LunchTable *l in lunchtableArray)
    {
        NSString *lunchtablePictureString = [l getRestaurant_picture];
        NSURL *url = [NSURL URLWithString:lunchtablePictureString];
        UIImageView *lunchtable_pic = [[UIImageView alloc] init];
        [lunchtable_pic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        [lunchtablePictureArray addObject:lunchtable_pic];
    }
    
    i=0;
    if(arraySize>0){
        [self setLunchtableLayout:[lunchtableArray objectAtIndex: i]];
        [spinner stopAnimating];
        lunchtablePicture.hidden = NO;
        lunchtableTime.hidden = NO;
        lunchtableCountImage.hidden = NO;
        lunchtableCountNumber.hidden = NO;
        seatsRemaiedLabel.hidden = NO;
        skipLunchTableButton.hidden = NO;
        joinLunchTableButton.hidden = NO;
        lunchtableRestaurantNameLabel.hidden = NO;
        viewLunchTableAgainButton.hidden = YES;
        viewLunchTableAgainLabel.hidden = YES;
    }else{
        lunchtablePicture.hidden = YES;
        lunchtableTime.hidden = YES;
        lunchtableCountImage.hidden = YES;
        lunchtableCountNumber.hidden = YES;
        seatsRemaiedLabel.hidden = YES;
        skipLunchTableButton.hidden = YES;
        joinLunchTableButton.hidden = YES;
        lunchtableRestaurantNameLabel.hidden = YES;
        viewLunchTableAgainButton.hidden = NO;
        viewLunchTableAgainLabel.hidden = NO;
        viewLunchTableAgainLabel.text = @"You have reached the end of the List. Would you like to refresh to see more?";
    }
}

//This is when the connection has some error in it
- (void) connectionError:(ParserLunchTable *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [spinner stopAnimating];
    lunchtablePicture.hidden = YES;
    lunchtableTime.hidden = YES;
    lunchtableCountImage.hidden = YES;
    lunchtableCountNumber.hidden = YES;
    seatsRemaiedLabel.hidden = YES;
    skipLunchTableButton.hidden = YES;
    joinLunchTableButton.hidden = YES;
    lunchtableRestaurantNameLabel.hidden = YES;
    viewLunchTableAgainButton.hidden = NO;
    viewLunchTableAgainLabel.hidden = YES;
}

//This method implement the action when the server has finished the join request
#pragma mark - Join LunchTable delegate
- (void) joinCompleted: (SendRequestParse *)sender{
    NSString *alertMessage = [NSString stringWithFormat:@"You have joined a lunch at %@ at %@", lunchtime,restaurantName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lunch joined"
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    joinFinishedAlertDismissed = true;
    [alert show];
    [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"HasSeenPopup"];
    [plt parseNotFilledUpcomingLunchTable];
    plt._notfilledlunchtabledelegate = self;
}

//This implement the join connection error when pressed the join button
- (void) joinConnectionError:(SendRequestParse *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

//This implement the add calendar button
- (void) addCalendarAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add to calendar"
                                                    message:@"Would you like to add your SitWith lunches to your calendar for future reference?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
    
}

- (void) addCalendar{
    
    lc = [[LunchCalendar alloc]init];
    [lc addEvent:addedDate];
    addedDate = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"YES"])
    {
        [self addCalendar];
    }
    
    if(joinFinishedAlertDismissed){
        if (buttonIndex == [alertView cancelButtonIndex]){
            [self addCalendarAlert];
        }
    }
}

@end
