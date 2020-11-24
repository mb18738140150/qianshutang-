
//
//  NightModeManager.m
//  tiku
//
//  Created by aaa on 2017/5/18.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import "NightModeManager.h"

@implementation NightModeManager
static NightModeManager *_nightManager;

+ (instancetype)shareNightModeManager
{
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _nightManager = [super allocWithZone:zone];
        
        _nightManager.commonMainColor = UIRGBColor(29.0,122.0,248.0);
        _nightManager.commonNavigationBarColor = UIRGBColor(255.0,255.0,255.0);
        _nightManager.commonNavigationBarTextColor = UIRGBColor(0,0,0);
        _nightManager.cellBackgroundGrayColor = UIRGBColor(240,240,240);
        _nightManager.cellSeparatorColor = UIRGBColor(220,220,220);
    });
    return _nightManager;
}

//严谨起见
-(id)copyWithZone:(NSZone *)zone
{
    //    return [[self class]allocWithZone:zone];
    return _nightManager;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _nightManager;
}

@end
