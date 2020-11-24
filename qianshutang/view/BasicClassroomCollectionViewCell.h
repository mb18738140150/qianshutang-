//
//  BasicClassroomCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicClassroomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * clickBtn;
@property (nonatomic, copy)void(^classroomClickBlock)(NSDictionary * infoDic);

- (void)resetWith:(NSDictionary *)infoDic;


@end
