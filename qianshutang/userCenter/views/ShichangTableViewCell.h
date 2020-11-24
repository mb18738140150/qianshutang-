//
//  ShichangTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/11.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShichangTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * timeLB;
@property (nonatomic, strong)UILabel * lisenLB;
@property (nonatomic, strong)UILabel * readLB;
@property (nonatomic, strong)UILabel * recoardLB;
@property (nonatomic, strong)UIButton * checkBtn;

@property (nonatomic, assign)BOOL isLastItem;

@property (nonatomic, copy)void(^shichangBlock)(NSDictionary * infoDic);
@property (nonatomic, strong)NSDictionary * infoDic;
- (void)resetWithInfoDic:(NSDictionary *)infoDic;

@end
