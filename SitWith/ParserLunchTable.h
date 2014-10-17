//
//  ParserLunchTable.h
//  SitWith
//
//  Created by William Lutz on 8/21/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LunchTable.h"
#import "SitWithAppDelegate.h"


@class ParserLunchTable;
@protocol PastLunchTableDelegate <NSObject>
- (void) processCompleted: (ParserLunchTable *)sender;
- (void) connectionError: (ParserLunchTable *)sender;
@end

@class ParserLunchTable;
@protocol NotFilledUpcomingLunchTableDelegate <NSObject>
- (void) processCompleted: (ParserLunchTable *)sender;
- (void) connectionError: (ParserLunchTable *)sender;
@end

@interface ParserLunchTable : NSObject <NSXMLParserDelegate>{
    NSMutableArray *upcomingLunchtableArrays;
    NSMutableArray *pastLunchtableArrays;
    NSMutableString *currentAddress;
    LunchTable *currentLunchTable;
    BOOL storingFlag; //whether the tag element exist
    NSMutableString *currentElementValue;
    BOOL errorParsing;
    NSString *currentMethod;
    //This variable will be used to build up the data coming back from NSURLConnection
    NSMutableData *receivedData;
}

@property (nonatomic, weak)id <PastLunchTableDelegate> _pastlunchtabledelegate;
@property (nonatomic, weak)id <NotFilledUpcomingLunchTableDelegate> _notfilledlunchtabledelegate;

-(void) parseNotFilledUpcomingLunchTable;
-(NSMutableArray *)getNotFilledUpcomingLunchTable;
-(void) parsePastLunchTable;
-(NSMutableArray *)getPastLunchTable;

-(void) parseStartElementNotFilledUpcomingLunchTable:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementNotFilledUpcomingLunchTable:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterNotFilledUpcomingLunchTable:parser foundCharacters:(NSString *)string;

//past lunch parse method
-(void) parseStartElementPastLunchTable:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementPastLunchTable:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterPastLunchTable:parser foundCharacters:(NSString *)string;
@end
