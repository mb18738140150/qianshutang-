//
//  SelectDayCollectionViewCell.h
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDayCollectionViewCell : UICollectionViewCell


- (void)resetWith:(NSDictionary *)infoDic;

- (void)selectReset;

- (void)isHaveCourse:(BOOL)isHaveCourse;

@end
