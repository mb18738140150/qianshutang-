//
//  AddressView.h
//  qianshutang
//
//  Created by aaa on 2018/8/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView

@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void(^AddressSelectBlock)(NSDictionary * addressDic);

- (void)refreshWithAddressInfo:(NSDictionary *)infoDic;

- (void)resignAllTf;

@end
