//
//  UpcomingViewController.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "UpcomingViewController.h"
#import "RequestTobeProcessed.h"
#import "UpcomingTableCell.h"

@interface UpcomingViewController ()

@end

@implementation UpcomingViewController

@synthesize prtp;
@synthesize spinner;
@synthesize refreshControl;
@synthesize emptyLabel;

@synthesize upcomingtableview;

@synthesize upcomingCount;


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
    self.upcomingtableview.delegate = self;
    self.upcomingtableview.dataSource = self;
    
    //set it is the first time load this page
    ifFirst = YES;
    
    prtp = [[ParserRequestTobeProcessed alloc] init];
    [prtp parseUpcmoingRequest];
    prtp._delegate = self;
    //set up the spinner
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    //set up the refresh control
    refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    [self.upcomingtableview addSubview:refreshControl];
    
    [self initiateEmptyLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.upcomingLunchArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UpcomingTableCell";
    //3
    UpcomingTableCell *tablecell = (UpcomingTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, HH:mm aaa"];
    
    RequestTobeProcessed *rtp = [self.upcomingLunchArray objectAtIndex:indexPath.row];
    tablecell._cancelfinisheddelegate = self;
    tablecell.requesttobeprocessed = rtp;
    tablecell.lunchtabletime.text = [dateFormatter stringFromDate:[rtp getLunchtabletime]];
    tablecell.restaurant_name.text = [rtp getRestaurant_name];
    tablecell.requestmadetime.text = [dateFormatter stringFromDate:[rtp getRequestmadetime]];
    tablecell.cancelRequestTobeProcessedButton.tag = indexPath.row;
    //get the days ahead
    NSTimeInterval daysaheadTimeInterval = [[rtp getLunchtabletime]timeIntervalSinceNow];
    div_t d = div(daysaheadTimeInterval, 3600*24);
    int day = d.quot;
    tablecell.daysahead.text = [NSString stringWithFormat:@"%d", day];
    return tablecell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
    
    // 3. Add a label
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(0, 2, tableView.frame.size.width, 18);
    headerLabel.backgroundColor = [UIColor brownColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    headerLabel.text = @"  Upcoming SitWith Lunch";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}


- (IBAction)refreshAction:(id)sender {
    [prtp parseUpcmoingRequest];
    prtp._delegate = self;

}

#pragma mark - ParseRequestTobeProcessed delegate
- (void) processCompleted: (ParserRequestTobeProcessed *) sender{
    self.upcomingLunchArray = prtp.getUpcomingRequest;
    self.upcomingCount = [self.upcomingLunchArray count];
    [self.upcomingtableview reloadData];
    if(ifFirst){
        [spinner stopAnimating];
        ifFirst = NO;
    }else{
        [refreshControl endRefreshing];
    }
    if(self.upcomingCount==0){
        [self EmptyLabel:false];
    }else{
        [self EmptyLabel:true];
    }
}

#pragma mark - Cancel finished delegate
- (void) cancelFinished: (UpcomingTableCell *) sender{
    [prtp parseUpcmoingRequest];
    prtp._delegate = self;
    //set up the spinner
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    ifFirst = YES;
}

- (void) connectionError:(SendRequestParse *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [spinner stopAnimating];
}

-(void) EmptyLabel:(Boolean)hide{
    
    if(!hide){
        emptyLabel.hidden = false;
    }else{
        emptyLabel.hidden = true;
    }
}

-(void) initiateEmptyLabel{
    emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 200, 200)];
    NSString *emptyText = @"This is where your upcoming lunch will appear. But first you should start one";
    emptyLabel.numberOfLines = 0;
    emptyLabel.text = emptyText;
    [self.view addSubview:emptyLabel]; // add label to the cell
    emptyLabel.hidden = true;
}

@end
