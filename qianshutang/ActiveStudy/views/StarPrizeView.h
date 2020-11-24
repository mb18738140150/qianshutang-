//
//  StarPrizeView.h
//  qianshutang
//
//  Created by aaa on 2018/9/18.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarPrizeView : UIView

@property (nonatomic, copy)void (^backBlock)(BOOL isBask);
@property (nonatomic, copy)void (^circleBlock)(BOOL isBask);
@property (nonatomic, copy)void (^recordBlock)(BOOL isBask);
@property (nonatomic, copy)void (^reReadBlock)(BOOL isBask);
@property (nonatomic, copy)void (^shareBlock)(BOOL isShare);

- (instancetype)initWithFrame:(CGRect)frame andIsRecord:(BOOL)isRecord;

- (void)resetContent:(NSMutableAttributedString *)content;

- (void)hideRecoedBtn;

@end
