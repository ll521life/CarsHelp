//
//  RootTabBarViewController.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "IntormationViewController.h"
#import "CommunityViewController.h"
#import "CarViewController.h"
#import "MyViewController.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#pragma mark--资讯
    IntormationViewController *inforVC = [[IntormationViewController alloc] initWithNibName:@"IntormationViewController" bundle:nil];
    UINavigationController *inforNac = [[UINavigationController alloc] initWithRootViewController:inforVC];
    inforNac.tabBarItem.title =@"资讯";
    [inforNac.tabBarItem setImage:[UIImage imageNamed:@"zixun"]];
    inforNac.tabBarItem.selectedImage = [UIImage imageNamed:@"zixun2"];
#pragma mark--社区
    CommunityViewController *commVC = [[CommunityViewController alloc] initWithNibName:@"CommunityViewController" bundle:nil];
    UINavigationController *commNac = [[UINavigationController alloc] initWithRootViewController:commVC];
    commNac.tabBarItem.title = @"社区";
    commNac.tabBarItem.image = [UIImage imageNamed:@"yanjiuyuan"];
    commNac.tabBarItem.selectedImage = [UIImage imageNamed:@"yanjiuyuan2"];
#pragma mark--购车
    CarViewController *carVC = [[CarViewController alloc] initWithNibName:@"CarViewController" bundle:nil];
    UINavigationController *carNac = [[UINavigationController alloc] initWithRootViewController:carVC];
    carNac.tabBarItem.title = @"选车";
    carNac.tabBarItem.image = [UIImage imageNamed:@"xuanche"];
    carNac.tabBarItem.selectedImage = [UIImage imageNamed:@"xuanche2"];
#pragma mark--我的
    MyViewController *myVC = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    UINavigationController *myNac = [[UINavigationController alloc] initWithRootViewController:myVC];
    myNac.tabBarItem.title = @"个人";
    myNac.tabBarItem.image = [UIImage imageNamed:@"wode"];
    myNac.tabBarItem.selectedImage = [UIImage imageNamed:@"wode2"];
    
    self.viewControllers = @[inforNac,commNac,carNac,myNac];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsCompact];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarBg"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
