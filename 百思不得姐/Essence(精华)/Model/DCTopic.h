//
//  DCTopic.h
//  百思不得姐
//
//  Created by 大橙子 on 2019/4/13.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger,DCTopicType){
    /** 所有 */
    DCTopicTypeAll = 1,
    /** 图片 */
    DCTopicTypePicture = 10,
    /** 段子 */
    DCTopicTypeWord = 29,
    /** 声音 */
    DCTopicTypeVoice = 31,
    /** 视频 */
    DCTopicTypeVideo = 41
};

@class DCComment;

@interface DCTopic : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) DCComment *top_cmt;
/** 帖子类型 */
@property (nonatomic,assign) DCTopicType type;
/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat d_width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat d_height;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频地址url */
@property (nonatomic,copy) NSString *videouri;
/** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;


/***** 额外增加的属性 - 方便开发 *****/
/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** 描述文字的高度 */
@property (nonatomic,assign) CGRect contentTextF;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;
/** 最热评论内容的frame */
@property (nonatomic, assign) CGRect top_cmt_F;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


@end

NS_ASSUME_NONNULL_END
