//
//  StudyLengthTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/9/10.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyLengthTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel * typeLB;
@property (nonatomic, strong)UILabel * contentLB;
@property (nonatomic, strong)UILabel * textBookLB;
@property (nonatomic, strong)UILabel * timeLengthLB;
@property (nonatomic, strong)UILabel * dateLB;
- (void)resetUIWithInfoDic:(NSDictionary *) infoDic;

@end
