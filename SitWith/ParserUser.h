//
//  ParserUser.h
//  SitWith
//
//  Created by William Lutz on 8/20/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SitWithAppDelegate.h"

@interface ParserUser : NSObject<NSXMLParserDelegate>

 //bool that represents whether or not parser is inside a user tag
@property BOOL parsingUserName;
// bool that represents whether or not parser found user based on the login
// name from facebook
@property BOOL foundUserName;

// function to search for user
- (BOOL)searchForUser;

@end
