//
//  ScrollerModel.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "ScrollerModel.h"

@implementation ScrollerModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (ScrollerModel *)ScrollerModelWithDic:(NSDictionary *)dic{
    ScrollerModel *scroller = [[ScrollerModel alloc] initWithDic:dic];
    return scroller;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
