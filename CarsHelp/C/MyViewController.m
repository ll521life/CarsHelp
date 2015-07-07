//
//  MyViewController.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "MyViewController.h"
#import "CollectViewController.h"
#import "AboutViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) UITableView *tableview;
@property (nonatomic, copy) NSString  *size;
@property (nonatomic, copy) UITableViewCell *cell;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationItem.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVGATION_ADD_STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVGATION_ADD_STATUSBAR_HEIGHT-TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
   }
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    _size = [NSString stringWithFormat:@"%.1fM", [self folderSizeAtPath:path]];
    _cell.detailTextLabel.text = _size;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 缓存清理
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
   // _size = folderSize;
    return folderSize/(1024.0*1024.0);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.section == 1){
        _cell = cell;
        cell.textLabel.text = @"清理缓存";
       
        cell.detailTextLabel.text = _size;
    }else{
        cell.textLabel.text = @"关于我们";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        //cell.detailTextLabel.text = @""
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        
        NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
       // NSLog(@"%@",str);
        _cell.detailTextLabel.text = @"0M";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"≧︿≦清理完成" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *p in files) {
            NSError *error;
            NSString *Path = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }
    }else if (indexPath.section == 0){
        CollectViewController *collectVC = [[CollectViewController alloc] init];
        [self.navigationController pushViewController:collectVC animated:YES];
        
    }else{
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

@end
