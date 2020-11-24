//
//  CommentModulTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentModulTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIButton * deleteBtn;

@property (nonatomic, copy)void (^deleteCommentModulBlock)(NSDictionary *infoDic);
@property (nonatomic, assign)BOOL isDelete;

@property (nonatomic, strong)NSDictionary * infoDic;
- (void)reSetWithInfo:(NSDictionary *)infoDic;

@end
