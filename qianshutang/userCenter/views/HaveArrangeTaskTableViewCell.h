//
//  HaveArrangeTaskTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaveArrangeTaskTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * taskNameLB;
@property (nonatomic, strong)UILabel * objectLB;
@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * stateLB;
@property (nonatomic, strong)UIButton * operationBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^haveArrangeTaskOperationBlock)(NSDictionary * infoDic,CGRect rect);

- (void)refreshWith:(NSDictionary *)infoDic;
@end
