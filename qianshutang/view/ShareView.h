//
//  ShareView.h
//  qianshutang
//
//  Created by aaa on 2018/9/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShareType_weixin,
    ShareType_productShowAndWeixin,
    ShareType_friend,
    ShareType_classroom_productShowAndWeixin,
    ShareType__tongbuyuanwen_classroom_productShowAndWeixin,
    ShareType_classroomAndFriend,
} ShareType;

typedef enum : NSUInteger {
    ShareObjectType_weixinFriend,
    ShareObjectType_friendCircle,
    ShareObjectType_WeixinCollect,
    ShareObjectType_MyFriend,
    ShareObjectType_ProductShow,
    ShareObjectType_classroom,
    ShareObjectType_tongbuyuanwen,
} ShareObjectType;


@interface ShareView : UIView

@property (nonatomic, copy)void(^shareBlock)(NSDictionary * infoDic);

@property (nonatomic, assign)ShareType shareType;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArr;

@property (nonatomic, strong)UIView * tipView;
@property (nonatomic, strong)UIView * backView;

- (instancetype)initWithFrame:(CGRect)frame andShareType:(ShareType)type;

@end
