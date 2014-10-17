//
//  ParseRestaurant.m
//  SitWith
//
//  Created by William Lutz on 8/22/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import "ParseRestaurant.h"

@implementation ParseRestaurant

@synthesize _delegate;

-(void)parseAllRestaurants{
    currentMethod = @"getAllRestaurants";
    NSString *serverURL = [NSString stringWithFormat:@"%@/getRestaurants",serverAddress];
    //Set the status to parsing
    parsing = true;
    
    //Initialise the receivedData object
    receivedData = [[NSMutableData alloc] init];
    
    //Create the connection with the string URL and kick it off
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:serverURL]] delegate:self];
    [urlConnection start];
}

-(NSMutableArray *)getAllRestaurants{
    return restaurantArray;
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

// function called when parser reaches the beginning of an element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([currentMethod isEqual:@"getAllRestaurants"]){
        [self parseStartElementRestaurant:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
    }
    
}
// parser reached the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([currentMethod isEqual:@"getAllRestaurants"]){
        [self parseEndElementRestaurant:parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
    }
}

// this handles the characters between the XML tags
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if([currentMethod isEqual:@"getAllRestaurants"]){
        [self parseFoundCharacterRestaurant:parser foundCharacters:string];
    }
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %@", [@([parseError code]) stringValue]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    errorParsing=YES;
}



-(void) parseStartElementRestaurant:parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"Restaurants"]){
        restaurantArray = [[NSMutableArray alloc] init];
    }
    if([elementName isEqualToString:@"Restaurant"])
    {
        currentRestaurant = [[Restaurant alloc]init];
    }
}

-(void) parseEndElementRestaurant:parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"Restaurant"]) {
        [restaurantArray addObject:currentRestaurant];
        currentRestaurant = nil;
    }
    
    if ([elementName isEqualToString:@"Restaurants"]) {
        [self._delegate processCompleted:self];
    }
    
    
    
    //remove the string's space
    NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([elementName isEqualToString:@"id"])
    {
        NSInteger restaurant_id = [trimmedString integerValue];
        [currentRestaurant setRestaurant_id:restaurant_id];
    }
    if([elementName isEqualToString:@"name"])
    {
        [currentRestaurant setName:trimmedString];
    }
    if([elementName isEqualToString:@"city"])
    {
        [currentRestaurant setCity:trimmedString];
        
    }
    if([elementName isEqualToString:@"neighborhood"])
    {
        [currentRestaurant setNeighborhood:trimmedString];
        
    }
    if([elementName isEqualToString:@"address"])
    {
        [currentRestaurant setAddress:trimmedString];
    }
    if([elementName isEqualToString:@"hours"])
    {
        [currentRestaurant setHours:trimmedString];
    }
    if([elementName isEqualToString:@"picture"])
    {
        [currentRestaurant setPicture:trimmedString];
    }
    if([elementName isEqualToString:@"yelp_url"])
    {
        [currentRestaurant setYelp_url:trimmedString];
    }
    
    //make the string empty
    [currentElementValue setString:@""];
}

-(void) parseFoundCharacterRestaurant:parser foundCharacters:(NSString *)string{
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
}



@end
