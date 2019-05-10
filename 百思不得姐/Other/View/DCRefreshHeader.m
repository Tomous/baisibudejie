//
//  DCRefreshHeader.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/4/13.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCRefreshHeader.h"
@interface DCRefreshHeader ()
/** logo */
@property (nonatomic, weak) UIImageView *logo;
@end
@implementation DCRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
//    [self addSubview:[[UISwitch alloc] init]];
    
//    UIImageView *logo = [[UIImageView alloc] init];
//    logo.image = [UIImage imageNamed:@"bd_logo1"];
//    [self addSubview:logo];
//    self.logo = logo;
}

/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
//    self.logo.width = self.width;
//    self.logo.height = 50;
//    self.logo.x = 0;
//    self.logo.y = - 50;
}

@end
