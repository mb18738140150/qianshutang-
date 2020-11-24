//
//  NightModeManager.h
//  tiku
//
//  Created by aaa on 2017/5/18.
//  Copyright © 2017年 ytx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NightModeManager : NSObject


@property (nonatomic, strong)UIColor * commonMainColor;
@property (nonatomic, strong)UIColor * commonNavigationBarColor;
@property (nonatomic, strong)UIColor * commonNavigationBarTextColor;
@property (nonatomic, strong)UIColor * cellBackgroundGrayColor;
@property (nonatomic, strong)UIColor * cellSeparatorColor;

+ (instancetype)shareNightModeManager;


@end
