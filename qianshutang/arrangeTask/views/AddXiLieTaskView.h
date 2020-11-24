//
//  AddXiLieTaskView.h
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectTextBookView.h"

@interface AddXiLieTaskView : UIView

@property (nonatomic, copy)void(^textBookBlock)();
@property (nonatomic, copy)void(^starttextBlock)();
@property (nonatomic, copy)void(^endTextBlock)();
@property (nonatomic, copy)void(^repeatBlock)();

@property (nonatomic, copy)void(^repeatCountBlock)(NSString * type);
@property (nonatomic, copy)void(^readTextCountBlock)(NSString * type);


@property (nonatomic, copy)void(^continueBlock)(NSDictionary * infoDic);

@property (nonatomic, strong)SelectTextBookView * textBookView;
@property (nonatomic, strong)SelectTextBookView * startTextView;
@property (nonatomic, strong)SelectTextBookView * endTextView;
@property (nonatomic, strong)UITextField * readTextCount;
@property (nonatomic, strong)UITextField * repeatCount;
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

- (void)resetTextBookWith:(NSString *)title;

- (void)resetStartBookWith:(NSString *)title;

- (void)resetEndBookWith:(NSString *)title;

@end
