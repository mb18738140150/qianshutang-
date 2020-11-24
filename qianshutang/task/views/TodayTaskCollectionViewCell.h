//
//  TodayTaskCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayTaskCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)void (^readTextBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^recordTextBlock)(NSDictionary * infoDic);
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)UILabel * pageLB;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIImageView * typeImageView;

@property (nonatomic, strong)UILabel * cepingImageView;

@property (nonatomic, strong)UILabel * timeLB;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * complateLB;
@property (nonatomic, strong)UILabel * leaveLB;

@property (nonatomic, assign)int currentpage;
@property (nonatomic, assign)int totalPage;

@property (nonatomic, assign)BOOL isRead;//是否是阅读类型

@property (nonatomic, assign)TaskShowType taskShowType;

@property (nonatomic, strong)UILabel * repeatLB;
@property (nonatomic, strong)UILabel * repeatTF;
@property (nonatomic, strong)UIButton * changeBtn;
@property (nonatomic, strong)UIButton * deleteBtn;

@property (nonatomic, copy)void (^changeRepeatCountBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^changeBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^deleteBlock)(NSDictionary * infoDic);

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
