//
//  MyTaskDetailTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * typeLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * showBtn;

@property (nonatomic, assign)BOOL isShow;
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void(^checkTaskBlock)(NSDictionary * infoDic, DoTaskType type);

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
