//
//  CreateTaskTypeView.h
//  qianshutang
//
//  Created by aaa on 2018/8/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CreateTaskType_moerduo,
    CreateTaskType_read,
    CreateTaskType_record,
    CreateTaskType_create,
    CreateTaskType_video
} CreateTaskType;

@interface CreateTaskTypeView : UIView

@property (nonatomic, assign)BOOL isXiLie;

@property (nonatomic, copy)void(^createTaskBlock)(CreateTaskType type);

- (instancetype)initWithFrame:(CGRect)frame andisXiLie:(BOOL)isXiLie;

@end
