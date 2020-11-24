//
//  MusicTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/7/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : UITableViewCell

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void(^deleteMusicBlock)(NSDictionary * infoDic);

@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIImageView * selectImageView;
@property (nonatomic, strong)UILabel * totalTimeLB;
@property (nonatomic, strong)UIImageView * deleteImageView;
@property (nonatomic, assign)float totalTimeLength;
@property (nonatomic, strong)NSMutableArray * timeLengthArray;

@property (nonatomic, assign)BOOL isTask;//是否是作业

- (void)resetWith:(NSDictionary *)infoDic;

- (void)selectReset:(BOOL)isPlaying;

- (void)deleteReset;

@end
