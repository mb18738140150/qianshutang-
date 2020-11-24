//
//  PraiseAndFlowerView.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraiseAndFlowerView : UIView

@property (nonatomic, copy)void (^praiseBlock)(NSString *flowerCount);

@end
