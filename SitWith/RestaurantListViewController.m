//
//  RestaurantListViewController.m
//  SitWith
//
//  Created by Terry Yang on 8/22/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "RestaurantCell.h"
#import "ParseRestaurant.h"
#import "RestaurantDetailViewController.h"

@interface RestaurantListViewController ()

@end

@implementation RestaurantListViewController

@synthesize restaurantArray;
@synthesize restaurantTableView;
@synthesize spinner;

@synthesize pr;

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
    self.restaurantTableView.delegate = self;
    self.restaurantTableView.dataSource = self;
    
    //start parsing the data
    pr = [[ParseRestaurant alloc] init];
    pr._delegate = self;
    [pr parseAllRestaurants];
    //set up the spinner
    spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurantArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"RestaurantListCell";
    RestaurantCell *tablecell = (RestaurantCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Restaurant *r = [self.restaurantArray objectAtIndex:indexPath.row];
    tablecell = [tablecell setRestaurantCell:r];
    [tablecell setAccessoryType:UITableViewCellAccessoryNone];
    return tablecell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRestaurantDetail"]) {
        NSIndexPath *indexPath = [restaurantTableView indexPathForSelectedRow];
        RestaurantDetailViewController *destViewController = segue.destinationViewController;
        destViewController.r = [self.restaurantArray objectAtIndex:indexPath.row];
        
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark - TestParse delegate
- (void) processCompleted: (ParseRestaurant *) sender{
    self.restaurantArray = pr.getAllRestaurants;
    [self.restaurantTableView reloadData];
    [spinner stopAnimating];
}

- (void) connectionError:(ParseRestaurant *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                    message:@"There's something wrong with your network, please try again or check your settings"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [spinner stopAnimating];
}
@end
