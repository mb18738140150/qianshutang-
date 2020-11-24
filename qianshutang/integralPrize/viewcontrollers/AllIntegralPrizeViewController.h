//
//  AllIntegralPrizeViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface AllIntegralPrizeViewController : BasicViewController

@property (nonatomic, copy)void(^selectPrizeBlock)(NSDictionary * infoDic);

@end
