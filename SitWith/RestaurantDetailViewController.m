//
//  RestaurantDetailViewController.m
//  SitWith
//
//  Created by William Lutz on 8/23/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "JoinTableViewController.h"
#import "WebViewController.h"

@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

@synthesize r;
@synthesize restaurant_name;
@synthesize restaurant_neighborhood;
@synthesize restaurant_address;
@synthesize restaurantImage;
@synthesize createButton;
@synthesize yelpButton;
@synthesize lunchtableDateLabel;
@synthesize datePlaceholderLabel;
@synthesize lunchtableTimeLabel;

@synthesize lunchtabledate;
@synthesize lunchtabledateString;
@synthesize lunchtabletimeString;
@synthesize lunchtableDateTimeString;
@synthesize lunchtabletimeArray;

@synthesize srp;
@synthesize yelpPageYes;

@synthesize spinner;

@synthesize datepicker;
@synthesize timepicker;

@synthesize dateButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    restaurant_name.text = [r getName];
    restaurant_neighborhood.text = [r getNeighborhood];
    restaurant_address.text = [r getAddress];
    NSURL *url = [NSURL URLWithString:[r getPicture]];
    [restaurantImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    //initialize the lunchtabletimeString
    lunchtabledateString = @"firstSetup";
    lunchtabletimeString = @"firstSetup";
    
    [[dateButton layer] setBorderWidth:2.0f];
    [[dateButton layer] setBorderColor:[UIColor greenColor].CGColor];
    lunchtabledate = [NSDate date];
    
    UIImage *createButtonImage = [[UIImage imageNamed:@"blackButton.png"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *createButtonImageHighlight = [[UIImage imageNamed:@"blackButtonHighlight.png"]
                                         resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [createButton setBackgroundImage:createButtonImage forState:UIControlStateNormal];
    [createButton setBackgroundImage:createButtonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *yelpButtonImage = [[UIImage imageNamed:@"orangeButton.png"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *yelpButtonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [yelpButton setBackgroundImage:yelpButtonImage forState:UIControlStateNormal];
    [yelpButton setBackgroundImage:yelpButtonImageHighlight forState:UIControlStateHighlighted];
    
    yelpPageYes = NO;
    
    [self.view bringSubviewToFront:datePlaceholderLabel];
    [self.view bringSubviewToFront:lunchtableDateLabel];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pickDateAction:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.tag = 10;
    [self.view addSubview:datepicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datepicker.frame = datePickerTargetFrame;
    datepicker.backgroundColor = [UIColor whiteColor];
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}

- (IBAction)pickTimeAction:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    lunchtabletimeArray = [[NSArray alloc]init];
    lunchtabletimeArray = [self initiateTimeArray:lunchtabletimeArray];

    CGRect timeListTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    timepicker = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    timepicker.tag = 7;
    [timepicker registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lunchTimeTable"];
    [self.view addSubview:timepicker];
    
    [UIView beginAnimations:@"MoveInTime" context:nil];
    timepicker.frame = timeListTargetFrame;
    timepicker.backgroundColor = [UIColor whiteColor];
    timepicker.delegate = self;
    timepicker.dataSource = self;
    [UIView commitAnimations];

}

- (IBAction)createAction:(id)sender {
    srp = [[SendRequestParse alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    if([lunchtabledateString isEqual:@"firstSetup"]||[lunchtabletimeString isEqual:@"firstSetup"]){
        NSString *alertTitle = [[NSString alloc] init];
        NSString *alertMessage = [[NSString alloc] init];
        alertTitle = @"No date or time selected";
        alertMessage = @"You must selecte a date to create the lunch.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: alertTitle
                                                        message: alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        lunchtableDateTimeString = [NSString stringWithFormat:@"%@ %@:00:0", lunchtabledateString, lunchtabletimeString];
        [srp createLunchTableParse:[@([r getRestaurant_id]) stringValue] restaurantName:[r getName] availablebeginTime:lunchtableDateTimeString];
        srp._createlunchtabledelegate = self;
        //set up the spinner
        spinner = [[UIActivityIndicatorView alloc]
                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
        spinner.hidesWhenStopped = YES;
        [self.view addSubview:spinner];
        [spinner startAnimating];

    }
}

- (IBAction)yelpPageAction:(id)sender {
    
}

//specify the segue for the yelp page
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"yelpPageSegue"]) {
        
        WebViewController *destViewController = segue.destinationViewController;
        destViewController.urlString = [r getYelp_url];
        
    }
}



- (void)removeDateViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)removeTimeViews{
    [[self.view viewWithTag:7] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeDateViews:)];
    [UIView commitAnimations];
    
    lunchtabledate = datepicker.date;
    NSDateFormatter *ampmFormatter = [[NSDateFormatter alloc] init];
    [ampmFormatter setDateFormat:@"EEE"];
    //get the dat of the week of the selected date
    NSString *lunchtabledateday = [ampmFormatter stringFromDate:lunchtabledate];
    
    
    NSString *alertTitle = [[NSString alloc] init];
    NSString *alertMessage = [[NSString alloc] init];
    //Whether date selected is 2 months away
    if([[self sameDateByAddingMonths:2] timeIntervalSinceDate:lunchtabledate]<0){
        alertTitle = @"Date not available";
        alertMessage = @"Please select date within 2 months";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        lunchtableDateLabel.text = @"select date";
        lunchtabledateString = @"firstSetup";
    }//if date selected is previous date
    else if([lunchtabledate timeIntervalSinceNow]<0){
        alertTitle = @"Previous date selected";
        alertMessage = @"You could only select time in the future";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        lunchtableDateLabel.text = @"select date";
        lunchtabledateString = @"firstSetup";
    }//if date selected is Monday, Tuesday or Wednesday
    else if([lunchtabledateday isEqual:@"Thu"]||[lunchtabledateday isEqual:@"Fri"]||[lunchtabledateday isEqual:@"Sat"]||[lunchtabledateday isEqual:@"Sun"]){
        
        alertTitle = @"Sorry, date not available";
        alertMessage = @"SitWith lunches only happen on Monday, Tuesday and Wednesday. Please try another one";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        lunchtableDateLabel.text = @"select date";
        lunchtabledateString = @"firstSetup";
    }//if the date ssatisfies the requirement
    else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE, MMM d"];
        
        lunchtableDateLabel.text = [dateFormatter stringFromDate:lunchtabledate];
        lunchtableDateLabel.textColor = [UIColor redColor];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        lunchtabledateString = [dateFormatter stringFromDate:lunchtabledate];
    }
    
}


#pragma mark - TestParse delegate
- (void) createCompleted: (SendRequestParse *) sender{
    [srp getCreateLunchTableResult];
    [spinner stopAnimating];
    
    NSString *alertmessage = [NSString stringWithFormat:@"You have created a lunch at %@ at %@", lunchtableDateTimeString,[r getName]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lunch created"
                                                    message:alertmessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    lunchtableDateLabel.text = @"select date";
    lunchtableTimeLabel.text = @"select time";
    lunchtabledateString = @"firstSetup";
    lunchtabletimeString = @"firstSetup";
}


- (void) createConnectionError:(ParserLunchTable *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [spinner stopAnimating];
}

-(NSArray *) initiateTimeArray:(NSArray *)arrayNeedInitiate{
    arrayNeedInitiate = [NSArray arrayWithObjects:@"11:00", @"11:30", @"12:00", @"12:30",  @"13:00", @"13:30", @"14:00", @"14:30", @"15:00",nil];
    return arrayNeedInitiate;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lunchtabletimeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"lunchTimeTable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [lunchtabletimeArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lunchtabletimeString = [lunchtabletimeArray objectAtIndex:indexPath.row];
    [self removeTimeViews];
    lunchtableTimeLabel.text = lunchtabletimeString;
}

- (NSDate *)sameDateByAddingMonths:(NSInteger)addMonths {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:addMonths];
    
    return [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
}

@end
