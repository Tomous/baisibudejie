//
//  DCComment.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/7.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class DCUser;
@interface DCComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) DCUser *user;
@end

NS_ASSUME_NONNULL_END
