//
//  SitWithViewController.m
//  SitWith
//
//  Created by William Lutz on 8/29/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "LoginViewController.h"
#import "JoinTableViewController.h"
#import "SitWithAppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize fbloginview;
@synthesize loginButton;
@synthesize logoImage;
@synthesize permissionLabel;
@synthesize useLabe;

@synthesize srp;

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
    [FBLoginView class];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Login.jpg"]];
    permissionLabel.text = @"We will not post without permission";
    useLabe.text = @"We use Fabebook login only to make sure you will not SitWith your friends";
    self.fbloginview.readPermissions = @[@"public_profile", @"email", @"user_friends",@"user_birthday"];
    
    //hide the back button
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //initialize the SendRequestParse
    srp = [[SendRequestParse alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    userID = [user objectForKey:@"id"];
    userEmail = [user objectForKey:@"email"];
    userName = user.name;
    userGender = [user objectForKey:@"gender"];
    userAge = [self getUserAge:[user objectForKey:@"birthday"]];
    //create the user
    [srp createUser];
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    [self performSegueWithIdentifier:@"showMain" sender:nil];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

-(NSInteger)getUserAge:(NSString *)birthdayString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *birthday = [dateFormatter dateFromString:birthdayString];
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger ageInteger = [ageComponents year];
    return ageInteger;
}

@end
