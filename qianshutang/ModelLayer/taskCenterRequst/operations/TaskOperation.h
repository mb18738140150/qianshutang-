//
//  TaskOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskOperation : NSObject

@property (nonatomic, assign)int starCount;
@property (nonatomic, strong)NSDictionary * taskProbemContentInfo;
@property (nonatomic, strong)NSDictionary * uploadRecordInfo;


- (void)didRequestUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadWholeRecordProduct>)object;
- (void)didRequestUploadPagingRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_UploadPagingRecordProduct>)object;
- (void)didRequestReadTextWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_ReadText>)object;
- (void)didRequestSubmitMoerduoAndReadTaskWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitMoerduoAndReadTask>)object;
- (void)didRequestSubmitCreateProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_SubmitCreateProduct>)object;
- (void)didRequestCreateTaskProblemContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_CreateTaskProblemContent>)object;
- (void)didRequestAgainUploadWholeRecordProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<Task_AgainUploadWholeRecordProduct>)object;

@end
