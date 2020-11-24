//
//  ProductShowOperation.h
//  qianshutang
//
//  Created by aaa on 2018/9/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductShowOperation : NSObject

@property (nonatomic, strong)NSArray * productShowList;
- (void)didRequestProductShowListWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_ProductShowList>)object;
- (void)didRequestDeleteProductShowMyProductWithWithDic:(NSDictionary *)infoDic withNotifiedObject:(id<ProductShow_DeleteProductShowMyProduct>)object;

@end
