//
//  DCNavigationController.m
//  百思不得姐
//
//  Created by 大橙子 on 2018/10/26.
//  Copyright © 2018 Tomous. All rights reserved.
//

#import "DCNavigationController.h"

@interface DCNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation DCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加测滑手势。。只支持ios 7.0以上版本
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
        self.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
    }

    [self.navigationBar setBackgroundImage:IMAGENAME(@"navigationbarBackgroundWhite") forBarMetrics:UIBarMetricsDefault];
}
/**
 *  重写push方法的目的 : 拦截所有push进来的子控制器
 *
 *  @param viewController 刚刚push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {// 如果viewController不是最早push进来的子控制器
        // 左上角
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:IMAGENAME(@"navigationButtonReturn") forState:UIControlStateNormal];
        [backBtn setImage:IMAGENAME(@"navigationButtonReturnClick") forState:UIControlStateHighlighted];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn sizeToFit];
        // 这句代码放在sizeToFit后面
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}


@end
