//
//  StartCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView * selectImageView;
@property (nonatomic, strong)UILabel * selectNumberLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIImageView * typeImageView;
@property (nonatomic, strong)UILabel * cepingImageView;
@property (nonatomic, strong)UIImageView * startImageView;
@property (nonatomic, strong)UILabel * startCountLB;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * titleLB;


- (void)resetWithInfoDic:(NSDictionary *)infoDic;

- (void)selectReset;

- (void)selectNumberReset;

@end
