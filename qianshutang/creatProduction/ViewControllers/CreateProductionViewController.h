//
//  CreateProductionViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface CreateProductionViewController : BasicViewController

@property (nonatomic, copy)void(^SavaProductBlock)(ProductionModel * model);
@property (nonatomic, copy)void(^modifyProductSuccessBlock)(BOOL isSuccess);

@property (nonatomic, copy)void(^ComplateTaskSuccessBlock)(BOOL isSuccess);

@property (nonatomic, strong)ProductionModel * model;
@property (nonatomic, assign)CreatProductionType createProductionType;
@property (nonatomic, assign)int productId;

@property (nonatomic, assign)BOOL isDoTask;
@property (nonatomic, assign)int userWorkId;
@property (nonatomic, assign)BOOL madeId;

@end
