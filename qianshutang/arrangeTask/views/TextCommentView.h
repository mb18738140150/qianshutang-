//
//  TextCommentView.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCommentView : UIView

@property (nonatomic, copy)void (^updataCommentBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^commentModulBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void (^storeCommentModulBlock)(NSDictionary * infoDic);

- (void)resetCommentContent:(NSString *)comment;

- (void)resetUIWith:(NSDictionary *)infoDic;

- (void)limitClick;

@end
