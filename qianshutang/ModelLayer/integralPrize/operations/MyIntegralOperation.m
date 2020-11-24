//
//  MyIntegralOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyIntegralOperation.h"

@interface MyIntegralOperation ()<HttpRequestProtocol>

@property (nonatomic,weak) id<Integral_MyIntegral> notifiedObject;

@property (nonatomic,weak) id<Integral_Teacher_memberPrize> Teacher_memberPrizenotifiedObject;
@property (nonatomic,weak) id<Integral_Teacher_haveSendIntegral> Teacher_haveSendIntegralnotifiedObject;
@property (nonatomic,weak) id<Integral_Teacher_CreateConvertPrizeRecord> Teacher_CreateConvertPrizeRecordnotifiedObject;
@property (nonatomic,weak) id<Integral_Teacher_sendGoods> Teacher_sendGoodsnotifiedObject;

@end

@implementation MyIntegralOperation

- (void)didRequestMyIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegral>)object
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustmyIntegralWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestTeacher_memberIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_memberPrize>)object
{
    self.Teacher_memberPrizenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_memberIntegralWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_haveSendIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_haveSendIntegral>)object
{
    self.Teacher_haveSendIntegralnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_haveSendIntegralWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_createConverPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_CreateConvertPrizeRecord>)object
{
    self.Teacher_CreateConvertPrizeRecordnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_CreateConvertPrizeRecordWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object
{
    self.Teacher_sendGoodsnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTeacher_sendGoodsWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 6:
            self.infoDic = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestMyIntegralSuccessed];
            }
            break;
        case 136:
            self.teacher_memberIntegralList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_memberPrizenotifiedObject)) {
                [self.Teacher_memberPrizenotifiedObject didRequestTeacher_memberPrizeSuccessed];
            }
            break;
        case 137:
            self.teacher_haveSendIntegralList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.Teacher_haveSendIntegralnotifiedObject)) {
                [self.Teacher_haveSendIntegralnotifiedObject didRequestTeacher_haveSendIntegralSuccessed];
            }
            break;
        case 138:
            if (isObjectNotNil(self.Teacher_CreateConvertPrizeRecordnotifiedObject)) {
                [self.Teacher_CreateConvertPrizeRecordnotifiedObject didRequestTeacher__CreateConvertPrizeRecordSuccessed];
            }
            break;
        case 139:
            if (isObjectNotNil(self.Teacher_sendGoodsnotifiedObject)) {
                [self.Teacher_sendGoodsnotifiedObject didRequestTeacher_sendGoodsSuccessed];
            }
            break;
            
        default:
            break;
    }
    
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestMyIntegralFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
        case 6:
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestMyIntegralFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
        case 136:
            if (isObjectNotNil(self.Teacher_memberPrizenotifiedObject)) {
                [self.Teacher_memberPrizenotifiedObject didRequestTeacher_memberPrizeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
        case 137:
            if (isObjectNotNil(self.Teacher_haveSendIntegralnotifiedObject)) {
                [self.Teacher_haveSendIntegralnotifiedObject didRequestTeacher_haveSendIntegralFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
        case 138:
            if (isObjectNotNil(self.Teacher_CreateConvertPrizeRecordnotifiedObject)) {
                [self.Teacher_CreateConvertPrizeRecordnotifiedObject didRequestTeacher__CreateConvertPrizeRecordFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
        case 139:
            if (isObjectNotNil(self.Teacher_sendGoodsnotifiedObject)) {
                [self.Teacher_sendGoodsnotifiedObject didRequestTeacher_sendGoodsFailed:[failedInfo objectForKey:kErrorMsg]];
            }
            break;
            
        default:
            break;
    }
    
}

@end
