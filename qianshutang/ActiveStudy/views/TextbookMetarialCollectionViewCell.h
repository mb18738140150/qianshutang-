//
//  TextbookMetarialCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextbookMetarialCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)void (^videoBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^readTextBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^recordTextBlock)(NSDictionary * infoDic);
@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, strong)UILabel * pageLB;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UIImageView * iconImageView;
//@property (nonatomic, strong)UIImageView * typeImageView;
//@property (nonatomic, strong)UILabel * cepingImageView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, assign)int currentpage;
@property (nonatomic, assign)int totalPage;

@property (nonatomic, assign)BOOL isLastReadRecord;

- (void)resetWithInfoDic:(NSDictionary *)infoDic;

- (void)searchReset;
- (void)reSearchReset;

@end
