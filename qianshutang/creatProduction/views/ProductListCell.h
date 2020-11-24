//
//  ProductListCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/30.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListCell : UITableViewCell

@property (nonatomic, assign)BOOL isShowNumber;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UIImageView * playImageView;
@property (nonatomic, strong)UIImageView * contentImageView;

@property (nonatomic, assign)int cellType;// 0.音视频 1.文本 2.图片
@property (nonatomic, strong)ImageProductModel * imageModel;
@property (nonatomic, strong)TextProductModel * textModel;
@property (nonatomic, strong)ProductionModel * modle;

@property (nonatomic, copy)void(^DeleteProcuctBlock)();

- (void)resetUI;

- (void)refreshBackView;

- (void)shwDelete;

- (void)showMusicPlay;

- (void)showNumber;

@end
