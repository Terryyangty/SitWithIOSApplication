//
//  CheckLogin.m
//  SitWith
//
//  Created by William Lutz on 8/29/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "CheckLogin.h"
#import "SitWithAppDelegate.h"

@implementation CheckLogin

-(Boolean) checklogin{
    if(authenticated)   return YES;
    else    return NO;
}
@end
