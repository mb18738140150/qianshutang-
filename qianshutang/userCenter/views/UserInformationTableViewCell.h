//
//  UserInformationTableViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    InformationTableCellType_nomal,
    InformationTableCellType_icon,
    InformationTableCellType_color,
} InformationTableCellType;

@interface UserInformationTableViewCell : UITableViewCell

@property (nonatomic, copy)void(^modifyIconBlock)(BOOL isChange);

@property (nonatomic, copy)void(^modifyInformationBlock)(NSDictionary * infoDic);

@property (nonatomic, assign)InformationTableCellType informationCellType;

- (void)resetWith:(NSDictionary *)infoDic;

@end
