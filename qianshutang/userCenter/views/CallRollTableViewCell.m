//
//  CallRollTableViewCell.m
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/5.
//  Copyright © 2018 mcb. All rights reserved.
//

#import "CallRollTableViewCell.h"

@implementation CallRollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWith:(NSDictionary *)infoDic
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.infoDic = infoDic;
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake( kScreenWidth * 0.03, 5, (self.hd_height - 10) * 0.75, self.hd_height - 10)];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"userIcon"]] placeholderImage:[UIImage imageNamed:@"protect_eye_bg"]];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.memberNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5, 0, self.hd_width / 3 - self.iconImageView.hd_width - 10, self.hd_height)];
    self.memberNameLB.textColor = UIColorFromRGB(0x585858);
    self.memberNameLB.text = [infoDic objectForKey:kUserName];
    self.memberNameLB.font = [UIFont systemFontOfSize:15];
    self.memberNameLB.numberOfLines = 0;
    [self.contentView addSubview:self.memberNameLB];
    
    self.attendanceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.memberNameLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.attendanceLB.textColor = UIColorFromRGB(0x585858);
    self.attendanceLB.text = [infoDic objectForKey:@"state"];
    self.attendanceLB.font = [UIFont systemFontOfSize:15];
    self.attendanceLB.textAlignment = NSTextAlignmentCenter;
    self.attendanceLB.numberOfLines = 0;
    [self.contentView addSubview:self.attendanceLB];
    
    self.costLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.attendanceLB.frame), 0, self.hd_width /9 * 2, self.hd_height)];
    self.costLB.textColor = UIColorFromRGB(0x585858);
    self.costLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"cost"]];
    self.costLB.font = [UIFont systemFontOfSize:15];
    self.costLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.costLB];
    
    
    self.callRollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callRollBtn.frame = CGRectMake(self.hd_width / 9 * 8 - self.hd_height * 0.6 , self.hd_height * 0.22, self.hd_height * 1.2, self.hd_height * 0.56);
    [self.callRollBtn setTitle:@"点名" forState:UIControlStateNormal];
    [self.callRollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.callRollBtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.callRollBtn.layer.cornerRadius = 3;
    self.callRollBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.callRollBtn];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
    [self.callRollBtn addTarget:self action:@selector(callRoll) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callRoll
{
    if (self.callRollBlock) {
        self.callRollBlock(self.infoDic);
    }
}


@end
