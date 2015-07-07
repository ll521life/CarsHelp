//
//  CommunityViewController.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "CommunityViewController.h"
#import "DownLoadData.h"
#import "CommunityCell.h"
#import "Community.h"
#import "CommunityDetailViewController.h"
@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;
    __block int page ;
}
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *commsArray;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"社区";
    self.automaticallyAdjustsScrollViewInsets  = NO;
    _commsArray = [@[]mutableCopy];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVGATION_ADD_STATUSBAR_HEIGHT-TABBAR_HEIGHT)];
    _tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.5];
    //注册cell
    UINib *nibName = [UINib nibWithNibName:@"CommunityCell" bundle:nil];
    [_tableView registerNib:nibName forCellReuseIdentifier:@"CommunityCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = [[UIView alloc] init];
    [self.view addSubview:_tableView];

    //下载数据
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    [_HUD show:YES];
    page = 0;
    [_tableView addLegendFooterWithRefreshingBlock:^{
        NSString *string = [NSString stringWithFormat:@"http://a.xincheping.com/index.php?a=AppList.ajaxGetViewsList&Page=%d" ,++page];
    [DownLoadData getCommunityDataWithBlock:^(NSArray *posts, NSError *error) {
        [_HUD hide:YES];
        [_tableView.footer endRefreshing];
        [_commsArray addObjectsFromArray:posts];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } andAddress:string];
    }];
    [_tableView.footer beginRefreshing];
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [DownLoadData getCommunityDataWithBlock:^(NSArray *posts, NSError *error) {
            [_commsArray removeAllObjects];
            [_tableView.header endRefreshing];
            
            //[_inforArray addObjectsFromArray:posts];
            [_commsArray addObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        } andAddress:@"http://a.xincheping.com/index.php?a=AppList.ajaxGetViewsList&Page=1"];
        
    }];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CommunityCell";
    CommunityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       // cell.frame = CGRectMake(5, 0, , CGFloat height)
    }
   // cell.frame = CGRectMake(5, indexPath.row*300, SCREEN_WIDTH-10, 295);
    Community *comm = _commsArray[indexPath.row];
    [cell refreshCell:comm];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityDetailViewController *comDetailVC = [[CommunityDetailViewController alloc] init];
    Community *comm = _commsArray[indexPath.row];
    comDetailVC.hidesBottomBarWhenPushed = YES;
    comDetailVC.comm = comm;
    comDetailVC.webUrl = comm.url;
    [self.navigationController pushViewController:comDetailVC animated:YES];
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
