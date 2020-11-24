//
//  MainLeftTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLeftTableViewCell : UITableViewCell

@property (nonatomic, assign)BOOL ishaveCategory;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * cateGoryImage;
@property (nonatomic, assign)BOOL isCanClick;
@property (nonatomic, strong)UIView * messageCenterTipView;


- (void)resetWithInfoDic:(NSDictionary *)infoDic;

- (void)selectReset;

- (void)cannotClickReset;

- (void)refreshTipPointHide:(BOOL)hide;

@end
