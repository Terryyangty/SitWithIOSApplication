//
//  UpcomingTableCell.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "UpcomingTableCell.h"

@implementation UpcomingTableCell

@synthesize lunchtabletime;
@synthesize restaurant_name;
@synthesize daysahead;
@synthesize requestmadetime;
@synthesize cancelRequestTobeProcessedButton;

@synthesize requesttobeprocessed;
@synthesize _cancelfinisheddelegate;

@synthesize spinner;
@synthesize srp;

- (IBAction)cancelButton:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel Lunch"
                                                    message:@"Are you sure you want to lose a SitWith opportunity?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"HasSeenPopup"];
}

//this is the method when user hit the yes button
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        srp = [[SendRequestParse alloc]init];
        NSInteger lunchtable_id = [requesttobeprocessed getLunchtable_id];
        NSInteger requesttobeprocessed_id = [requesttobeprocessed getRequesttobeprocessed_id];
        [srp cancelFromLunchTableParse:[@(lunchtable_id) stringValue] requesttobeprocessedId:[@(requesttobeprocessed_id) stringValue]];
        srp._cancelfromlunchtabledelegate = self;
    }
}

#pragma mark - cancel delegate
- (void) cancelCompleted: (SendRequestParse *) sender{
    [srp getCreateLunchTableResult];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel Finished"
                                                   message:@"You have canceled your SitWith Lunch"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
    [self._cancelfinisheddelegate cancelFinished:self];
}
- (void) cancelConnectionError:(SendRequestParse *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
