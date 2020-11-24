//
//  CommentTaskTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTaskTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * studentNameLB;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * commentBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^commentTaskBlock)(NSDictionary * infoDic);

- (void)refreshWith:(NSDictionary *)infoDic;
@end
