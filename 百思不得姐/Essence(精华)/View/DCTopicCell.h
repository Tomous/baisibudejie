//
//  DCTopicCell.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/4/13.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DCTopic;
@interface DCTopicCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath;
/** 帖子模型数据 */
@property (nonatomic,strong) DCTopic *topic;

@end

NS_ASSUME_NONNULL_END
