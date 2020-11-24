//
//  NavigationView.h
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NavigationType_search,
    NavigationType_select,
    NavigationType_deleteAneShare,
    NavigationType_save,
    NavigationType_shareAndPlay,
    NavigationType_deleteAndLatestProduct,
    NavigationType_shareAndQuit,
    NavigationType_playBack,
    NavigationType_searchAndCollect,
    NavigationType_comment,
    NavigationType_none
} NavigationType;

typedef enum : NSUInteger {
    userCenterItemType_quit,
    userCenterItemType_shareAndDelete,
    userCenterItemType_explainAndShare,
    userCenterItemType_addAndDelete,
    userCenterItemType_latest,
    userCenterItemType_searchAndOperation,
    userCenterItemType_delete,
    userCenterItemType_haveRead,
    userCenterItemType_create,
    userCenterItemType_comment,
    userCenterItemType_search,
    userCenterItemType_creatAndSearch,
    userCenterItemType_ArrangeAndCommentAndToday,
    userCenterItemType_none
} userCenterItemType;

@interface NavigationView : UIView

@property (nonatomic, assign)NavigationType navigationType;

@property (nonatomic, copy)void(^quitBlock)();
@property (nonatomic, copy)void(^DismissBlock)();
@property (nonatomic, copy)void(^SelectAllBlock)();
@property (nonatomic, copy)void(^searchBlock)(BOOL isSearch);
@property (nonatomic, copy)void(^complateBlock)();
@property (nonatomic, copy)void(^shareBlock)(BOOL isShare);
@property (nonatomic, copy)void(^SureShareBlock)(BOOL sureShare);
@property (nonatomic, copy)void(^deleteBlock)(BOOL isDelete);
@property (nonatomic, copy)void(^cleanBlock)(BOOL isClean);
@property (nonatomic, copy)void(^explainBlock)();
@property (nonatomic, copy)void(^saveBlock)();
@property (nonatomic, copy)void(^playBlock)();
@property (nonatomic, copy)void (^collectCourseBlock)();
@property (nonatomic, copy)void(^createBlock)();
@property (nonatomic, copy)void(^latestProductBlock)(BOOL isShow,CGRect rect);
@property (nonatomic, copy)void(^OperationBlock)(BOOL isShow,CGRect rect);
@property (nonatomic, copy)void(^cancelOperationBlock)(BOOL isCancel);
@property (nonatomic, copy)void(^sureShareListBlock)(BOOL isShare);

@property (nonatomic, copy)void(^commentBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^addBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^arrangeBlock)(NSDictionary * infoDic);
@property (nonatomic, copy)void(^todayBlock)(NSDictionary * infoDic);

@property (nonatomic, assign)userCenterItemType usercenterItemType;

@property (nonatomic, strong)UIView * rightView;
- (instancetype)initWithFrame:(CGRect)frame withNavigationType:(NavigationType)type;

- (void)showSelectAllAndComplate;

- (void)showSearch;

- (void)resetBackView;

- (void)refreshLatestView;
- (void)showLatestBtn;
- (void)hideLatestBtn;
- (void)showDeleteAndLatestBtn;
- (void)hideDeleteBtn;
- (void)hideSearchBtn;
- (void)hideCollectBtn;
- (void)showCollectBtn;
- (void)hidePlayBackBtn;

- (void)cancelDelete;

- (void)refreshLatestView_Delete;
- (void)refreshLatestView_Share;
- (void)refreshLatestView_Nomal;

- (void)hideSelectAllBtn;
- (void)hideComplateBtn;
- (void)refreshTitleWith:(NSString *)text;
- (void)refreshWith:(userCenterItemType)userCenterItemType;
- (void)refreshLatestViewWith:(NSString *)title;
- (void)refreshOperationView;
- (void)refreshSearchBtnWith:(BOOL)isSearch;
- (void)refreshDeleteBtnWith:(BOOL)isDelete;
@end
