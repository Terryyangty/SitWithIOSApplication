//
//  UpcomingViewController.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTobeProcessed.h"
#import "UpcomingTableCell.h"
#import "ParserRequestTobeProcessed.h"
#import "SendRequestParse.h"

@interface UpcomingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,RequestTobeProcessedListDelegate, CancelFinishedDelegate>{
    Boolean ifFirst;
}

@property ParserRequestTobeProcessed *prtp;

@property (strong, nonatomic) NSMutableArray *upcomingLunchArray;
@property (weak, nonatomic) IBOutlet UITableView *upcomingtableview;

@property UIActivityIndicatorView *spinner;
@property UIRefreshControl *refreshControl;
@property UILabel *emptyLabel;

@property NSInteger upcomingCount;

- (IBAction)refreshAction:(id)sender;
@end
