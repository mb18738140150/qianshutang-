//
//  BasicCategoryView.h
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BasicCategoryType_APP,
    BasicCategoryType_course,
    BasicCategoryType_task,
    BasicCategoryType_read,
    BasicCategoryType_music,
    BasicCategoryType_create,
    BasicCategoryType_show,
    BasicCategoryType_classroom,
    BasicCategoryType_main
} BasicCategoryType;

@interface BasicCategoryView : UIView

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * clickBtn;

@property (nonatomic, assign)BasicCategoryType type;
@property (nonatomic, copy)void(^ClickBlock)(BasicCategoryType type);

- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)infoDic;

- (void)resetTitleColor:(UIColor *)color;

- (void)resetIconImageView:(NSString *)iconStr;
- (void)resetTitle:(NSString *)title;

@end
