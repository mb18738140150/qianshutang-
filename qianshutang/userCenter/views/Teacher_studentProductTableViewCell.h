//
//  Teacher_studentProductTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/10/17.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teacher_studentProductTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * productNameLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * flowerAndPrizeLB;
@property (nonatomic, strong)UIButton * commentBtn;

@property (nonatomic, strong)NSDictionary * infoDic;

- (void)refreshWith:(NSDictionary *)infoDic;

@end
