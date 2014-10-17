//
//  WebViewController.h
//  SitWith
//
//  Created by William Lutz on 9/4/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSString *urlString;
@end
