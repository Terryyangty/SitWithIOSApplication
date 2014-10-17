//
//  SendRequestParse.m
//  SitWith
//
//  Created by William Lutz on 9/1/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "SendRequestParse.h"
#import "SitWithAppDelegate.h"

@implementation SendRequestParse

-(void) joinLunchTableParse:(NSString *)lunchtable_id restaurantId:(NSString *)restaurant_id restaurantName:(NSString *)restaurant_name Lunchtabletime:(NSString *)lunchtabletime{
    NSString *serverURL = [NSString stringWithFormat:@"%@/addRequestTobeProcessed?lunchtable_id=%@&restaurant_id=%@&restaurant_name=%@&email=%@&user_name=%@&lunchtabletime=%@",serverAddress, lunchtable_id, restaurant_id, restaurant_name, userEmail, userName, lunchtabletime];
    serverURL = [serverURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentMethod = @"JoinLunchTableParse";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0] delegate:self];
    [urlConnection start];
}
-(NSString *)getJoinLunchTableResult{
    return sendRequestResult;
}

-(void) cancelFromLunchTableParse:(NSString *)lunchtable_id requesttobeprocessedId:(NSString *)requesttobeprocessed_id{
    NSString *serverURL = [NSString stringWithFormat:@"%@/deleteRequesttobeprocessed?requesttobeprocessed_id=%@&lunchtable_id=%@&email=%@",serverAddress, requesttobeprocessed_id, lunchtable_id, userEmail];
    serverURL = [serverURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentMethod = @"CancelFromLunchTableParse";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0] delegate:self ];
    [urlConnection start];
}


-(void) createLunchTableParse:(NSString *)restaurant_id restaurantName:(NSString *)restaurant_name availablebeginTime:(NSString *)availablebegintime{
    NSString *serverURL = [NSString stringWithFormat:@"%@/createLunchTableWithJoin?restaurant_id=%@&restaurant_name=%@&availablebegintime=%@&email=%@&user_name=%@",serverAddress, restaurant_id, restaurant_name, availablebegintime, userEmail, userName];
    serverURL = [serverURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentMethod = @"CreateLunchTableParse";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0] delegate:self];
    [urlConnection start];
}
-(NSString *)getCreateLunchTableResult{
    return sendRequestResult;
}

//create the user every time logged in
-(void)createUser
{
    NSString *serverURL = [NSString stringWithFormat:@"%@/createNewUser?user_id=%@&name=%@&age=%@&email=%@&gender=%@",serverAddress, userID, userName, [@(userAge) stringValue],userEmail, userGender];
    serverURL = [serverURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentMethod = @"CreateUser";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]] delegate:self];
    [urlConnection start];
}


//this is the method for the asynchronous of the NSURLConnection
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
}

//the connection has some errors
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if([currentMethod isEqual:@"JoinLunchTableParse"]){
        [self._joinlunchtabledelegate joinConnectionError:self];
    }else if([currentMethod isEqual:@"CancelFromLunchTableParse"]){
        [self._cancelfromlunchtabledelegate cancelConnectionError:self];
    }else if([currentMethod isEqual:@"CreateLunchTableParse"]){
        [self._createlunchtabledelegate createConnectionError:self];
    }
}


// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([currentMethod isEqual:@"JoinLunchTableParse"]){
        [self parseStartElementJoinLunchTableParse:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }else if ([currentMethod isEqual:@"CancelFromLunchTableParse"]){
        [self parseStartElementCancelFromLunchTableParse:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }else if ([currentMethod isEqual:@"CreateLunchTableParse"]){
        [self parseStartElementCreateLunchTableParse:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }
    
}
// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([currentMethod isEqual:@"JoinLunchTableParse"]){
        [self parseEndElementJoinLunchTableParse:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }else if([currentMethod isEqual:@"CancelFromLunchTableParse"]){
        [self parseEndElementCancelFromLunchTableParse:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }else if([currentMethod isEqual:@"CreateLunchTableParse"]){
        [self parseEndElementCreateLunchTableParse:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }
}

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if([currentMethod isEqual:@"JoinLunchTableParse"]){
        [self parseFoundCharacterJoinLunchTableParse:parser foundCharacters:string];
    }else if([currentMethod isEqual:@"CancelFromLunchTableParse"]){
        
        [self parseFoundCharacterCancelFromLunchTableParse:parser foundCharacters:string];
    }else if([currentMethod isEqual:@"CreateLunchTableParse"]){
        
        [self parseFoundCharacterCreateLunchTableParse:parser foundCharacters:string];
    }
}

//below is the method to parse the result xml
//parse for the join lunchtable
-(void) parseStartElementJoinLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

}

-(void) parseEndElementJoinLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"AddResult"])
    {
        sendRequestResult = trimmedString;
        [self._joinlunchtabledelegate joinCompleted:self];
    }
    
}

-(void) parseFoundCharacterJoinLunchTableParse:parser foundCharacters:(NSString *)string{

}

//parse for the cancel lunchtable
-(void) parseStartElementCancelFromLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

}

-(void) parseEndElementCancelFromLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"DeleteResult"])
    {
        sendRequestResult = trimmedString;
        [self._cancelfromlunchtabledelegate cancelCompleted:self];
    }
}

-(void) parseFoundCharacterCancelFromLunchTableParse:parser foundCharacters:(NSString *)string{

}

//parse for the create lunch table
-(void) parseStartElementCreateLunchTableParse:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

}

-(void) parseEndElementCreateLunchTableParse:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"CreateResult"])
    {
        sendRequestResult = trimmedString;
        [self._createlunchtabledelegate createCompleted:self];
    }
}

-(void) parseFoundCharacterCreateLunchTableParse:parser foundCharacters:(NSString *)string{

}

@end
