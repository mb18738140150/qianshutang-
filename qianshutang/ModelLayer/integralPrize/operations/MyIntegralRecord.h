//
//  MyIntegralRecord.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyIntegralRecord : NSObject

@property (nonatomic, strong)NSArray * infoDic;

- (void)didRequestMyIntegralRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_MyIntegralRecord>)object;


@end
