//
//  TaskOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskOperation.h"

@interface TaskOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<Task_UploadWholeRecordProduct> UploadWholeRecordProductnotifiedObject;
@property (nonatomic,weak) id<Task_UploadPagingRecordProduct> UploadPagingRecordProductnotifiedObject;
@property (nonatomic,weak) id<Task_ReadText> ReadTextnotifiedObject;
@property (nonatomic,weak) id<Task_SubmitMoerduoAndReadTask> SubmitMoerduoAndReadTasknotifiedObject;
@property (nonatomic,weak) id<Task_SubmitCreateProduct> SubmitCreateProductnotifiedObject;
@property (nonatomic,weak) id<Task_CreateTaskProblemContent> CreateTaskProblemContentnotifiedObject;
@property (nonatomic,weak) id<Task_AgainUploadWholeRecordProduct> AgainUploadWholeRecordProductnotifiedObject;

@end

@implementation TaskOperation

- (void)didRequestAgainUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_AgainUploadWholeRecordProduct>)object
{
    self.AgainUploadWholeRecordProductnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustAgainUploadWholeRecordProductWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadWholeRecordProduct>)object
{
    self.UploadWholeRecordProductnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustUploadWholeRecordProductWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestUploadPagingRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadPagingRecordProduct>)object
{
    self.UploadPagingRecordProductnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustUploadPagingRecordProductWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestReadTextWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_ReadText>)object
{
    self.ReadTextnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustReadTextWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestSubmitMoerduoAndReadTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitMoerduoAndReadTask>)object
{
    self.SubmitMoerduoAndReadTasknotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustSubmitMoerduoAndReadTaskWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestSubmitCreateProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitCreateProduct>)object
{
    self.SubmitCreateProductnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustSubmitCreateProductWithDic:infoDic andProcessDelegate:self];
}

- (void)didRequestCreateTaskProblemContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_CreateTaskProblemContent>)object
{
    self.CreateTaskProblemContentnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustCreateTaskProblemContentWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 75:
        {
            self.starCount = [[successInfo objectForKey:@"starNum"] intValue];
            self.uploadRecordInfo = successInfo;
            if (isObjectNotNil(self.UploadWholeRecordProductnotifiedObject)) {
                [self.UploadWholeRecordProductnotifiedObject didRequestUploadWholeRecordProductSuccessed];
            }
        }
            break;
        case 76:
        {
            if (isObjectNotNil(self.UploadPagingRecordProductnotifiedObject)) {
                [self.UploadPagingRecordProductnotifiedObject didRequestUploadPagingRecordProductSuccessed];
            }
        }
            break;
        case 78:
        {
            if (isObjectNotNil(self.ReadTextnotifiedObject)) {
                [self.ReadTextnotifiedObject didRequestReadTextSuccessed];
            }
        }
            break;
        case 79:
        {
            self.starCount = [[successInfo objectForKey:@"starNum"] intValue];
            if (isObjectNotNil(self.SubmitMoerduoAndReadTasknotifiedObject)) {
                [self.SubmitMoerduoAndReadTasknotifiedObject didRequestSubmitMoerduoAndReadTaskSuccessed];
            }
        }
            break;
        case 80:
        {
            if (isObjectNotNil(self.SubmitCreateProductnotifiedObject)) {
                [self.SubmitCreateProductnotifiedObject didRequestSubmitCreateProductSuccessed];
            }
        }
            break;
        case 84:
        {
            self.taskProbemContentInfo = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.CreateTaskProblemContentnotifiedObject)) {
                if ([self.CreateTaskProblemContentnotifiedObject respondsToSelector:@selector(didRequestCreateTaskProblemContentSuccessed)]) {
                    [self.CreateTaskProblemContentnotifiedObject didRequestCreateTaskProblemContentSuccessed];
                }
            }
        }
            break;
        case 88:
        {
            self.starCount = [[successInfo objectForKey:@"starNum"] intValue];
            if (isObjectNotNil(self.AgainUploadWholeRecordProductnotifiedObject)) {
                [self.AgainUploadWholeRecordProductnotifiedObject didRequestAgainUploadWholeRecordProductSuccessed];
            }
        }
            break;
        default:
            break;
    }
}
//[failedInfo objectForKey:kErrorMsg]
- (void)didRequestFailedWithInfo:(NSDictionary *)failedInfo
{
    switch ([[failedInfo objectForKey:@"command"] intValue]) {
        case 75:
        {
            if (isObjectNotNil(self.UploadWholeRecordProductnotifiedObject)) {
                [self.UploadWholeRecordProductnotifiedObject didRequestUploadWholeRecordProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 76:
        {
            if (isObjectNotNil(self.UploadPagingRecordProductnotifiedObject)) {
                [self.UploadPagingRecordProductnotifiedObject didRequestUploadPagingRecordProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 78:
        {
            if (isObjectNotNil(self.ReadTextnotifiedObject)) {
                [self.ReadTextnotifiedObject didRequestReadTextFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 79:
        {
            if (isObjectNotNil(self.SubmitMoerduoAndReadTasknotifiedObject)) {
                [self.SubmitMoerduoAndReadTasknotifiedObject didRequestSubmitMoerduoAndReadTaskFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 80:
        {
            if (isObjectNotNil(self.SubmitCreateProductnotifiedObject)) {
                [self.SubmitCreateProductnotifiedObject didRequestSubmitCreateProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 84:
        {
            if (isObjectNotNil(self.CreateTaskProblemContentnotifiedObject)) {
//                [self.CreateTaskProblemContentnotifiedObject didRequestCreateTaskProblemContentFailed:[failedInfo objectForKey:kErrorMsg]];
                if ([self.CreateTaskProblemContentnotifiedObject respondsToSelector:@selector(didRequestCreateTaskProblemContentFailed:)]) {
                    [self.CreateTaskProblemContentnotifiedObject didRequestCreateTaskProblemContentFailed:[failedInfo objectForKey:kErrorMsg]];
                }
            }
        }
            break;
        case 88:
        {
            if (isObjectNotNil(self.AgainUploadWholeRecordProductnotifiedObject)) {
                [self.AgainUploadWholeRecordProductnotifiedObject didRequestAgainUploadWholeRecordProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
