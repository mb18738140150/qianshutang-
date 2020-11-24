//
//  MyIntegralOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIntegralOperation : NSObject

@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)NSArray * teacher_memberIntegralList;
@property (nonatomic, strong)NSArray * teacher_haveSendIntegralList;


- (void)didRequestMyIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegral>)object;

- (void)didRequestTeacher_memberIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_memberPrize>)object;
- (void)didRequestTeacher_haveSendIntegralWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_haveSendIntegral>)object;
- (void)didRequestTeacher_createConverPrizeRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_CreateConvertPrizeRecord>)object;
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object;
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object;
- (void)didRequestTeacher_sendGoodsWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_Teacher_sendGoods>)object;



@end
