//
//  UserModel.h
//  Accountant
//
//  Created by aaa on 2017/2/28.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

@property (nonatomic,assign) int                 userID;
@property (nonatomic, assign)int                departId;

@property (nonatomic,assign) BOOL                isLogin;

@property (nonatomic,strong) NSString           *userName;

@property (nonatomic,strong) NSString           *userNickName;

@property (nonatomic,strong) NSString           *headImageUrl;

@property (nonatomic,strong) NSString           *telephone;

@property (nonatomic, strong)NSString * validityTime;// 有效期
@property (nonatomic, strong)NSString * gender;// 性别
@property (nonatomic, strong)NSString * birthday;// 出生日期
@property (nonatomic, strong)NSString * city;
@property (nonatomic, strong)NSString * receiveAddress;// 收货地址
@property (nonatomic, strong)NSString * receivePhoneNumber;// 收货人电话
@property (nonatomic, strong)NSString * receiveName;
@property (nonatomic,assign) int                 notificationNoDisturb;//消息免打扰
@property (nonatomic,assign) int                 starCount;//星星数量
@property (nonatomic,assign) int                 flowerCount;//红花数量
@property (nonatomic,assign) int                 prizeCount;//奖章数量
@property (nonatomic,assign) int                 score;//奖章数量

@property (nonatomic, strong) NSString          *wangYiToken;


@property (nonatomic, assign)int                type;//1:学员2：教师3：分管理员4：总管理员

@property (nonatomic, strong)NSString * shareUrl;
@property (nonatomic, strong)NSString * logo;
@property (nonatomic, strong)NSString * coverImg;
@property (nonatomic, strong)NSArray * iconList;
@end
