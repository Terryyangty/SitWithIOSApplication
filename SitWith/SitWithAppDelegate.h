//
//  SitWithAppDelegate.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import <FacebookSDK/FacebookSDK.h>


// string version of selected restaurant
NSString *chosenRestaurant;
NSArray *possibleHours;
NSArray *possibleMinutes;
NSArray *ampm;

// date of restaurant selected
NSDate *chosenDate;

// object for when user makes lunch
Restaurant *selectedMakeRestaurant;

// string version of date and time
NSString *lunchDateAndTime;

// these represent the information for logged in user
NSString *userID;
NSString *userName;
NSString *userEmail;
NSString *userGender;
NSInteger userAge;

// arrays that will hold data taken from xml files
NSMutableArray *restaurantAvailability;
NSMutableArray *restaurantNames;
NSMutableArray *restaurantLocations;
NSMutableArray *restaurantPictures;
NSMutableArray *beginTimes;

// arrays to hold objects taken from xml
NSMutableArray *upcomingLunchObjects;
NSMutableArray *restaurantObjects;
NSMutableArray *userPastLunchObjects;
NSMutableArray *userUpcomingLunchObjects;

NSString *serverAddress;

//indicate whether logged in or not
BOOL authenticated;

@interface SitWithAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
