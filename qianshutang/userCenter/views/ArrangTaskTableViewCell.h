//
//  ArrangTaskTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangTaskTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * starImageView;
@property (nonatomic, strong)UILabel * moduleNameLB;
@property (nonatomic, strong)UILabel * remarkLB;
@property (nonatomic, strong)UIButton * arrangeBtn;
@property (nonatomic, strong)UIButton * operationBtn;
@property (nonatomic, strong)UIButton * shareBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, assign)BOOL isDelete;


@property (nonatomic, copy)void (^arrangeTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^operationTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^deleteTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^shareTaskBlock)(NSDictionary * infoDic);

- (void)refreshWith:(NSDictionary *)infoDic;

@end
