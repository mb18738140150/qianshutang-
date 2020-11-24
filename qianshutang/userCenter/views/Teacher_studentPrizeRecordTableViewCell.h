//
//  Teacher_studentPrizeRecordTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Teacher_studentPrizeRecordTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * studentLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * prizeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * doBtn;

@property (nonatomic, copy)void (^teacher_StudentPrizeRecordBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, strong)NSDictionary * infoDic;
- (void)refreshWith:(NSDictionary *)infoDic;
@end
