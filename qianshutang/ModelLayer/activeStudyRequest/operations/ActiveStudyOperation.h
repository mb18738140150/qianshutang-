//
//  ActiveStudyOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveStudyOperation : NSObject

@property (nonatomic, strong)NSArray * readList;
@property (nonatomic, strong)NSArray * searchReadList;
@property (nonatomic, strong)NSDictionary * textbookContentInfo;
@property (nonatomic, strong)NSDictionary * textContentInfo;


- (void)didRequestReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_ReadList>)object;
- (void)didRequestSearchReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_SearchReadList>)object;
- (void)didRequestCollectTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_CollectTextBook>)object;
- (void)didRequestTextBookContentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextBookContentList>)object;
- (void)didRequestTextContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextContent>)object;

@end
