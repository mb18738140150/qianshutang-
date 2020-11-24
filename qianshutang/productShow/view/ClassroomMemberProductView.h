//
//  ClassroomMemberProductView.h
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassroomMemberProductView : UIView

@property (nonatomic, copy)void(^latestProductBlock)(BOOL isShow,CGRect rect);
@property (nonatomic, copy)void(^selectProductBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^selectProductAndSegmentBlock)(NSDictionary * infoDic, int selectIndex);

- (void)refreshTitleWith:(NSString *)text;
- (void)refreshLatestView;

- (void)reloadData;

@end
