//
//  DCMeSquareButton.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/15.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCMeSquare;

@interface DCMeSquareButton : UIButton
/** 方块模型 */
@property (nonatomic, strong) DCMeSquare *square;
@end

NS_ASSUME_NONNULL_END
