//
//  ScrollerModel.h
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollerModel : NSObject
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *jumptype;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *playTime;
@property (nonatomic, copy) NSString *resourceLoc;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (ScrollerModel *)ScrollerModelWithDic:(NSDictionary *)dic;
@end
