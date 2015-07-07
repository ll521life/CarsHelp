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
#pragma mark --归档时对数据的处理
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_resourceLoc forKey:@"resourceLoc"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_publishTime forKey:@"publishTime"];
    [aCoder encodeObject:_picUrlList forKey:@"picUrlList"];
    
    
}

#pragma mark --解档将aDecoder里面的数据取出
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        _resourceLoc = [aDecoder decodeObjectForKey:@"resourceLoc"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _publishTime = [aDecoder decodeObjectForKey:@"publishTime"];
        _picUrlList = [aDecoder decodeObjectForKey:@"picUrlList"];
        
    }
    
    return self;
}


+ (BOOL)supportsSecureCoding{
    
    return YES;
}
@end
