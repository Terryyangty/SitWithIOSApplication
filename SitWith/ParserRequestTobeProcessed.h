//
//  ParserRequestTobeProcessed.h
//  SitWith
//
//  Created by William Lutz on 8/21/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestTobeProcessed.h"
#import "SitWithAppDelegate.h"

@class ParserRequestTobeProcessed;
@protocol RequestTobeProcessedListDelegate <NSObject>
- (void) processCompleted: (ParserRequestTobeProcessed *)sender;
- (void) connectionError: (ParserRequestTobeProcessed *)sender;
@end

@interface ParserRequestTobeProcessed: NSObject <NSXMLParserDelegate>{
    NSMutableArray *upcomingRequestTobeProcessedArray;
    NSMutableString *currentAddress;
    RequestTobeProcessed *currentRequestTobeProcessed;
    BOOL storingFlag; //whether the tag element exist
    NSMutableString *currentElementValue;
    BOOL errorParsing;
    //This allows the creating object to know when parsing has completed
    BOOL parsing;
    //This variable will be used to build up the data coming back from NSURLConnection
    NSMutableData *receivedData;
}

@property (nonatomic, weak)id <RequestTobeProcessedListDelegate> _delegate;

-(void) parseUpcmoingRequest;

-(NSMutableArray *)getUpcomingRequest;
@end
