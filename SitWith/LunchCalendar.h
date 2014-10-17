//
//  LunchCalendar.h
//  SitWith
//
//  Created by William Lutz on 10/2/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface LunchCalendar: NSObject

- (void)addEvent:(NSDate *)beginDate;
-(void)event:(EKEventStore *)eventStore beginDate:(NSDate *)beginDate;

@end

