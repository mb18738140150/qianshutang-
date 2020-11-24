//
//  PrizeCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrizeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * integrslLB;
@property (nonatomic, strong)UILabel * convertLB;
@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void(^convertPrizeBlock)(NSDictionary * infoDic);
@property (nonatomic, assign)BOOL isHaveConversion;
- (void)refreshWith:(NSDictionary *)infoDic;

@end
