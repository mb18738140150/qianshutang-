//
//  PrizeListOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "PrizeListOperation.h"

@interface PrizeListOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<Integral_PrizeList> notifiedObject;


@end

@implementation PrizeListOperation

- (void)didRequestPrizeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_PrizeList>)object;
{
    self.notifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustPrizeListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    self.infoDic = [successInfo objectForKey:@"data"];
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestPrizeListSuccessed];
    }
}

- (void)didRequestFailed:(NSString *)failInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestPrizeListFailed:failInfo];
    }
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    if (isObjectNotNil(self.notifiedObject)) {
        [self.notifiedObject didRequestPrizeListFailed:[failedInfo objectForKey:kErrorMsg]];
    }
}

@end
