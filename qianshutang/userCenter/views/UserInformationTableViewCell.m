//
//  UserInformationTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "UserInformationTableViewCell.h"

@interface UserInformationTableViewCell()

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UIImageView * iconImageVIew;

@property (nonatomic, strong)NSDictionary * infoDIc;

@end

@implementation UserInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWith:(NSDictionary *)infoDic
{
    self.infoDIc = infoDic;
    [self.contentView removeAllSubviews];
    
    NSString * title = [infoDic objectForKey:@"title"];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, titleSize.width + 10 , self.hd_height)];
    self.titleLB.textColor = UIColorFromRGB(0x555555);
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
//    NSString * content = [infoDic objectForKey:@"content"];
//    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, self.hd_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    self.contentLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 30, 0, self.hd_width - CGRectGetMaxX(self.titleLB.frame) - 80, self.hd_height)];
    self.contentLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"content"]];
    self.contentLB.textAlignment = NSTextAlignmentRight;
    self.contentLB.textColor = UIColorFromRGB(0x555555);
    [self.contentView addSubview:self.contentLB];
    self.contentLB.numberOfLines = 0;
    
    self.iconImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width - 50 - self.hd_height + 10, 5, self.hd_height - 10, self.hd_height - 10)];
    self.iconImageVIew.layer.cornerRadius = self.iconImageVIew.hd_height / 2;
    self.iconImageVIew.layer.masksToBounds = YES;
    self.iconImageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"imageStr"]]];
    if ([infoDic objectForKey:@"content"]) {
        [self.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"content"]]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    }else
    {
        self.iconImageVIew.image = [UIImage imageNamed:@"head_portrait"];
    }
    
    [self.contentView addSubview:self.iconImageVIew];
    
    if (self.informationCellType == InformationTableCellType_icon) {
        self.contentLB.hidden = YES;
        self.iconImageVIew.hidden = NO;
    }else if (self.informationCellType == InformationTableCellType_color)
    {
        self.iconImageVIew.hidden = YES;
        self.contentLB.hidden = NO;
        self.contentLB.textColor = UIColorFromRGB(0x777777);
    }else
    {
        self.iconImageVIew.hidden = YES;
        self.contentLB.hidden = NO;
        self.contentLB.textColor = UIColorFromRGB(0x555555);
    }
    
//    self.iconImageVIew.userInteractionEnabled = YES;
//    self.contentLB.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction )];
//    [self.iconImageVIew addGestureRecognizer:imageTap];
//    
//    UITapGestureRecognizer * contentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentTapAction )];
//    [self.iconImageVIew addGestureRecognizer:contentTap];
}

- (void)imageTapAction
{
    if (self.modifyIconBlock) {
        self.modifyIconBlock(YES);
    }
}

- (void)contentTapAction
{
    if (self.modifyInformationBlock) {
        self.modifyInformationBlock(self.infoDIc);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
