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
#import "Community.h"
#import "AFAppDotNetAPIClient.h"
#import "NewCars.h"
#import "BrandDetail.h"
@implementation DownLoadData
#pragma mark--资讯下载数据
+ (NSURLSessionDataTask *)getInformationDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address{
    NSDictionary *dic = @{@"page":address};
    return [[AFAppDotNetAPIClient sharedClient] POST:@"http://api.qctt.cn/qctt/2/index.php/News/getNewsList" parameters:dic success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *informations = [NSMutableArray array];
        NSMutableDictionary *dic = JSON[@"data"];
        NSArray *array = dic[@"newsList"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            //资讯数据模型
            Information *infor = [Information informationWithDic:obj];
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
+ (NSURLSessionDataTask *)getSrcollerDataWithBlock:(void (^)(NSArray *posts, NSError *error))block{
    
    return [[AFAppDotNetAPIClient sharedClient] GET:@"http://api.qctt.cn/qctt/2/index.php/Adverqctt/getFocus" parameters:self success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *scrollers = [NSMutableArray array];
        NSMutableDictionary *dic = JSON[@"data"];
        NSArray *array = dic[@"focusList"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            ScrollerModel *scroller = [ScrollerModel ScrollerModelWithDic:obj];
            [scrollers addObject:scroller];
            }];
            if (block) {
                block(scrollers,nil);
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (block) {
            block(nil,error);
        }
    }];
}
#pragma mark--社区数据下载
+ (NSURLSessionDataTask *)getCommunityDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address{
    return [[AFAppDotNetAPIClient sharedClient] GET:address parameters:self success:^(NSURLSessionDataTask *task, NSMutableArray *JSON) {
        NSMutableArray *commsArray = [NSMutableArray array];
        [JSON enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            Community *comm = [Community CommunityWithDic:obj];
            [commsArray addObject:comm];
        }];
        if (block) {
            block(commsArray, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];
}
#pragma mark--品牌详情
+ (NSURLSessionDataTask *)getBrandDetailDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address{
    NSDictionary *dic = @{@"brand_id":address};
    return [[AFAppDotNetAPIClient sharedClient] POST:@"http://mczsapi.qctt.cn/index.php/Selection/getBrandCarTypeList" parameters:dic success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *brandDetail = [NSMutableArray array];
        NSArray *array = JSON[@"data"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            BrandDetail *brand = [BrandDetail BrandDetailWithDic:obj];
            [brandDetail addObject:brand];
        }];
        if (block) {
            block(brandDetail,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];

    
}
#pragma mark--行业新闻
+ (NSURLSessionDataTask *)getIndustryDataWithBlock:(void (^)(NSArray *posts, NSError *error))block andAddress:(NSString *)address{
    NSDictionary *dic = @{@"page":address,@"classId":@"3"};
    return [[AFAppDotNetAPIClient sharedClient] POST:@"http://api.qctt.cn/qctt/2/index.php/News/getNewsList" parameters:dic success:^(NSURLSessionDataTask *task, NSDictionary *JSON) {
        NSMutableArray *informations = [NSMutableArray array];
        NSMutableDictionary *dic = JSON[@"data"];
        NSArray *array = dic[@"newsList"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            //行业数据模型
            Information *infor = [Information informationWithDic:obj];
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
@end
