//
//  NSString+MD5.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)MD5;

+ (BOOL)isTelPhoneNub:(NSString *)str;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
