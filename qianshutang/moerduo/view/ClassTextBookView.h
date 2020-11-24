//
//  ClassTextBookView.h
//  qianshutang
//
//  Created by aaa on 2018/9/19.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTextBookView : UIView

@property (nonatomic, copy)void(^selectProductBlock)(NSDictionary * infoDic, BOOL isTextbook);
@property (nonatomic, assign)TaskEditType taskEditType;

- (void)refreshTitleWith:(NSString *)text;
- (void)refreshLatestView;

- (void)reloadData:(NSDictionary *)infoDic;
- (instancetype)initWithFrame:(CGRect)frame andInfoDic:(NSDictionary *)infoDic;
@end
