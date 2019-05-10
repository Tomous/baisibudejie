//
//  DCTabBarViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2018/10/26.
//  Copyright © 2018 Tomous. All rights reserved.
//

#import "DCTabBarViewController.h"
#import "DCTabBar.h"
#import "DCNavigationController.h"
#import "DCEssenceViewController.h"
#import "DCNewViewController.h"
#import "DCFocusViewController.h"
#import "DCMeViewController.h"
@interface DCTabBarViewController ()

@end

@implementation DCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    
    /**  更换tabBar */
    [self setValue:[[DCTabBar alloc] init] forKey:@"tabBar"];
}
/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
}
/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setUpOneChildViewController:[[DCNavigationController alloc]initWithRootViewController:[[DCEssenceViewController alloc] init]] title:@"精华" image:@"tabBar_essence_icon" selectedImg:@"tabBar_essence_click_icon"];
    [self setUpOneChildViewController:[[DCNavigationController alloc]initWithRootViewController:[[DCNewViewController alloc] init]] title:@"新帖" image:@"tabBar_new_icon" selectedImg:@"tabBar_new_click_icon"];
    [self setUpOneChildViewController:[[DCNavigationController alloc]initWithRootViewController:[[DCFocusViewController alloc] init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImg:@"tabBar_friendTrends_click_icon"];
    [self setUpOneChildViewController:[[DCNavigationController alloc]initWithRootViewController:[[DCMeViewController alloc] init]] title:@"我" image:@"tabBar_me_icon" selectedImg:@"tabBar_me_click_icon"];
    
}
-(void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImg:(NSString *)selectedImg
{
    vc.tabBarItem.title = title;
    UIImage *selImage = [UIImage imageNamed:selectedImg];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = selImage;
    }
    [self addChildViewController:vc];
    
}

@end
