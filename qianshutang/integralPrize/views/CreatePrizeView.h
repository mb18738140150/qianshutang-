//
//  CreatePrizeView.h
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatePrizeSelectView.h"
@interface CreatePrizeView : UIView

@property (nonatomic, copy)void(^selectStudentBlock)();
@property (nonatomic, copy)void(^selectPrizeBlock)();
@property (nonatomic, copy)void(^selectTimeBlock)(NSString * timeStr);

@property (nonatomic, copy)void(^complateBlock)(BOOL complate);
@property (nonatomic, copy)void(^cancelBlock)(BOOL cancel);
@property (nonatomic, copy)void(^storeBlock)(BOOL cancel);

@property (nonatomic, strong)NSArray * selectStudentArray;
@property (nonatomic, strong)NSString * selectStudentIdsStr;
@property (nonatomic, strong)NSDictionary * createPeize_prizeInfo;
@property (nonatomic, strong)NSString * createPrizeSendTime;

@property (nonatomic, strong)CreatePrizeSelectView * selectMemberView;
@property (nonatomic, strong)CreatePrizeSelectView * selectPrizeView;
@property (nonatomic, strong)CreatePrizeSelectView * selectTimeView;



- (instancetype)initWithFrame:(CGRect)frame;
- (void)resetSelectArrayWith:(NSArray *)array;
- (void)resetSelectPrizeInfoWith:(NSDictionary *)infoDic;

@end
