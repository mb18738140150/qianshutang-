//
//  ArrangeTaskView.h
//  qianshutang
//
//  Created by aaa on 2018/8/21.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangeTaskView : UIView

@property (nonatomic, strong)NSString * title;
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, copy)void (^ContinueBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^DismissBlock)();

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic andIsStudent:(BOOL)isStudent;

- (instancetype)initXilieWithFrame:(CGRect)frame andTitle:(NSString *)title andInfoDic:(NSDictionary *)infoDic andIsStudent:(BOOL)isStudent;

- (void)resetOriginContinuTime:(int)continuTime;

- (void)hidecgangeTimeBtn;

- (void)showcgangeTimeBtn;

@end
