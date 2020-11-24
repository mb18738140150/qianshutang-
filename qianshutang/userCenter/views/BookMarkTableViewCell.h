//
//  BookMarkTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * bookNameLB;
@property (nonatomic, strong)UILabel * textLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UIImageView * deleteImage;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

- (void)resetDeleteView;

@end
