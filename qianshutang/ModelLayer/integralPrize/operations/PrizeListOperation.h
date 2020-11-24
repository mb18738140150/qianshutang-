//
//  PrizeListOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrizeListOperation : NSObject

@property (nonatomic, strong)NSArray * infoDic;

- (void)didRequestPrizeListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Integral_PrizeList>)object;


@end
