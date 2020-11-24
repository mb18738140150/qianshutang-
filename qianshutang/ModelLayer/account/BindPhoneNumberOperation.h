//
//  BindPhoneNumberOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/19.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BindPhoneNumberOperation : NSObject

- (void)didRequestBindPhoneNumber:(NSDictionary *)infoDic withNotifiedObject:(id<UserInfo_BindPhoneNumber>)object;


@end
