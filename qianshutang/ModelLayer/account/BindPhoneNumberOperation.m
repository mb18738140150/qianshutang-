//
//  BindPhoneNumberOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/19.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BindPhoneNumberOperation.h"

@interface BindPhoneNumberOperation ()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserInfo_BindPhoneNumber> notifiedObject;

@end

@implementation BindPhoneNumberOperation

- (void)didRequestBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustBindPhoneBunberWith:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestBindPhoneNumberSuccessed];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestBindPhoneNumberFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end
