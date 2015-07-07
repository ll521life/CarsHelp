//
//  InfomationTableViewCell.h
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Information;
@interface InfomationTableViewCell : UITableViewCell
- (void)refreshCell:(Information *)info;
@end
