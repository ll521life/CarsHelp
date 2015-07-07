//
//  InfomationTableViewCell.m
//  CarsHelp
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "InfomationTableViewCell.h"
#import "Information.h"
#import "UIImageView+WebCache.h"
@interface InfomationTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (weak, nonatomic) IBOutlet UILabel *commmuntCount;
@end
@implementation InfomationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)refreshCell:(Information *)info{
    NSURL *url = [NSURL URLWithString:info.picUrlList[0]];
    [_iconImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"pic_bg"]];
    _title.text = info.title;
    _origin.text = info.publishTime;
    _commmuntCount.text = [NSString stringWithFormat:@"评论(%@)",info.communtCount];
}
@end
