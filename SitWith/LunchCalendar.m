//
//  LunchCalendar.m
//  SitWith
//
//  Created by William Lutz on 10/2/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "LunchCalendar.h"

@implementation LunchCalendar : NSObject 

- (void)addEvent:(NSDate *)beginDate {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    NSLog(@"error geting calendar");
                }
                else if (!granted)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Calendar access denied"
                                                                    message:@"Please add your SitWith action to the calendar"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    
                    [self event:eventStore beginDate:beginDate];
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }

    
    
}

-(void)event:(EKEventStore *)eventStore beginDate:(NSDate *)beginDate{
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = @"SitWith Lunch";
    
    event.startDate = beginDate;
    event.endDate   = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:event.startDate];
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
}

@end