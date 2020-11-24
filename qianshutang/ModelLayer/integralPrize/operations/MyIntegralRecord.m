//
//  MyIntegralRecord.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyIntegralRecord.h"

@interface MyIntegralRecord()<HttpRequestProtocol>

@property (nonatomic,weak) id<Integral_MyIntegralRecord> notifiedObject;
@end

@implementation MyIntegralRecord

- (void)didRequestMyIntegralRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegralRecord>)object;
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustmyIntegralRecordWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.infoDic = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestMyIntegralRecordSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestMyIntegralRecordFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestMyIntegralRecordFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end
