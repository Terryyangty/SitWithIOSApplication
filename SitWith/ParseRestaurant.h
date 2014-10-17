//
//  ParseRestaurant.h
//  SitWith
//
//  Created by William Lutz on 8/22/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "SitWithAppDelegate.h"

@class ParseRestaurant;
@protocol RestaurantListDelegate <NSObject>
- (void) processCompleted: (ParseRestaurant *) sender;
- (void) connectionError: (ParseRestaurant *) sender;
@end

@interface ParseRestaurant : NSObject<NSXMLParserDelegate>{
    NSMutableArray *restaurantArray;
    NSMutableString *currentAddress;
    Restaurant *currentRestaurant;
    BOOL storingFlag; //whether the tag element exist
    NSMutableString *currentElementValue;
    BOOL errorParsing;
    NSString *currentMethod;
    //This allows the creating object to know when parsing has completed
    BOOL parsing;
    //This variable will be used to build up the data coming back from NSURLConnection
    NSMutableData *receivedData;
    
    
}

// Delegate to respond back
@property (nonatomic, weak)id <RestaurantListDelegate> _delegate;

-(void)parseAllRestaurants;

-(NSMutableArray *)getAllRestaurants;//instance method

-(void) parseStartElementRestaurant:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

-(void) parseEndElementRestaurant:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

-(void) parseFoundCharacterRestaurant:parser foundCharacters:(NSString *)string;


@end
