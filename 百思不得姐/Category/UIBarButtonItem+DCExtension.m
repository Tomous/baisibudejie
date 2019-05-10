//
//  UIBarButtonItem+DCExtension.m
//  百思不得姐
//
//  Created by 大橙子 on 2018/10/26.
//  Copyright © 2018 Tomous. All rights reserved.
//

#import "UIBarButtonItem+DCExtension.h"

@implementation UIBarButtonItem (DCExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    /** 获取button里面image的尺寸**/
    //    button.size = [UIImage imageNamed:@"MainTagSubIcon"].size;
    //    button.size = [button imageForState:UIControlStateNormal].size;
    //    button.size = [button currentImage].size;
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}
@end
