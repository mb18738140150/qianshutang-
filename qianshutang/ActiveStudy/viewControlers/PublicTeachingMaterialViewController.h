//
//  PublicTeachingMaterialViewController.h
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "BasicViewController.h"

typedef enum : NSUInteger {
    MaterialType_read,
    MaterialType_public,
} MaterialType;

@interface PublicTeachingMaterialViewController : BasicViewController

@property (nonatomic, assign)MaterailType materialType;

@end
