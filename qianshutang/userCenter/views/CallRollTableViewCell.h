//
//  CallRollTableViewCell.h
//  qianshutang
//
//  Created by FRANKLIN on 2018/10/5.
//  Copyright © 2018 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallRollTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * memberNameLB;
@property (nonatomic, strong)UILabel * attendanceLB;
@property (nonatomic, strong)UILabel * costLB;
@property (nonatomic, strong)UIButton * callRollBtn;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, copy)void (^callRollBlock)(NSDictionary * infoDic);

- (void)refreshWith:(NSDictionary *)infoDic;
@end


