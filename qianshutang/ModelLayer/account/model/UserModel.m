//
//  UserModel.m
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userName forKey:@"userName"];//departId
    [coder encodeObject:@(self.userID) forKey:@"userId"];
    [coder encodeObject:@(self.departId) forKey:@"departId"];
    [coder encodeObject:@(self.isLogin) forKey:@"isLogin"];
    [coder encodeObject:self.userNickName forKey:@"userNickName"];
    [coder encodeObject:self.headImageUrl forKey:@"headImageUrl"];
    [coder encodeObject:self.telephone forKey:@"telephone"];
    [coder encodeObject:@(self.type) forKey:@"type"];
    [coder encodeObject:self.wangYiToken forKey:@"wangYiToken"];
    [coder encodeObject:@(self.notificationNoDisturb) forKey:@"notificationNoDisturb"];
    [coder encodeObject:@(self.starCount) forKey:@"starCount"];
    [coder encodeObject:@(self.flowerCount) forKey:@"flowerCount"];
    [coder encodeObject:@(self.prizeCount) forKey:@"prizeCount"];
     [coder encodeObject:self.validityTime forKey:@"validityTime"];
     [coder encodeObject:self.gender forKey:@"gender"];
     [coder encodeObject:self.birthday forKey:@"birthday"];
     [coder encodeObject:self.city forKey:@"city"];
     [coder encodeObject:self.receiveAddress forKey:@"receiveAddress"];
     [coder encodeObject:self.receivePhoneNumber forKey:@"receivePhoneNumber"];
    [coder encodeObject:self.receiveName forKey:@"receiveName"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init] ) {
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.userID = [[coder decodeObjectForKey:@"userId"] intValue];
        self.departId = [[coder decodeObjectForKey:@"departId"] intValue];
        self.isLogin = [[coder decodeObjectForKey:@"isLogin"] boolValue];
        self.userNickName = [coder decodeObjectForKey:@"userNickName"];
        self.headImageUrl = [coder decodeObjectForKey:@"headImageUrl"];
        self.telephone = [coder decodeObjectForKey:@"telephone"];
        self.type = [[coder decodeObjectForKey:@"type"] intValue];
        self.wangYiToken = [coder decodeObjectForKey:@"wangYiToken"];
        self.notificationNoDisturb = [[coder decodeObjectForKey:@"notificationNoDisturb"] intValue];
        self.starCount = [[coder decodeObjectForKey:@"starCount"] intValue];
        self.flowerCount = [[coder decodeObjectForKey:@"flowerCount"] intValue];
        self.prizeCount = [[coder decodeObjectForKey:@"prizeCount"] intValue];
        self.validityTime = [coder decodeObjectForKey:@"validityTime"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.birthday = [coder decodeObjectForKey:@"birthday"];
        self.city = [coder decodeObjectForKey:@"city"];
        self.receiveAddress = [coder decodeObjectForKey:@"receiveAddress"];
        self.receivePhoneNumber = [coder decodeObjectForKey:@"receivePhoneNumber"];
        self.receiveName = [coder decodeObjectForKey:@"receiveName"];
        
    }
    return self;
}

@end
