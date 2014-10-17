//
//  SendRequestParse.h
//  SitWith
//
//  Created by William Lutz on 9/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SendRequestParse;
@protocol JoinLunchTableDelegate <NSObject>
- (void) joinCompleted: (SendRequestParse *)sender;
- (void) joinConnectionError: (SendRequestParse *)sender;
@end

@class SendRequestParse;
@protocol cancelFromLunchTableDelegate <NSObject>
- (void) cancelCompleted: (SendRequestParse *)sender;
- (void) cancelConnectionError: (SendRequestParse *)sender;
@end

@class SendRequestParse;
@protocol createLunchTableDelegate <NSObject>
- (void) createCompleted: (SendRequestParse *)sender;
- (void) createConnectionError: (SendRequestParse *)sender;
@end

@interface SendRequestParse : NSObject <NSXMLParserDelegate>{
    NSMutableString *currentElementValue;
    NSString *currentMethod;
    //This variable will be used to build up the data coming back from NSURLConnection
    NSMutableData *receivedData;
    //This is the method that return from the server
    NSString *sendRequestResult;
}

@property (nonatomic, weak)id <JoinLunchTableDelegate> _joinlunchtabledelegate;
@property (nonatomic, weak)id <createLunchTableDelegate> _createlunchtabledelegate;
@property (nonatomic, weak)id <cancelFromLunchTableDelegate> _cancelfromlunchtabledelegate;


-(void) joinLunchTableParse:(NSString *)lunchtable_id restaurantId:(NSString *)restaurant_id restaurantName:(NSString *)restaurant_name Lunchtabletime:(NSString *)lunchtabletime;
-(NSString *)getJoinLunchTableResult;
//cancel the request you have made
-(void) cancelFromLunchTableParse:(NSString *)lunchtable_id requesttobeprocessedId:(NSString *)requesttobeprocessed_id;

//create the lunch table
-(void) createLunchTableParse:(NSString *)restaurant_id restaurantName:(NSString *)restaurant_name availablebeginTime:(NSString *)availablebegintime;
-(NSString *)getCreateLunchTableResult;

//create the user (called every time logged in)
-(void) createUser;

//below is the method to parse the result xml
-(void) parseStartElementJoinLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementJoinLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterJoinLunchTableParse:parser foundCharacters:(NSString *)string;

-(void) parseStartElementCancelFromLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementCancelFromLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterCancelFromLunchTableParse:parser foundCharacters:(NSString *)string;

-(void) parseStartElementCreateLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementCreateLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterCreateLunchTableParse:parser foundCharacters:(NSString *)string;
@end
