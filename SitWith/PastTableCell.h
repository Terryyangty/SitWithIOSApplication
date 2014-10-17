//
//  PastTableCell.h
//  SitWith
//
//  Created by William Lutz on 8/19/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lunchtabletime;
@property (weak, nonatomic) IBOutlet UILabel *firstguy;
@property (weak, nonatomic) IBOutlet UILabel *secondguy;
@property (weak, nonatomic) IBOutlet UILabel *thirdguy;
@property (weak, nonatomic) IBOutlet UILabel *restaurant_name;


@end
