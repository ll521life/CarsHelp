//
//  IntormationViewController.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "IntormationViewController.h"
#import "ScrollerModel.h"
#import "Information.h"
#import "DownLoadData.h"
#import "InfomationTableViewCell.h"
@interface IntormationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) UIScrollView *scrollview;
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *inforArray;

@end

@implementation IntormationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _inforArray = [@[]mutableCopy];
//搭建UI
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT, SCREEN_WIDTH, 180)];
    _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH*6, 180);
    _scrollview.backgroundColor = [UIColor yellowColor];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollview];
//tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT+180, SCREEN_WIDTH, SCREEN_HEIGHT-NAVGATION_ADD_STATUSBAR_HEIGHT-180-TABBAR_HEIGHT)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [DownLoadData getInformationDataWithBlock:^(NSArray *posts, NSError *error) {
        [_inforArray addObjectsFromArray:posts];
        [_tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _inforArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"InfomationTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[InfomationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Information *info = _inforArray[indexPath.row];
//    [(InfomationTableViewCell *)cell refreshCell:info];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
