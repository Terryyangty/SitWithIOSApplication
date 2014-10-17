//
//  PastViewController.m
//  SitWith
//
//  Created by William Lutz on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "PastViewController.h"
#import "LunchTable.h"
#import "PastTableCell.h"
#import "ParserLunchTable.h"

@interface PastViewController ()

@end

@implementation PastViewController

@synthesize plt;
@synthesize spinner;
@synthesize refreshControl;

@synthesize emptyLabel;

@synthesize arrayCount;

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
    self.pasttableview.delegate = self;
    self.pasttableview.dataSource = self;
    
    //set up if the first time load
    ifFirst = YES;
    
    plt = [[ParserLunchTable alloc] init];
    [plt parsePastLunchTable];
    plt._pastlunchtabledelegate = self;
    
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
    [self.pasttableview addSubview:refreshControl];
    
    [self initiateEmptyLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pastLunchArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PastTableCell";
    //3
    PastTableCell *tablecell = (PastTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, HH:mm aaa"];
    
    LunchTable *lt = [self.pastLunchArray objectAtIndex:indexPath.row];
    
    tablecell.lunchtabletime.text = [dateFormatter stringFromDate:[lt getLunchtabletime]];
    tablecell.restaurant_name.text = [lt getRestaurant_name];
    NSString *email = @"1098021485@qq.com";
    NSMutableArray *nameList = [[NSMutableArray alloc] init];
    NSString *A_name = [lt getA_name];
    NSString *B_name = [lt getB_name];
    NSString *C_name = [lt getC_name];
    NSString *D_name = [lt getD_name];
    if([lt getA]!=email)    [nameList addObject:[lt getFirstName:A_name]];
    if([lt getB]!=email)    [nameList addObject:[lt getFirstName:B_name]];
    if([lt getC]!=email)    [nameList addObject:[lt getFirstName:C_name]];
    if([lt getD]!=email)    [nameList addObject:[lt getFirstName:D_name]];

    int i = 0;
    for(NSString *firstname in nameList){
        if(i==0)    tablecell.firstguy.text = firstname;
        if(i==1)    tablecell.secondguy.text = firstname;
        if(i==2)    tablecell.thirdguy.text = firstname;
        i++;
    }
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
    headerLabel.text = @"  Past SitWith lunch";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}

#pragma mark - parse Lunch table delegate
- (void) processCompleted: (ParserLunchTable *) sender{
    self.pastLunchArray = plt.getPastLunchTable;
    self.arrayCount = [self.pastLunchArray count];
    if(self.arrayCount == 0){
        [self EmptyLabel:true];
    }else{
        [self EmptyLabel:false];
    }
    [self.pasttableview reloadData];
    if(ifFirst){
        [spinner stopAnimating];
        ifFirst = NO;
    }else{
        [refreshControl endRefreshing];
    }
}

- (IBAction)refreshAction:(id)sender {
    [plt parsePastLunchTable];
    plt._pastlunchtabledelegate = self;
    
}

- (void) connectionError:(ParserLunchTable *)sender{
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
        emptyLabel.hidden = true;
    }else{
        emptyLabel.hidden = false;
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
