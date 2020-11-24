//
//  MtTaskAttendanceTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MtTaskAttendanceTableViewCell.h"

@implementation MtTaskAttendanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWithInfo:(NSDictionary *)infoDic
{
    self.infoDic = infoDic;
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.sectionLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 6, self.hd_height)];
    self.sectionLB.textAlignment = NSTextAlignmentCenter;
    self.sectionLB.textColor = UIColorFromRGB(0x515151);
    self.sectionLB.font = [UIFont systemFontOfSize:15];
    self.sectionLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"unitNumber"]];
    [self.contentView addSubview:self.sectionLB];
    
    
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sectionLB.frame), 0, self.hd_width / 3, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:kunitTime];
    self.timeLB.numberOfLines = 0;
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    self.timeLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width /6, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    switch ([[infoDic objectForKey:kState] intValue]) {
        case 0:
            {
                self.stateLB.text = @"未出勤";
            }
            break;
        case 1:
        {self.stateLB.text = @"已出勤";
            
        }
            break;
        case 2:
        {
            self.stateLB.text = @"请假";
        }
            break;
        case 3:
        {
            self.stateLB.text = @"旷课";
        }
            break;
            
        default:
            break;
    }
    
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    self.costLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.stateLB.frame), 0, self.hd_width /6, self.hd_height)];
    self.costLB.textColor = UIColorFromRGB(0x585858);
    self.costLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"cost"]];
    self.costLB.font = [UIFont systemFontOfSize:15];
    self.costLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.costLB];
    
    
    self.checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkbtn.frame = CGRectMake(CGRectGetMaxX(self.costLB.frame) + 20, self.hd_height * 0.2, self.hd_height * 1.14, self.hd_height * 0.6);
    [self.checkbtn setTitle:@"查看" forState:UIControlStateNormal];
    [self.checkbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkbtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.checkbtn.layer.cornerRadius = 3;
    self.checkbtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.checkbtn];
    [self.checkbtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 2, self.hd_width, 2)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
}

- (void)checkAction
{
    if (self.CheckCourseBlock) {
        self.CheckCourseBlock(self.infoDic);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
