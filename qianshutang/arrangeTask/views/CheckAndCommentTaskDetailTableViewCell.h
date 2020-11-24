//
//  CheckAndCommentTaskDetailTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckAndCommentTaskDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * progressLB;

- (void)resetWithInfoDic:(NSArray *)infoArray;

@end
