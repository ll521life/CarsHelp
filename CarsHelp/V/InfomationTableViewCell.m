//
//  InfomationTableViewCell.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "InfomationTableViewCell.h"
@interface InfomationTableViewCell ()
@property (nonatomic, copy) UIImageView *iconImageView;
@property (nonatomic, copy) UILabel *title;
@property (nonatomic, copy) UILabel *origin;
@property (nonatomic, copy) UILabel *communtCount;
@end
@implementation InfomationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
