//
//  DCService.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/15.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface DCService : NSObject

/**
 获取我的页面 方块里面的数据
 */
+(void)getMeSquaresMsgWithDic:(NSMutableDictionary *__nullable)params
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
