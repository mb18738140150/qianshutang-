//
//  Teacher_haveSendIntegralTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/10/23.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teacher_haveSendIntegralTableViewCell : UITableViewCell

@property (nonatomic, copy)void (^editPrizeRemarkBlock)(NSDictionary *infoDic);

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * integralLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * remarkLB;

@property (nonatomic, strong)UIButton * commentBtn;

@property (nonatomic, strong)NSDictionary * infoDic;

- (void)refreshWith:(NSDictionary *)infoDic;

@end
