//
//  HomeworkDetailView.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeworkDetailView : UIView

@property (nonatomic, assign)BOOL isCreateTask;

- (instancetype)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)infoDic;

@property (nonatomic, copy)void(^playVideoIntroBlock)(NSDictionary * infoDic);

@end
