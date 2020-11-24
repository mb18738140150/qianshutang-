//
//  TaskLibraryTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskLibraryTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * moduleNameLB;
@property (nonatomic, strong)UILabel * remarkLB;
@property (nonatomic, strong)UIButton * arrangeBtn;
@property (nonatomic, strong)UIButton * collectBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^arrangeTaskBlock)(NSDictionary * infoDic,CGRect rect);
@property (nonatomic, copy)void (^collectTaskBlock)(NSDictionary * infoDic);

- (void)refreshWith:(NSDictionary *)infoDic;
@end
