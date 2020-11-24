//
//  ProductShowOperation.m
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ProductShowOperation.h"

@interface ProductShowOperation()<HttpRequestProtocol>

@property (nonatomic,weak) id<ProductShow_ProductShowList> notifiedObject;

@property (nonatomic,weak) id<ProductShow_DeleteProductShowMyProduct> deletenotifiedObject;

@end


@implementation ProductShowOperation

- (void)didRequestProductShowListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_ProductShowList>)object
{
    self.notifiedObject = object;
   [[HttpRequestManager sharedManager] reqeustProductShowListWithDic:infoDic andProcessDelegate:self];
}
- (void)didRequestDeleteProductShowMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_DeleteProductShowMyProduct>)object
{
    self.deletenotifiedObject = object;
    [[HttpRequestManager sharedManager] reqeustDeleteProductShowMyProductWithDic:infoDic andProcessDelegate:self];
}

#pragma mark - http request
- (void)didRequestSuccessed:(NSDictionary *)successInfo
{
    switch ([[successInfo objectForKey:@"command"] intValue]) {
        case 66:
        {
            self.productShowList = [successInfo objectForKey:@"data"];
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestProductShowListSuccessed];
            }
        }
            break;
        case 67:
        {
            if (isObjectNotNil(self.deletenotifiedObject)) {
                [self.deletenotifiedObject didRequestDeleteProductShowMyProductSuccessed];
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
        case 66:
        {
            if (isObjectNotNil(self.notifiedObject)) {
                [self.notifiedObject didRequestProductShowListFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
        case 67:
        {
            if (isObjectNotNil(self.deletenotifiedObject)) {
                [self.deletenotifiedObject didRequestDeleteProductShowMyProductFailed:[failedInfo objectForKey:kErrorMsg]];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
