//
//  MyStudyOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStudyOperation : NSObject

@property (nonatomic, strong)NSDictionary * MyProductDic;
@property (nonatomic, strong)NSDictionary * myProduct_shareInfoDic;
@property (nonatomic, strong)NSArray * MyHeadTaskListArray;
@property (nonatomic, strong)NSArray * MyEveryDayTaskDetailListArray;
@property (nonatomic, strong)NSArray * MyEveryDayTaskArray;
@property (nonatomic, strong)NSArray * MyCourseListArray;
@property (nonatomic, strong)NSDictionary * MyAttendanceInfoDic;
@property (nonatomic, strong)NSArray * MyCourseCostArray;
@property (nonatomic, strong)NSArray * BuyCourseRecordArray;
@property (nonatomic, strong)NSDictionary * MyAchievementListArray;
@property (nonatomic, strong)NSDictionary * MyStudyTimeLengthListArray;
@property (nonatomic, strong)NSArray * MyStudyTimeLengthDetailListArray;
@property (nonatomic, strong)NSDictionary * PunchCardInfoDic;

@property (nonatomic, strong)NSArray * myCourse_BigCourseList;
@property (nonatomic, strong)NSArray * currentWeekCourseList;

@property (nonatomic, strong)NSDictionary * shareMyProductInfo;

- (void)didRequestMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyProduct>)object;
- (void)didRequestDeleteMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_DeleteMyProduct>)object;
- (void)didRequestShareMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_ShareMyProduct>)object;
- (void)didRequestMyHeadTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyHeadTaskList>)object;
- (void)didRequestMyEveryDayTaskDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTaskDetailList>)object;
- (void)didRequestMyEveryDayTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTask>)object;
- (void)didRequestMyCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseList>)object;
- (void)didRequestMyAttendanceListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAttendanceList>)object;
- (void)didRequestMyCourseCostWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseCost>)object;
- (void)didRequestBuyCourseRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_BuyCourseRecord>)object;
- (void)didRequestMyAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAchievementList>)object;
- (void)didRequestMyStudyTimeLengthListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthList>)object;
- (void)didRequestMyStudyTimeLengthDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthDetailList>)object;
- (void)didRequestPunchCardListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_PunchCardList>)object;

- (void)didRequestMyCourse_BigCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourse_BigCourseList>)object;
- (void)didRequestCurrentWeekCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_CurrentWeekCourseList>)object;


@end
