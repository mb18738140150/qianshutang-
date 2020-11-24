//
//  MyStudyOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MyStudyOperation.h"

@interface MyStudyOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<MyStudy_MyProduct>          MyProductNotifiedObject;
@property (nonatomic,weak) id<MyStudy_DeleteMyProduct>          DeleteMyProductNotifiedObject;
@property (nonatomic,weak) id<MyStudy_ShareMyProduct>          ShareMyProductNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyHeadTaskList>          MyHeadTaskListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyEveryDayTaskDetailList>          MyEveryDayTaskDetailListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyEveryDayTask>          MyEveryDayTaskNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyCourseList>          MyCourseListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyAttendanceList>          MyAttendanceListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyCourseCost>          MyCourseCostNotifiedObject;
@property (nonatomic,weak) id<MyStudy_BuyCourseRecord>          BuyCourseRecordNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyAchievementList>          MyAchievementListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyStudyTimeLengthList>          MyStudyTimeLengthListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyStudyTimeLengthDetailList>          MyStudyTimeLengthDetailListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_PunchCardList>          PunchCardListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_MyCourse_BigCourseList>          MyCourse_BigCourseListNotifiedObject;
@property (nonatomic,weak) id<MyStudy_CurrentWeekCourseList>          CurrentWeekCourseListNotifiedObject;

@property (nonatomic, strong)NSDictionary * myProductRequestInfo;

@end

@implementation MyStudyOperation

- (void)didRequestMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyProduct>)object
{
    self.myProductRequestInfo = infoDic;
    self.MyProductNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyProductWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestDeleteMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_DeleteMyProduct>)object
{
    self.DeleteMyProductNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustDeleteMyProductWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestShareMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_ShareMyProduct>)object
{
    self.ShareMyProductNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustShareMyProductWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyHeadTaskListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyHeadTaskList>)object
{
    self.MyHeadTaskListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyHeadTaskListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyEveryDayTaskDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTaskDetailList>)object
{
    self.MyEveryDayTaskDetailListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyEveryDayTaskDetailListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyEveryDayTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyEveryDayTask>)object
{
    self.MyEveryDayTaskNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyEveryDayTaskWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseList>)object
{
    self.MyCourseListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyCourseListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyAttendanceListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAttendanceList>)object
{
    self.MyAttendanceListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyAttendanceListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyCourseCostWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourseCost>)object
{
    self.MyCourseCostNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyCourseCostWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestBuyCourseRecordWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_BuyCourseRecord>)object
{
    self.BuyCourseRecordNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustBuyCourseRecordWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyAchievementListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyAchievementList>)object
{
    self.MyAchievementListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyAchievementListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyStudyTimeLengthListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthList>)object
{
    self.MyStudyTimeLengthListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyStudyTimeLengthListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestMyStudyTimeLengthDetailListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyStudyTimeLengthDetailList>)object
{
    self.MyStudyTimeLengthDetailListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyStudyTimeLengthDetailListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestPunchCardListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_PunchCardList>)object
{
    self.PunchCardListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustPunchCardListWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestMyCourse_BigCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_MyCourse_BigCourseList>)object
{
    self.MyCourse_BigCourseListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustMyCourse_BigCourseListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestCurrentWeekCourseListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<MyStudy_CurrentWeekCourseList>)object
{
    self.CurrentWeekCourseListNotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustCurrentWeekCourseListWithDic:infoDic andProcessDelegate:self];
}


- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 28:
        {
            if ([[self.myProductRequestInfo objectForKey:@"isShare "] intValue] == 1) {
                self.myProduct_shareInfoDic = successInfo;
            }else
            {
                self.MyProductDic = successInfo;
            }
            if (isObjectNotNil(self.MyProductNotifiedObject)) {
                [self.MyProductNotifiedObject didRequestMyProductSuccessed];
            }
        }
            break;
        case 29:
        {
            if (isObjectNotNil(self.DeleteMyProductNotifiedObject)) {
                [self.DeleteMyProductNotifiedObject didRequestDeleteMyProductSuccessed];
            }
        }
            break;
        case 30:
        {
            self.shareMyProductInfo = successInfo;
            if (isObjectNotNil(self.ShareMyProductNotifiedObject)) {
                [self.ShareMyProductNotifiedObject didRequestShareMyProductSuccessed];
            }
        }
            break;
        case 31:
        {
            self.MyHeadTaskListArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyHeadTaskListNotifiedObject)) {
                [self.MyHeadTaskListNotifiedObject didRequestMyHeadTaskListSuccessed];
            }
        }
            break;
        case 32:
        {
            self.MyEveryDayTaskDetailListArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyEveryDayTaskDetailListNotifiedObject)) {
                [self.MyEveryDayTaskDetailListNotifiedObject didRequestMyEveryDayTaskDetailListSuccessed];
            }
        }
            break;
        case 33:
        {
            self.MyEveryDayTaskArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyEveryDayTaskNotifiedObject)) {
                [self.MyEveryDayTaskNotifiedObject didRequestMyEveryDayTaskSuccessed];
            }
        }
            break;
        case 35:
        {
            self.MyCourseListArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyCourseListNotifiedObject)) {
                [self.MyCourseListNotifiedObject didRequestMyCourseListSuccessed];
            }
        }
            break;
        case 36:
        {
            self.MyAttendanceInfoDic = successInfo;
            if (isObjectNotNil(self.MyAttendanceListNotifiedObject)) {
                [self.MyAttendanceListNotifiedObject didRequestMyAttendanceListSuccessed];
            }
        }
            break;
        case 37:
        {
            self.MyCourseCostArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyCourseCostNotifiedObject)) {
                [self.MyCourseCostNotifiedObject didRequestMyCourseCostSuccessed];
            }
        }
            break;
        case 38:
        {
            self.BuyCourseRecordArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.BuyCourseRecordNotifiedObject)) {
                [self.BuyCourseRecordNotifiedObject didRequestBuyCourseRecordSuccessed];
            }
        }
            break;
        case 39:
        {
            self.MyAchievementListArray = successInfo;
            if (isObjectNotNil(self.MyAchievementListNotifiedObject)) {
                [self.MyAchievementListNotifiedObject didRequestMyAchievementListSuccessed];
            }
        }
            break;
        case 40:
        {
            self.MyStudyTimeLengthListArray = successInfo;
            if (isObjectNotNil(self.MyStudyTimeLengthListNotifiedObject)) {
                [self.MyStudyTimeLengthListNotifiedObject didRequestMyStudyTimeLengthListSuccessed];
            }
        }
            break;
        case 41:
        {
            self.MyStudyTimeLengthDetailListArray = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyStudyTimeLengthDetailListNotifiedObject)) {
                [self.MyStudyTimeLengthDetailListNotifiedObject didRequestMyStudyTimeLengthDetailListSuccessed];
            }
        }
            break;
        case 42:
        {
            self.PunchCardInfoDic = successInfo;
            if (isObjectNotNil(self.PunchCardListNotifiedObject)) {
                [self.PunchCardListNotifiedObject didRequestPunchCardListSuccessed];
            }
        }
            break;
        case 85:
        {
            self.myCourse_BigCourseList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.MyCourse_BigCourseListNotifiedObject)) {
                [self.MyCourse_BigCourseListNotifiedObject didRequestMyCourse_BigCourseListSuccessed];
            }
        }
            break;
        case 86:
        {
            self.currentWeekCourseList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.CurrentWeekCourseListNotifiedObject)) {
                [self.CurrentWeekCourseListNotifiedObject didRequestCurrentWeekCourseListSuccessed];
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
        case 28:
        {
            if (isObjectNotNil(self.MyProductNotifiedObject)) {
                [self.MyProductNotifiedObject didRequestMyProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 29:
        {
            if (isObjectNotNil(self.DeleteMyProductNotifiedObject)) {
                [self.DeleteMyProductNotifiedObject didRequestDeleteMyProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 30:
        {
            if (isObjectNotNil(self.ShareMyProductNotifiedObject)) {
                [self.ShareMyProductNotifiedObject didRequestShareMyProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 31:
        {
            if (isObjectNotNil(self.MyHeadTaskListNotifiedObject)) {
                [self.MyHeadTaskListNotifiedObject didRequestMyHeadTaskListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 32:
        {
            if (isObjectNotNil(self.MyEveryDayTaskDetailListNotifiedObject)) {
                [self.MyEveryDayTaskDetailListNotifiedObject didRequestMyEveryDayTaskDetailListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 33:
        {
            if (isObjectNotNil(self.MyEveryDayTaskNotifiedObject)) {
                [self.MyEveryDayTaskNotifiedObject didRequestMyEveryDayTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 35:
        {
            if (isObjectNotNil(self.MyCourseListNotifiedObject)) {
                [self.MyCourseListNotifiedObject didRequestMyCourseListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 36:
        {
            if (isObjectNotNil(self.MyAttendanceListNotifiedObject)) {
                [self.MyAttendanceListNotifiedObject didRequestMyAttendanceListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 37:
        {
            if (isObjectNotNil(self.MyCourseCostNotifiedObject)) {
                [self.MyCourseCostNotifiedObject didRequestMyCourseCostFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 38:
        {
            if (isObjectNotNil(self.BuyCourseRecordNotifiedObject)) {
                [self.BuyCourseRecordNotifiedObject didRequestBuyCourseRecordFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 39:
        {
            if (isObjectNotNil(self.MyAchievementListNotifiedObject)) {
                [self.MyAchievementListNotifiedObject didRequestMyAchievementListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 40:
        {
            if (isObjectNotNil(self.MyStudyTimeLengthListNotifiedObject)) {
                [self.MyStudyTimeLengthListNotifiedObject didRequestMyStudyTimeLengthListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 41:
        {
            if (isObjectNotNil(self.MyStudyTimeLengthDetailListNotifiedObject)) {
                [self.MyStudyTimeLengthDetailListNotifiedObject didRequestMyStudyTimeLengthDetailListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 42:
        {
            if (isObjectNotNil(self.PunchCardListNotifiedObject)) {
                [self.PunchCardListNotifiedObject didRequestPunchCardListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 85:
        {
            if (isObjectNotNil(self.MyCourse_BigCourseListNotifiedObject)) {
                [self.MyCourse_BigCourseListNotifiedObject didRequestMyCourse_BigCourseListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 86:
        {
            if (isObjectNotNil(self.CurrentWeekCourseListNotifiedObject)) {
                [self.CurrentWeekCourseListNotifiedObject didRequestCurrentWeekCourseListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
    
}


@end
