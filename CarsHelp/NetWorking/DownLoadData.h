//
//  DownLoadData.h
//  007AFN的使用
//
//  Created by qf on 15/5/18.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  Application;
@interface DownLoadData : NSObject
#pragma mark--资讯
+ (NSURLSessionDataTask *)getInformationDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address;
#pragma mark--资讯上面的Scrollerview数据下载
+ (NSURLSessionDataTask *)getSrcollerDataWithBlock:(void (^)(NSArray *posts, NSError *error))block ;
#pragma mark--社区
+ (NSURLSessionDataTask *)getCommunityDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address;
#pragma mark--品牌详情
+ (NSURLSessionDataTask *)getBrandDetailDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address;
#pragma mark--行业新闻
+ (NSURLSessionDataTask *)getIndustryDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address;
@end
