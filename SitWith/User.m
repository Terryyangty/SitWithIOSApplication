//
//  User.m
//
//  Created by Terry Yang on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//
// Class for SitWith users

#import "User.h"

@implementation User
@synthesize name, email, gender, age, user_id;
// get methods
- (NSString *) getUser_id
{
    return name;
}

- (NSString *) getName
{
    return name;
}

- (NSString *) getEmail {
    return email;
}

- (NSString *) getGender
{
    return gender;
}

- (NSString *) getAge
{
    return age;
}


- (NSString *) getFirstName
{
    NSString *entireName = [self name];
    NSMutableString *firstName = (NSMutableString *)@"";
    NSInteger nameLength = entireName.length;
    for (int i = 0; i < nameLength; i+= 1) {
        if ([[entireName substringWithRange:NSMakeRange(i,1)] isEqualToString:@" "]) {
            return firstName;
        }
        else
        {
            [firstName appendString:[entireName substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return firstName;
}

// set methods
-(void)setUser_id:(NSString *)input{
    user_id = input;
}

-(void)setName:(NSString *)input
{
    name = input;
}

-(void)setEmail:(NSString *)input
{
    email = input;
}
-(void)setGender:(NSString *)input
{
    gender = input;
}
-(void)setAge:(NSString *)input
{
    age = input;
}

@end
