//
//  CarViewController.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "CarViewController.h"
#import "DownLoadData.h"
#import "NewCars.h"
#import "NewCarsCell.h"
#import "Brand.h"
#import "BrandCell.h"
#import "RightViewController.h"
#import "PPRevealSideViewController.h"
#import "Information.h"
#import "NewCarDetailViewController.h"
@interface CarViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
{
    MBProgressHUD *_HUD;
    __block int page;
}
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *carArray;
@property (nonatomic, copy) NSMutableArray *brandArray;
@property (nonatomic, assign) NSInteger index;
@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *items = @[@"导购",@"品牌介绍"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentControl.tintColor = [UIColor whiteColor];
   // segmentControl.momentary = YES;
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentControl;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.index = 0;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVGATION_ADD_STATUSBAR_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _carArray = [@[]mutableCopy];
    _brandArray = [@[]mutableCopy];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    [self.view addSubview:_HUD];
//cell注册======================
    UINib *nibName = [UINib nibWithNibName:@"NewCarsCell" bundle:nil];
    [_tableView registerNib:nibName forCellReuseIdentifier:@"NewCarsCell"];
    
   // NSDate *expiresDate = [NSDate dateWithTimeIntervalSince1970:1433925514];
//因为接口不一样，所以使用NSURLConnection获取数据(下载新车速递数据)
    [_HUD show:YES];
    [_tableView addLegendFooterWithRefreshingBlock:^{
        NSString *string = [NSString stringWithFormat:@"%d" ,(int)page++];
        
        [DownLoadData getIndustryDataWithBlock:^(NSArray *posts, NSError *error) {
            [_tableView.footer endRefreshing];
            [_HUD hide:YES];
            [_carArray addObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        } andAddress:string];
        
    }];
    //开始刷新
    [_tableView.footer beginRefreshing];
    //下拉刷新
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        [DownLoadData getIndustryDataWithBlock:^(NSArray *posts, NSError *error) {
            [_carArray removeAllObjects];
            [_tableView.header endRefreshing];
            //[_inforArray addObjectsFromArray:posts];
            [_carArray addObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        } andAddress:@"0"];
        
    }];

    
//下载品牌数据
    NSString *pathBrand = @"http://mczsapi.qctt.cn/index.php/Selection/getBrandList";
    NSURL *urlBrand = [NSURL URLWithString:pathBrand];
    NSURLRequest *requestBrand = [NSURLRequest requestWithURL:urlBrand];
    NSOperationQueue *queueBrand = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:requestBrand queue:queueBrand completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            Brand *brand = [Brand brandWithDic:obj];
            [_brandArray addObject:brand];
        }];
        [_tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择变化时调用
- (void)segmentControlValueChanged:(UISegmentedControl *)segmentedControl{
    _index = segmentedControl.selectedSegmentIndex;
    NSLog(@"%ld",_index);
    [_tableView reloadData];
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_index == 0) {
        return _carArray.count;
    }else{
        return _brandArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index == 0) {
      NSString *cellID = @"NewCarsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NewCarsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
     Information *car = _carArray[indexPath.row];
   
    [(NewCarsCell *)cell refreshCell:car];
    return cell;
    }else{
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"BrandCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BrandCell" owner:nil options:nil] lastObject];
        Brand *brand = _brandArray[indexPath.row];
        [(BrandCell*)cell refreshCell:brand];
        return cell;
    }
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index == 0) {
        return 90;
    }else{
    return 70;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index == 1) {
        RightViewController *rightVC = [[RightViewController alloc] init];
        Brand *brand = _brandArray[indexPath.row];
        rightVC.address = brand.brand_id;
        [self.revealSideViewController pushViewController:rightVC onDirection:PPRevealSideDirectionRight withOffset:SCREEN_WIDTH/4.0 animated:YES];
    }else{
        NewCarDetailViewController *inforDetailVC = [[NewCarDetailViewController alloc] init];
        inforDetailVC.hidesBottomBarWhenPushed = YES;
        Information *info = _carArray[indexPath.row];
        inforDetailVC.inforCollect = info;
        inforDetailVC.newsId = info.resourceLoc;
        [self.navigationController pushViewController:inforDetailVC animated:YES];
    }
}
@end
