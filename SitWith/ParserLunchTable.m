//
//  ParserLunchTable.m
//  SitWith
//
//  Created by William Lutz on 8/21/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ParserLunchTable.h"


@implementation ParserLunchTable

-(void) parseNotFilledUpcomingLunchTable{
    NSString *serverURL = [NSString stringWithFormat:@"%@/getNotFilledUpcomingLunchTable?email=%@",serverAddress, userEmail];
    currentMethod = @"getNotFilledUpcomingLunchTable";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]] delegate:self];
    [urlConnection start];
}

-(NSMutableArray *)getNotFilledUpcomingLunchTable
{
    return upcomingLunchtableArrays;
}

-(void) parsePastLunchTable{
    NSString *serverURL = [NSString stringWithFormat:@"%@/getPastTableByUserEmail?email=%@",serverAddress, userEmail];
    currentMethod = @"getPastLunchTable";
    receivedData = [[NSMutableData alloc] init];
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]] delegate:self];
    [urlConnection start];
}

-(NSMutableArray *)getPastLunchTable{
    return pastLunchtableArrays;
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
}

//the connection has some errors
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if([currentMethod isEqual:@"getNotFilledUpcomingLunchTable"]){
        [self._notfilledlunchtabledelegate connectionError:self];
    }else if([currentMethod isEqual:@"getPastLunchTable"]){
        [self._pastlunchtabledelegate connectionError:self];
    }
}


// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([currentMethod isEqual:@"getNotFilledUpcomingLunchTable"]){
        [self parseStartElementNotFilledUpcomingLunchTable:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }else if ([currentMethod isEqual:@"getPastLunchTable"]){
        [self parseStartElementPastLunchTable:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }

}
// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([currentMethod isEqual:@"getNotFilledUpcomingLunchTable"]){
        [self parseEndElementNotFilledUpcomingLunchTable:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }else if([currentMethod isEqual:@"getPastLunchTable"]){
        [self parseEndElementPastLunchTable:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }
}

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if([currentMethod isEqual:@"getNotFilledUpcomingLunchTable"]){
        [self parseFoundCharacterNotFilledUpcomingLunchTable:parser foundCharacters:string];
    }else if([currentMethod isEqual:@"getPastLunchTable"]){
        
        [self parseFoundCharacterPastLunchTable:parser foundCharacters:string];
    }
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %@", [@([parseError code]) stringValue]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    errorParsing=YES;
}



-(void) parseStartElementNotFilledUpcomingLunchTable:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"LunchTables"]){
        upcomingLunchtableArrays = [[NSMutableArray alloc] init];
    }
    if([elementName isEqualToString:@"LunchTable"])
    {
        currentLunchTable = [[LunchTable alloc]init];
    }
}

-(void) parseEndElementNotFilledUpcomingLunchTable:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //till the end of the lunchtable list
    if ([elementName isEqualToString:@"LunchTables"]) {
        [self._notfilledlunchtabledelegate processCompleted:self];
    }
    
    if ([elementName isEqualToString:@"LunchTable"]) {
        [upcomingLunchtableArrays addObject:currentLunchTable];
        currentLunchTable = nil;
    }
    
    //remove the string's space
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"id"])
    {
        NSInteger lunchtable_id = [trimmedString integerValue];
        [currentLunchTable setLunchtable_id:lunchtable_id];
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        NSInteger restaurant_id = [trimmedString integerValue];
        [currentLunchTable setRestaurant_id:restaurant_id];
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        [currentLunchTable setRestaurant_name:trimmedString];
        
    }
    if([elementName isEqualToString:@"restaurant_picture"])
    {
        [currentLunchTable setRestaurant_picture:trimmedString];
    }
    
    if([elementName isEqualToString:@"count"])
    {
        NSInteger count = [trimmedString integerValue];
        [currentLunchTable setCount:count];
    }
    
    if([elementName isEqualToString:@"address"])
    {
        [currentLunchTable setAddress:currentElementValue];
    }
    
    if([elementName isEqualToString:@"availablebegintime"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
        NSDate *lunchtabletime = [dateFormat dateFromString:currentElementValue];
        [currentLunchTable setLunchtabletime:lunchtabletime];
    }
    //make the string empty
    [currentElementValue setString:@""];
}

-(void) parseFoundCharacterNotFilledUpcomingLunchTable:parser foundCharacters:(NSString *)string{
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
}

//This is for the past lunches
-(void) parseStartElementPastLunchTable:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"LunchTables"]){
        pastLunchtableArrays = [[NSMutableArray alloc] init];
    }
    if([elementName isEqualToString:@"LunchTable"])
    {
        currentLunchTable = [[LunchTable alloc]init];
    }
}

-(void) parseEndElementPastLunchTable:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //till the end of the lunchtable list
    if ([elementName isEqualToString:@"LunchTables"]) {
        [self._pastlunchtabledelegate processCompleted:self];
    }
    
    if ([elementName isEqualToString:@"LunchTable"]) {
        [pastLunchtableArrays addObject:currentLunchTable];
        currentLunchTable = nil;
    }
    
    //remove the string's space
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"id"])
    {
        
        NSInteger lunchtable_id = [trimmedString integerValue];
        [currentLunchTable setLunchtable_id:lunchtable_id];
    }
    if([elementName isEqualToString:@"restaurant_id"])
    {
        NSInteger restaurant_id = [trimmedString integerValue];
        [currentLunchTable setRestaurant_id:restaurant_id];
    }
    if([elementName isEqualToString:@"restaurant_name"])
    {
        [currentLunchTable setRestaurant_name:trimmedString];
    }
    if([elementName isEqualToString:@"availablebegintime"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
        NSDate *lunchtabletime = [dateFormat dateFromString:currentElementValue];
        [currentLunchTable setLunchtabletime:lunchtabletime];
    }
    
    if([elementName isEqualToString:@"a"])
    {
        [currentLunchTable setA:trimmedString];
    }
    if([elementName isEqualToString:@"b"])
    {
        [currentLunchTable setB:trimmedString];
    }
    if([elementName isEqualToString:@"c"])
    {
        [currentLunchTable setC:trimmedString];
    }
    if([elementName isEqualToString:@"d"])
    {
        [currentLunchTable setD:trimmedString];
    }
    if([elementName isEqualToString:@"aName"])
    {
        [currentLunchTable setA_name:trimmedString];
    }
    if([elementName isEqualToString:@"bName"])
    {
        [currentLunchTable setB_name:trimmedString];
    }
    if([elementName isEqualToString:@"cName"])
    {
        [currentLunchTable setC_name:trimmedString];
    }
    if([elementName isEqualToString:@"dName"])
    {
        [currentLunchTable setD_name:trimmedString];
    }
    
    //make the string empty
    [currentElementValue setString:@""];
}

-(void) parseFoundCharacterPastLunchTable:parser foundCharacters:(NSString *)string{
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
}
@end
