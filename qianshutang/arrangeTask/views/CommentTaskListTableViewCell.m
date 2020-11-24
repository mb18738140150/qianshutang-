//
//  CommentTaskListTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentTaskListTableViewCell.h"

@implementation CommentTaskListTableViewCell

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
    
    self.studentLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.hd_width / 9, self.hd_height)];
    self.studentLB.textAlignment = NSTextAlignmentCenter;
    self.studentLB.textColor = UIColorFromRGB(0x515151);
    self.studentLB.font = [UIFont systemFontOfSize:15];
    self.studentLB.text = [[UserManager sharedManager] getUserNickName];
    self.studentLB.numberOfLines = 0;
    [self.contentView addSubview:self.studentLB];
    
    
    self.taskDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.taskDetailLB.textColor = UIColorFromRGB(0x585858);
    
    switch ([[infoDic objectForKey:@"type"] intValue]) {
        case 3:
        case 4:
        case 5:
        {
            self.taskDetailLB.text = [infoDic objectForKey:kmadeName];
        }
            break;
        case 1:
        case 2:
        {
            self.taskDetailLB.text = [infoDic objectForKey:kpartName];
        }
            break;
            
        default:
            break;
    }
    
    
    self.taskDetailLB.numberOfLines = 0;
    self.taskDetailLB.textAlignment = NSTextAlignmentCenter;
    self.taskDetailLB.font = [UIFont systemFontOfSize:15];
    self.taskDetailLB.numberOfLines = 0;
    [self.contentView addSubview:self.taskDetailLB];
    
    self.taskLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskDetailLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.taskLB.textColor = UIColorFromRGB(0x585858);
    self.taskLB.text = [infoDic objectForKey:kWorkLogName];
    self.taskLB.font = [UIFont systemFontOfSize:15];
    self.taskLB.textAlignment = NSTextAlignmentCenter;
    self.taskLB.numberOfLines = 0;
    [self.contentView addSubview:self.taskLB];
    
    self.timeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskLB.frame), 0, self.hd_width / 9 * 2, self.hd_height)];
    self.timeLB.textColor = UIColorFromRGB(0x585858);
    self.timeLB.text = [infoDic objectForKey:@"time"];
    self.timeLB.font = [UIFont systemFontOfSize:15];
    self.timeLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLB];
    
    self.stateLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLB.frame), 0, self.hd_width / 9, self.hd_height)];
    self.stateLB.textColor = UIColorFromRGB(0x585858);
    self.stateLB.text = [infoDic objectForKey:kdoState];
    self.stateLB.font = [UIFont systemFontOfSize:15];
    self.stateLB.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLB];
    
    self.checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkbtn.frame = CGRectMake(self.hd_width / 18 * 17 - self.hd_height * 1.14 / 2, self.hd_height * 0.2, self.hd_height * 1.14, self.hd_height * 0.6);
    [self.checkbtn setTitle:@"点评" forState:UIControlStateNormal];
    [self.checkbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkbtn.backgroundColor = UIColorFromRGB(0x56AB89);
    self.checkbtn.layer.cornerRadius = 3;
    self.checkbtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.checkbtn];
    [self.checkbtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.isTeacher) {
        [self.checkbtn setTitle:@"查看" forState:UIControlStateNormal];
    }
    
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
