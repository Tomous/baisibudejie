//
//  UIBarButtonItem+DCExtension.h
//  百思不得姐
//
//  Created by 大橙子 on 2018/10/26.
//  Copyright © 2018 Tomous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DCExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
