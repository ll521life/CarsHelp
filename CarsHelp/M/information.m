//
//  Information.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "Information.h"

@implementation Information
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (Information *)informationWithDic:(NSDictionary *)dic{
    Information *infor = [[Information alloc] initWithDic:dic];
    return infor;
}
@end
