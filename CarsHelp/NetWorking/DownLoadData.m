//
//  DownLoadData.m
//  007AFN的使用
//
//  Created by qf on 15/5/18.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "DownLoadData.h"
#import "Information.h"
#import "ScrollerModel.h"
#import "AFAppDotNetAPIClient.h"
@implementation DownLoadData
#pragma mark--资讯下载数据
+ (NSURLSessionDataTask *)getInformationDataWithBlock:(void (^)(NSArray *posts, NSError *error))block{
    return [[AFAppDotNetAPIClient sharedClient] GET:@"News/getNewsList" parameters:self success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *informations = [NSMutableArray array];
        NSMutableDictionary *dic = JSON[@"data"];
        NSArray *array = dic[@"newsList"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            //资讯数据模型
            Information *infor = [Information informationWithDic:dic];
            [informations addObject:infor];
        }];
        if (block) {
            block(informations,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];
}
#pragma mark--资讯上面的Scrollerview数据下载
+ (NSURLSessionDataTask *)getSrcollerDataWithBlock:(void (^)(NSArray *, NSError *))block{
    return [[AFAppDotNetAPIClient sharedClient] GET:@"Adverqctt/getFocus" parameters:self success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *scrollers = [NSMutableArray array];
        NSMutableDictionary *dic = JSON[@"data"];
        NSArray *array = dic[@"focusList"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            ScrollerModel *scroller = [ScrollerModel ScrollerModelWithDic:obj];
            [scrollers addObject:scroller];
            if (block) {
                block(scrollers,nil);
            }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];
}

@end
