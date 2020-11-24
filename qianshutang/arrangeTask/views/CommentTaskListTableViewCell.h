//
//  CommentTaskListTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTaskListTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * studentLB;
@property (nonatomic, strong)UILabel * taskDetailLB;
@property (nonatomic, strong)UILabel * taskLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * checkbtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^CheckCourseBlock)(NSDictionary *infoDic);

@property (nonatomic, assign)BOOL isTeacher;

- (void)refreshWithInfo:(NSDictionary *)infoDic;

@end
