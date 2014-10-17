//
//  ParserRequestTobeProcessed.m
//  SitWith
//
//  Created by William Lutz on 8/21/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ParserRequestTobeProcessed.h"

@implementation ParserRequestTobeProcessed

@synthesize _delegate;

-(void) parseUpcmoingRequest{
    NSString *serverURL = [NSString stringWithFormat:@"%@/getUpcomingRequestTobeProcessedByEmail?email=%@",serverAddress, userEmail];
    parsing = true;
    //Initialise the receivedData object
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]] delegate:self];
    [urlConnection start];
};

-(NSMutableArray *)getUpcomingRequest
{
    return upcomingRequestTobeProcessedArray;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //Reset the data as this could be fired if a redirect or other response occurs
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //Append the received data each time this is called
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Start the XML parser with the delegate pointing at the current object
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
    [parser setDelegate:self];
    [parser parse];
    
    parsing = false;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    [self._delegate connectionError:self];
    
}



// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"RequestTobeProcessedList"]){
        upcomingRequestTobeProcessedArray = [[NSMutableArray alloc] init];
    }
    if([elementName isEqualToString:@"RequestTobeProcessed"])
    {
        currentRequestTobeProcessed = [[RequestTobeProcessed alloc]init];
    }
    
}
// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //if comes to the end of the xml
    if ([elementName isEqualToString:@"RequestTobeProcessedList"]) {
        [self._delegate processCompleted:self];
    }
    
    if ([elementName isEqualToString:@"RequestTobeProcessed"]) {
        [upcomingRequestTobeProcessedArray addObject:currentRequestTobeProcessed];

        currentRequestTobeProcessed = nil;
    }
    
    
    
    //remove the string's space
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"id"])
    {
        NSInteger requesttobeprocessed_id = [trimmedString integerValue];
        [currentRequestTobeProcessed setRequesttobeprocessed_id:requesttobeprocessed_id];
        
    }
    if([elementName isEqualToString:@"user_name"])
    {
        [currentRequestTobeProcessed setUser_name:trimmedString];
    
    }
    if([elementName isEqualToString:@"lunchtable_id"])
    {
        NSInteger lunchtable_id = [trimmedString integerValue];
        [currentRequestTobeProcessed setLunchtable_id:lunchtable_id];
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        NSInteger restaurant_id = [trimmedString integerValue];
        [currentRequestTobeProcessed setRestaurant_id:restaurant_id];
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        [currentRequestTobeProcessed setRestaurant_name:trimmedString];
    }
    if([elementName isEqualToString:@"lunchtabletime"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
        NSString *lunchtabletimeString = trimmedString;
        NSDate *lunchtabletime = [dateFormat dateFromString:lunchtabletimeString];
        [currentRequestTobeProcessed setLunchtabletime:lunchtabletime];
    }
    if([elementName isEqualToString:@"requestmadetime"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
        NSDate *requestmadetime = [dateFormat dateFromString:trimmedString];
        [currentRequestTobeProcessed setRequestmadetime:requestmadetime];
    }
    
    //make the string empty
    [currentElementValue setString:@""];
}

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
    
}

@end
