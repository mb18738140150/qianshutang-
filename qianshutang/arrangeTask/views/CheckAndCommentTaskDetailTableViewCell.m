//
//  CheckAndCommentTaskDetailTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CheckAndCommentTaskDetailTableViewCell.h"
#import "CheckAndCommentTaskProgressDetailCell.h"

@implementation CheckAndCommentTaskDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)resetWithInfoDic:(NSArray *)infoArray
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    
    self.progressLB = [self getTitleLBWith:@"" andRect:CGRectMake(0, 0, self.hd_width, self.hd_height)];
    [self.contentView addSubview:self.progressLB];
    
    for (int i = 0; i < infoArray.count; i++) {
        NSDictionary * taskInfoDic = infoArray[i];
        if ([[taskInfoDic objectForKey:@"type"] intValue] == 1) {
            CheckAndCommentTaskProgressDetailCell * progressView = [[CheckAndCommentTaskProgressDetailCell alloc]initWithFrame:CGRectMake(self.hd_width * i, 0, self.hd_width, self.hd_height)];
            [self.contentView addSubview:progressView];
        }else
        {
            UILabel * lb = [self getTitleLBWith:@"" andRect:CGRectMake(self.hd_width * i, 0, self.hd_width, self.hd_height)];
            [self.contentView addSubview:lb];
        }
    }
}

- (UILabel *)getTitleLBWith:(NSString *)title andRect:(CGRect)rect
{
    UILabel * lb = [[UILabel alloc]initWithFrame:rect];
    lb.backgroundColor = UIColorFromRGB(0xeeeeee);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = UIColorFromRGB(0x222222);
    
    return lb;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
