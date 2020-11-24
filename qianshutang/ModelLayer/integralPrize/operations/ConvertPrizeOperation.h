//
//  ConvertPrizeOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertPrizeOperation : NSObject

@property (nonatomic, strong)NSArray * convertPrizeRecordList;
@property (nonatomic, strong)NSArray * ComplateConvertPrizeList;

- (void)didRequestConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrize>)object;

- (void)didRequestConvertPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ConvertPrizeRecord>)object;

- (void)didRequestCancelConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_CancelConvertPrize>)object;

- (void)didRequestComplateConvertPrizeWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_ComplateConvertPrize>)object;

@end
