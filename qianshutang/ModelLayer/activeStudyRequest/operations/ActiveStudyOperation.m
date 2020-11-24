//
//  ActiveStudyOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ActiveStudyOperation.h"

@interface ActiveStudyOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<ActiveStudy_ReadList> ReadListnotifiedObject;

@property (nonatomic,weak) id<ActiveStudy_SearchReadList> SearchReadListnotifiedObject;
@property (nonatomic,weak) id<ActiveStudy_CollectTextBook> CollectTextBooknotifiedObject;

@property (nonatomic,weak) id<ActiveStudy_TextBookContentList> TextBookContentListnotifiedObject;
@property (nonatomic,weak) id<ActiveStudy_TextContent> TextContentnotifiedObject;

@property (nonatomic, strong)NSDictionary * infoDic;

@end

@implementation ActiveStudyOperation

- (void)didRequestReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_ReadList>)object
{
    self.ReadListnotifiedObject = object;
    self.infoDic = infoDic;
    [[HttpRequestManager sharedManager] reqeustReadListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestSearchReadListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_SearchReadList>)object
{
    self.SearchReadListnotifiedObject = object;
    self.infoDic = infoDic;
    [[HttpRequestManager sharedManager] reqeustSearchReadListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestCollectTextBookWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_CollectTextBook>)object
{
    self.CollectTextBooknotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustCollectTextBookWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTextBookContentListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextBookContentList>)object
{
    self.TextBookContentListnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTextBookContentListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestTextContentWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ActiveStudy_TextContent>)object
{
    self.TextContentnotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustTextContentWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 70:
        {
            if ([self.infoDic objectForKey:@"itemName"] && [[self.infoDic objectForKey:@"itemName"] length] > 0) {
                self.searchReadList = [successInfo objectForKey:@"data"];
                if (isObjectNotNil(self.SearchReadListnotifiedObject)) {
                    [self.SearchReadListnotifiedObject didRequestSearchReadListSuccessed];
                }
                return;
            }
            
            self.readList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.ReadListnotifiedObject)) {
                [self.ReadListnotifiedObject didRequestReadListSuccessed];
            }
        }
            break;
        case 71:
        {
            self.searchReadList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.SearchReadListnotifiedObject)) {
                [self.SearchReadListnotifiedObject didRequestSearchReadListSuccessed];
            }
        }
            break;
        case 72:
        {
            if (isObjectNotNil(self.CollectTextBooknotifiedObject)) {
                [self.CollectTextBooknotifiedObject didRequestCollectTextBookSuccessed];
            }
        }
            break;
        case 73:
        {
            self.textbookContentInfo = successInfo;
            if (isObjectNotNil(self.TextBookContentListnotifiedObject)) {
                [self.TextBookContentListnotifiedObject didRequestTextBookContentListSuccessed];
            }
        }
            break;
        case 74:
        {
            self.textContentInfo = successInfo;
            if (isObjectNotNil(self.TextContentnotifiedObject)) {
                [self.TextContentnotifiedObject didRequestTextContentSuccessed];
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
        case 70:
        {
            if (isObjectNotNil(self.ReadListnotifiedObject)) {
                [self.ReadListnotifiedObject didRequestReadListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 71:
        {
            if (isObjectNotNil(self.SearchReadListnotifiedObject)) {
                [self.SearchReadListnotifiedObject didRequestSearchReadListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 72:
        {
            if (isObjectNotNil(self.CollectTextBooknotifiedObject)) {
                [self.CollectTextBooknotifiedObject didRequestCollectTextBookFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 73:
        {
            if (isObjectNotNil(self.TextBookContentListnotifiedObject)) {
                [self.TextBookContentListnotifiedObject didRequestTextBookContentListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 74:
        {
            if (isObjectNotNil(self.TextContentnotifiedObject)) {
                [self.TextContentnotifiedObject didRequestTextContentFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
