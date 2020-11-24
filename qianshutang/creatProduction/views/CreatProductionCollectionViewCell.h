//
//  CreatProductionCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatProductionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIImageView * typeImageView;

@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UIButton * shareBtn;

@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)NSDictionary * model;
@property (nonatomic, copy)void(^shareBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^delateBlock)(NSDictionary* infoDic);

@property (nonatomic, assign)BOOL isHaveComment;
@property (nonatomic, strong)UIView * commentView;


- (void)resetWithInfoDic:(NSDictionary *)model;

- (void)resetAddView;
- (void)resetShareView;
- (void)resetDeleteView;
- (void)resetShareListView;


@end
