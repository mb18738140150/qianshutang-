//
//  LoginStatusOperation.m
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "LoginStatusOperation.h"
#import "HttpRequestManager.h"
#import "PathUtility.h"
#import "NTESLoginManager.h"
@interface LoginStatusOperation ()

@property (nonatomic,weak) id<UserModule_LoginProtocol>          loginNotifiedObject;

@property (nonatomic,weak) UserModel                            *userModel;

@end

@implementation LoginStatusOperation

- (void)clearLoginUserInfo
{
    self.userModel.userID = 0;
    self.userModel.departId = 0;
    self.userModel.userName = @"";
    self.userModel.isLogin = NO;
    self.userModel.userNickName = @"";
    self.userModel.headImageUrl = @"";
    self.userModel.telephone = @"";
    self.userModel.wangYiToken = @"";
    self.userModel.notificationNoDisturb = 0;
    self.userModel.starCount = 0;
    self.userModel.flowerCount = 0;
    self.userModel.prizeCount = 0;
    self.userModel.validityTime = @"";
    self.userModel.gender = @"";
    self.userModel.birthday = @"";
    self.userModel.city = @"";
    self.userModel.receivePhoneNumber = @"";
    self.userModel.receiveAddress = @"";
    self.userModel.receiveName = @"";
    self.userModel.type = 0;
    
    [self encodeUserInfo];
}

- (void)setCurrentUser:(UserModel *)user
{
    self.userModel = user;
}

- (void)didLoginWithUserName:(NSString *)userName andPassword:(NSString *)password withNotifiedObject:(id<UserModule_LoginProtocol>)object
{
//    self.userModel.userName = userName;
    self.loginNotifiedObject = object;
    [[HttpRequestManager sharedManager] requestLoginWithUserName:userName andPassword:password andProcessDelegate:self];
}

- (void)encodeUserInfo
{
    NSString *dataPath = [[PathUtility getDocumentPath] stringByAppendingPathComponent:@"user.data"];
    [NSKeyedArchiver archiveRootObject:self.userModel toFile:dataPath];
}

#pragma mark - request delegate
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    NSLog(@"successInfo = %@", successInfo);
    NSDictionary * basicInfo = [successInfo objectForKey:@"config"];
    successInfo = [successInfo objectForKey:@"data"];
    self.userModel.userID = [[successInfo objectForKey:@"userId"] intValue];
    self.userModel.departId = [[successInfo objectForKey:@"departId"] intValue];
    if ([[successInfo objectForKey:@"userName"] class] == [NSNull class] || [successInfo objectForKey:@"userName"] == nil || [[successInfo objectForKey:@"userName"] isEqualToString:@""]) {
        self.userModel.userName = @"学员";
    }else{
        self.userModel.userName = [successInfo objectForKey:@"userName"];
    }
    if ([[successInfo objectForKey:@"nickName"] class] == [NSNull class] || [successInfo objectForKey:@"nickName"] == nil || [[successInfo objectForKey:@"nickName"] isEqualToString:@""]) {
        self.userModel.userNickName = @"学员";
    }else{
        self.userModel.userNickName = [successInfo objectForKey:@"nickName"];
    }
    if ([[successInfo objectForKey:@"icon"] class] == [NSNull class] || [successInfo objectForKey:@"icon"] == nil || [[successInfo objectForKey:@"icon"] isEqualToString:@""]) {
        self.userModel.headImageUrl = @"";
    }else{
        self.userModel.headImageUrl = [successInfo objectForKey:@"icon"];
    }
    
    if ([[successInfo objectForKey:@"telephone"] class] == [NSNull class] || [successInfo objectForKey:@"telephone"] == nil || [[successInfo objectForKey:@"telephone"] isEqualToString:@""]) {
        self.userModel.telephone = @"未绑定";
    }else{
        self.userModel.telephone = [successInfo objectForKey:@"telephone"];
    }
    if ([[successInfo objectForKey:kvalidityTime] class] == [NSNull class] || [successInfo objectForKey:kvalidityTime] == nil || [[successInfo objectForKey:kvalidityTime] isEqualToString:@""]) {
        self.userModel.validityTime = @"";
    }else{
        self.userModel.validityTime = [successInfo objectForKey:kvalidityTime];
    }
    if ([[successInfo objectForKey:kgender] class] == [NSNull class] || [successInfo objectForKey:kgender] == nil || [[successInfo objectForKey:kgender] isEqualToString:@""]) {
        self.userModel.gender = @"";
    }else{
        self.userModel.gender = [successInfo objectForKey:kgender];
    }
    if ([[successInfo objectForKey:kbirthday] class] == [NSNull class] || [successInfo objectForKey:kbirthday] == nil || [[successInfo objectForKey:kbirthday] isEqualToString:@""]) {
        self.userModel.birthday = @"";
    }else{
        self.userModel.birthday = [successInfo objectForKey:kbirthday];
    }
    if ([[successInfo objectForKey:kCity] class] == [NSNull class] || [successInfo objectForKey:kCity] == nil || [[successInfo objectForKey:kCity] isEqualToString:@""]) {
        self.userModel.city = @"";
    }else{
        self.userModel.city = [successInfo objectForKey:kCity];
    }
    if ([[successInfo objectForKey:kreceiveAddress] class] == [NSNull class] || [successInfo objectForKey:kreceiveAddress] == nil || [[successInfo objectForKey:kreceiveAddress] isEqualToString:@""]) {
        self.userModel.receiveAddress = @"";
    }else{
        self.userModel.receiveAddress = [successInfo objectForKey:kreceiveAddress];
    }
    if ([[successInfo objectForKey:@"phoneNumber"] class] == [NSNull class] || [successInfo objectForKey:@"phoneNumber"] == nil || [[successInfo objectForKey:@"phoneNumber"] isEqualToString:@""]) {
        self.userModel.receivePhoneNumber = @"";
    }else{
        self.userModel.receivePhoneNumber = [successInfo objectForKey:@"phoneNumber"];
    }
    if ([[successInfo objectForKey:kreceiveName] class] == [NSNull class] || [successInfo objectForKey:kreceiveName] == nil || [[successInfo objectForKey:kreceiveName] isEqualToString:@""]) {
        self.userModel.receiveName = @"";
    }else{
        self.userModel.receiveName = [successInfo objectForKey:kreceiveName];
    }
    
    self.userModel.notificationNoDisturb = [[successInfo objectForKey:knotificationNoDisturb] intValue];
    self.userModel.starCount = [[successInfo objectForKey:kStarCount] intValue];
    self.userModel.flowerCount = [[successInfo objectForKey:kFlowerCount] intValue];
    self.userModel.prizeCount = [[successInfo objectForKey:kPrizeCount] intValue];
    self.userModel.score = [[successInfo objectForKey:kScore] intValue];
    self.userModel.type = [[successInfo objectForKey:@"type"] intValue];
    self.userModel.wangYiToken = [successInfo objectForKey:@"token"];
    
    NTESLoginData *sdkData = [[NTESLoginData alloc] init];
    sdkData.account   = [NSString stringWithFormat:@"%d", self.userModel.userID];
    sdkData.token     = self.userModel.wangYiToken;
    if ([[sdkData.token class] isEqual:[NSNull class]]) {
        sdkData.token = @"";
    }
    [[NTESLoginManager sharedManager] setCurrentNTESLoginData:sdkData];
    
    self.userModel.isLogin = YES;
    
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginSuccessed];
    }
    
    [self encodeUserInfo];
    
    
    
    if ([[basicInfo objectForKey:@"shareUrl"] class] == [NSNull class] || [basicInfo objectForKey:@"shareUrl"] == nil || [[basicInfo objectForKey:@"shareUrl"] isEqualToString:@""]) {
        self.userModel.shareUrl = @"";
    }else{
        self.userModel.shareUrl = [basicInfo objectForKey:@"shareUrl"];
    }
    
    if ([[basicInfo objectForKey:@"logo"] class] == [NSNull class] || [basicInfo objectForKey:@"logo"] == nil || [[basicInfo objectForKey:@"logo"] isEqualToString:@""]) {
        self.userModel.logo = @"";
    }else{
        self.userModel.logo = [basicInfo objectForKey:@"logo"];
    }
    
    if ([[basicInfo objectForKey:@"coverImg"] class] == [NSNull class] || [basicInfo objectForKey:@"coverImg"] == nil || [[basicInfo objectForKey:@"coverImg"] isEqualToString:@""]) {
        self.userModel.coverImg = @"";
    }else{
        self.userModel.coverImg = [basicInfo objectForKey:@"coverImg"];
    }
    self.userModel.iconList = [basicInfo objectForKey:@"iconList"];
    
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (self.loginNotifiedObject != nil) {
        [self.loginNotifiedObject didUserLoginFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end
