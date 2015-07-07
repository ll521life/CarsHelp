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
#import "AddCell.h"
#import "LeftViewController.h"
#import "PPRevealSideViewController.h"
#import "InformationDetailViewController.h"
@interface IntormationViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    __block int page;
    MBProgressHUD *_HUD;
}
//@property (nonatomic, copy) UIScrollView *scrollview;
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *inforArray;
@property (nonatomic, copy) NSArray *scrollerArray;
@property (nonatomic, copy) AddCell *add;

@end

@implementation IntormationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _inforArray = [@[]mutableCopy];
    _scrollerArray = [@[]mutableCopy];
    //添加左侧button
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"main_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(changeVC)];
    self.navigationItem.leftBarButtonItem = leftButton;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1]];
//搭建UI
//tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVGATION_ADD_STATUSBAR_HEIGHT-TABBAR_HEIGHT)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//注册cell
//    UINib *nibName = [UINib nibWithNibName:@"InfomationTableViewCell" bundle:nil];
//    [_tableView registerNib:nibName forCellReuseIdentifier:@"InfomationTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
//上拉刷新
    page = 0;
//MUB刷新
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    [_HUD show:YES];
    ///=======================
  //  [_tableView.footer setHidden:YES];
    [_tableView addLegendFooterWithRefreshingBlock:^{
        NSString *string = [NSString stringWithFormat:@"%d" ,(int)page++];

        [DownLoadData getInformationDataWithBlock:^(NSArray *posts, NSError *error) {
            [_tableView.footer endRefreshing];
            [_HUD hide:YES];
            [_inforArray addObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });

        } andAddress:string];
  
    }];
    //开始刷新
    [_tableView.footer beginRefreshing];
    //下拉刷新
    
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [DownLoadData getInformationDataWithBlock:^(NSArray *posts, NSError *error) {
            [_inforArray removeAllObjects];
            [_tableView.header endRefreshing];
            [_inforArray addObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        } andAddress:@"0"];

    }];
    //开始刷新
  //  [_tableView.header beginRefreshing];
//添加手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove :)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeLeft];
//    //右滑
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.view addGestureRecognizer:swipeRight];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _inforArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *cellID = [NSString string];
    if (indexPath.row == 0) {
        cellID = @"Addcell";
    }else{
        cellID = @"InfomationTableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (indexPath.row == 0) {
            cell = [[AddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Addcell"];
        }else{
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InfomationTableViewCell" owner:nil options:nil] lastObject];
        }
    }if (indexPath.row > 0) {
        Information *info = _inforArray[indexPath.row-1];
        [(InfomationTableViewCell *)cell refreshCell:info];
    }
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //广告栏高度
    if (indexPath.row == 0) {
        return 180;
    }
    return 90;
}
#pragma mark--changeVC
- (void) changeVC{
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.revealSideViewController  pushViewController:leftVC onDirection:PPRevealSideDirectionLeft withOffset:SCREEN_WIDTH/3.0 animated:YES];
}
- (void) handleMove:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        LeftViewController *leftVC = [[LeftViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:leftVC];
        [self.revealSideViewController pushViewController:leftVC onDirection:PPRevealSideDirectionLeft withOffset:SCREEN_WIDTH/3.0 animated:YES];
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationDetailViewController *inforDetailVC = [[InformationDetailViewController alloc] init];
    inforDetailVC.hidesBottomBarWhenPushed = YES;
    Information *info = _inforArray[indexPath.row-1];
    inforDetailVC.inforCollect = info;
    inforDetailVC.newsId = info.resourceLoc;
    [self.navigationController pushViewController:inforDetailVC animated:YES];
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
