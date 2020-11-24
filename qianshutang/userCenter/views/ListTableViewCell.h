//
//  ListTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * rankingLB;
@property (nonatomic, strong)UILabel * studentLB;
@property (nonatomic, strong)UILabel * countLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIButton * showBtn;

@property (nonatomic, assign)BOOL isShow;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
