//
//  PastViewController.h
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserLunchTable.h"

@interface PastViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,PastLunchTableDelegate>{
    Boolean ifFirst;
}

@property (weak, nonatomic) IBOutlet UITableView *pasttableview;
@property (strong, nonatomic) NSMutableArray *pastLunchArray;

//the parser of the lunchtable
@property ParserLunchTable *plt;
@property UIActivityIndicatorView *spinner;

@property UIRefreshControl *refreshControl;
@property UILabel *emptyLabel;

@property NSInteger arrayCount;

- (IBAction)refreshAction:(id)sender;

@end
