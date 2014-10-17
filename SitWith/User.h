//
//  User.h
//
//  Created by Terry Yang on 8/18/14.
//  Copyright (c) 2014 SitWith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *user_id;
    NSString *name;
    NSString *gender;
    NSString *email;
    NSString *age;
}
// get methods
- (NSString *) getUser_id;

- (NSString *) getName;

- (NSString *) getEmail;

- (NSString *) getGender;

- (NSString *) getAge;

- (NSString *) getFirstName;


// set methods
-(void)setUser_id: (NSString *)input;

-(void)setName:(NSString *)input;

-(void)setEmail:(NSString *)input;

-(void)setGender:(NSString *)input;

-(void)setAge:(NSString *)input;

@property (strong,nonatomic) NSString *user_id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *gender;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *age;
@end
