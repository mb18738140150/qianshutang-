//
//  TeachingMaterailCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachingMaterailCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)void (^readTextBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^recordTextBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^deleteBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^videoBlock)(NSDictionary * infoDic);

@property (nonatomic, strong)NSDictionary * infoDic;


@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIImageView * selectImageView;
@property (nonatomic, strong)UILabel * selectNumberLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UIImageView * typeImageView;
@property (nonatomic, strong)UILabel * cepingImageView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * teacherImageView;// 老师图标
@property (nonatomic, assign)BOOL isTeacher;
@property (nonatomic, assign)BOOL isTeacherExplain;// 老师讲解

@property (nonatomic, strong)UILabel * imageLB;

@property (nonatomic, strong)UILabel * nContentNumberLB;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

- (void)resetCCoursewareWithInfoDic:(NSDictionary *)infoDic;

- (void)selectReset;
- (void)selectNumberReset;

- (void)deleteReset;
- (void)shareNoSelectReset;
- (void)shareSelectReset;

- (void)showContentNumberWith:(int)number;

- (void)haveCollect;

@end
