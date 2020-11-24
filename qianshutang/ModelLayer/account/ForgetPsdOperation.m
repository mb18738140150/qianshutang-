//
//  ForgetPsdOperation.m
//  Accountant
//
//  Created by aaa on 2017/9/13.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "ForgetPsdOperation.h"
#import "HttpRequestManager.h"
#import "HttpRequestProtocol.h"

@interface ForgetPsdOperation ()<HttpRequestProtocol>

@property (nonatomic,weak) id<UserModule_ForgetPasswordProtocol> notifiedObject;

@end

@implementation ForgetPsdOperation

- (void)didRequestForgetPsdWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<UserModule_ForgetPasswordProtocol>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustForgetPasswordWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didForgetPasswordSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didForgetPasswordFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (self.notifiedObject != nil) {
        [self.notifiedObject didForgetPasswordFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end
