//
//  SitWithViewController.h
//  SitWith
//
//  Created by William Lutz on 8/29/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SitWithAppDelegate.h"
#import "SendRequestParse.h"

@interface LoginViewController : UIViewController<FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *permissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *useLabe;
@property (weak, nonatomic) IBOutlet FBLoginView *fbloginview;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property SendRequestParse *srp;
@end
