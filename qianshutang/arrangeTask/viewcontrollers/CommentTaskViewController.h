//
//  CommentTaskViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

typedef enum : NSUInteger {
    PlayOriginOrRecordType_nomal,
    PlayOriginOrRecordType_record,
    PlayOriginOrRecordType_origin,
    PlayOriginOrRecordType_mp3Review
} PlayOriginOrRecordType;

@interface CommentTaskViewController : BasicViewController

@property (nonatomic, copy)void(^modifuProductBlock)(BOOL isSuccess);

@property (nonatomic, assign)CommentTaskType commentTaskType;
@property (nonatomic, assign)TaskType taskType; // 作业类型
@property (nonatomic, assign)ProductType productType;// 作品类型

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)ProductionModel * model;
@property (nonatomic, assign)BOOL isFromProductShow;

@end
