//
//  Mp3Review.h
//  qianshutang
//
//  Created by aaa on 2018/10/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mp3Review : UIView

@property (nonatomic, copy)void(^voiceCommentComplateBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^voiceCommentCancelBlock)(NSDictionary * infoDic);
- (void)recordAction;
@end
