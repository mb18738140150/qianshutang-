//
//  AddMusicViewController.h
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

typedef enum : NSUInteger {
    ArrangeTaskTypedetail_nomal,
    ArrangeTaskTypedetail_moerduo,
    ArrangeTaskTypedetail_read,
    ArrangeTaskTypedetail_record,
} ArrangeTaskTypedetail;


@interface AddMusicViewController : BasicViewController

//@property (nonatomic, assign)BOOL isArrangeTask;
//@property (nonatomic, assign)BOOL isAggangrXiLieTask;
//@property (nonatomic, assign)BOOL isChangeTask;

@property (nonatomic, assign)TaskEditType taskEditType;

@property (nonatomic, assign)ArrangeTaskTypedetail arrangeTaskType;// 作业类型

@property (nonatomic, copy)void(^xilietaskBlock)(NSDictionary * infoDic);

@property (nonatomic, copy)void(^complateBlock)(NSArray * array);
@property (nonatomic, copy)void(^changeSuitangTaskTextbookBlock)(NSDictionary *infoDic);

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)NSDictionary * startTextInfo;
@property (nonatomic, strong)NSDictionary * endTextInfo;
@property (nonatomic, assign)BOOL isStart;
@property (nonatomic, assign)BOOL isEnd;

@end
