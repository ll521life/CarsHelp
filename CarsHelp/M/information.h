//
//  Information.h
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject<NSSecureCoding>
@property (nonatomic, copy) NSString *resourceLoc;
@property (nonatomic, copy) NSString *excerpt;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *readCount;
@property (nonatomic, copy) NSString *communtCount;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSArray *picUrlList;
@property (nonatomic, copy) NSString *articleType;
@property (nonatomic, copy) NSString *jumpType;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (Information *)informationWithDic:(NSDictionary *)dic;
@end
