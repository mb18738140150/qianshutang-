//
//  ProductDetailViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/3.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"
#import "ProductionModel.h"

@interface ProductDetailViewController : BasicViewController

@property (nonatomic, copy)void(^backBlock)(ProductionModel * model);
@property (nonatomic, strong)ProductionModel * model;

@end
