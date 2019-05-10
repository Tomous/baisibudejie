//
//  DCMeFooterView.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/15.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCMeFooterView.h"
#import "DCMeSquare.h"
#import "DCMeSquareButton.h"
#import "DCWebViewController.h"
@implementation DCMeFooterView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [DCService getMeSquaresMsgWithDic:params success:^(id  _Nonnull responseObject) {
            NSArray *squares = [DCMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares {
    
    int maxColsCount = 4;
    CGFloat buttonW = self.width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count-1; i ++) {
        DCMeSquareButton *button = [DCMeSquareButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i % maxColsCount *buttonW, i / maxColsCount *buttonH, buttonW, buttonH);
        
        button.square = squares[i];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.height = self.subviews.lastObject.bottom;
    
    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData]; // 重新刷新数据(会重新计算contentSize)
}
- (void)buttonClick:(DCMeSquareButton *)button {
    DCMeSquare *square = button.square;
    if ([square.url hasPrefix:@"http"]) {// 利用webView加载url即可
        DCLog(@"利用webView加载url");
        DCWebViewController *webVC = [[DCWebViewController alloc]init];
        webVC.url = square.url;
        webVC.navigationItem.title = button.currentTitle;
        
        UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVC.selectedViewController;
        [nav pushViewController:webVC animated:YES];
        
    }else if ([square.url hasPrefix:@"mod"]) {// 另行处理
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            DCLog(@"跳转到[审帖]界面");
        } else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]) {
            DCLog(@"跳转到[每日排行]界面");
        } else {
            DCLog(@"跳转到其他界面");
        }
    }else {
        DCLog(@"不是http或者mod协议的");
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
