//
//  UpcomingTableCell.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendRequestParse.h"
#import "RequestTobeProcessed.h"

@class UpcomingTableCell;
@protocol CancelFinishedDelegate <NSObject>
- (void) cancelFinished: (UpcomingTableCell *)sender;
@end


@interface UpcomingTableCell : UITableViewCell<cancelFromLunchTableDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *lunchtabletime;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_name;
@property (weak, nonatomic) IBOutlet UILabel *daysahead;
@property (weak, nonatomic) IBOutlet UILabel *requestmadetime;
@property (weak, nonatomic) IBOutlet UIButton *cancelRequestTobeProcessedButton;

@property (nonatomic, weak)id <CancelFinishedDelegate> _cancelfinisheddelegate;

//this is the requesttobeprocessed that stores the cell's information
@property RequestTobeProcessed *requesttobeprocessed;

//the spinner when acting
@property UIActivityIndicatorView *spinner;
//the class that will handle the request
@property SendRequestParse *srp;

- (IBAction)cancelButton:(UIButton *)sender;


@end
