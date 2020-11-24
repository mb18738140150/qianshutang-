//
//  CommentModulTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CommentModulTableViewCell.h"

@implementation CommentModulTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)reSetWithInfo:(NSDictionary *)infoDic
{
    self.infoDic = infoDic;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.hd_width - 20, self.hd_height)];
    self.titleLB.textColor =UIColorFromRGB(0x555555);
    self.titleLB.text = [infoDic objectForKey:@"content"];
    [self.contentView addSubview:self.titleLB];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.hd_width - self.hd_height / 3 * 2, self.hd_height / 3, self.hd_height / 3, self.hd_height / 3);
    [self.deleteBtn setImage:[UIImage imageNamed:@"read_btn_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction ) forControlEvents:UIControlEventTouchUpInside];
    if (self.isDelete) {
        self.deleteBtn.hidden = NO;
    }else
    {
        self.deleteBtn.hidden = YES;
    }
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hd_height - 1, self.hd_width, 1)];
    bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.contentView addSubview:bottomView];
    
}

- (void)deleteAction
{
    if (self.deleteCommentModulBlock) {
        self.deleteCommentModulBlock(self.infoDic);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
