//
//  GrafitiViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

@interface GrafitiViewController : BasicViewController

@property (nonatomic, strong)UIImage *sourceimage;
@property (nonatomic, strong)ImageProductModel * model;
@property (nonatomic, copy)void(^SavaImageProDuctBlock)(UIImage * image);

@end
