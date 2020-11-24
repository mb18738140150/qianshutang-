//
//  ConvertPrizeOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ConvertPrizeOperation.h"
@interface ConvertPrizeOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<Integral_ConvertPrize> ConvertPrizenotifiedObject;
@property (nonatomic,weak) id<Integral_ConvertPrizeRecord> ConvertPrizeRecordnotifiedObject;
@property (nonatomic,weak) id<Integral_CancelConvertPrize> CancelConvertPrizenotifiedObject;
@property (nonatomic,weak) id<Integral_ComplateConvertPrize> ComplateConvertPrizenotifiedObject;


@end

@implementation ConvertPrizeOperation

- (void)didRequestConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrize>)object
{
    self.ConvertPrizenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustConvertPrizeWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestConvertPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrizeRecord>)object
{
    self.ConvertPrizeRecordnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustConvertPrizeRecordWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestCancelConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_CancelConvertPrize>)object
{
    self.CancelConvertPrizenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustCancelConvertPrizeWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestComplateConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ComplateConvertPrize>)object
{
    self.ComplateConvertPrizenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustComplateConvertPrizeWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 9:
            {
                if (isObjectNotNil(self.ConvertPrizenotifiedObject)) {
                    [self.ConvertPrizenotifiedObject didRequestConvertPrizeSuccessed];
                }
            }
            break;
        case 10:
        {
            self.convertPrizeRecordList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.ConvertPrizeRecordnotifiedObject)) {
                [self.ConvertPrizeRecordnotifiedObject didRequestConvertPrizeRecordSuccessed];
            }
        }
            break;
        case 11:
        {
            if (isObjectNotNil(self.CancelConvertPrizenotifiedObject)) {
                [self.CancelConvertPrizenotifiedObject didRequestCancelConvertPrizeSuccessed];
            }
        }
            break;
        case 12:
        {
            self.ComplateConvertPrizeList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.ComplateConvertPrizenotifiedObject)) {
                [self.ComplateConvertPrizenotifiedObject didRequestComplateConvertPrizeSuccessed];
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
        case 9:
        {
            if (isObjectNotNil(self.ConvertPrizenotifiedObject)) {
                [self.ConvertPrizenotifiedObject didRequestConvertPrizeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 10:
        {
            if (isObjectNotNil(self.ConvertPrizeRecordnotifiedObject)) {
                [self.ConvertPrizeRecordnotifiedObject didRequestConvertPrizeRecordFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 11:
        {
            if (isObjectNotNil(self.CancelConvertPrizenotifiedObject)) {
                [self.CancelConvertPrizenotifiedObject didRequestCancelConvertPrizeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 12:
        {
            if (isObjectNotNil(self.ComplateConvertPrizenotifiedObject)) {
                [self.ComplateConvertPrizenotifiedObject didRequestComplateConvertPrizeFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
