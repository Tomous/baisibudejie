//
//  DCPlayViewController.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/8.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class DCTopic;
@interface DCPlayViewController : DCBaseViewController
/** 模型数据 */
@property (nonatomic,strong) DCTopic *topic;
@end

NS_ASSUME_NONNULL_END
