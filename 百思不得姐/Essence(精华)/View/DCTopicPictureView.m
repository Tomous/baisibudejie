//
//  DCTopicPictureView.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/7.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicPictureView.h"
#import "DCTopic.h"
#import "DCTopicPictureController.h"
@interface DCTopicPictureView ()
@property (nonatomic,strong) UIImageView *markImage;
@property (nonatomic,strong) UIImageView *gifImage;
@property (strong, nonatomic) FLAnimatedImageView *imageView;
@property (strong, nonatomic) UIButton *seeBigButton;
@property (strong, nonatomic) DALabeledCircularProgressView *progressView;

@end
@implementation DCTopicPictureView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *markImage = [[UIImageView alloc]initWithImage:IMAGENAME(@"imageBackground")];
        markImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:markImage];
        self.markImage = markImage;
        
        self.imageView = [[FLAnimatedImageView alloc]init];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.imageView];
        self.imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView)];
        [self.imageView addGestureRecognizer:tap];
        
        UIImageView *gifImage = [[UIImageView alloc]initWithImage:IMAGENAME(@"common-gif")];
        gifImage.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:gifImage];
        self.gifImage = gifImage;
        
        self.seeBigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.seeBigButton setTitle:@"点击查看大图" forState:UIControlStateNormal];
        [self.seeBigButton setImage:IMAGENAME(@"see-big-picture") forState:UIControlStateNormal];
        [self.seeBigButton setBackgroundImage:IMAGENAME(@"see-big-picture-background") forState:UIControlStateNormal];
        [self.seeBigButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [self.seeBigButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [self.seeBigButton addTarget:self action:@selector(tapImageView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.seeBigButton];
        
        self.progressView = [[DALabeledCircularProgressView alloc]init];
        self.progressView.roundedCorners = 5;
        self.progressView.progressLabel.textColor = [UIColor redColor];
        self.progressView.progressTintColor = [UIColor lightGrayColor];
//        self.progressView.trackTintColor = [UIColor clearColor];
//        self.progressView.thicknessRatio = 0.2f;
//        self.progressView.clockwiseProgress = NO;//顺时针
        [self addSubview:self.progressView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.markImage.frame = CGRectMake(0, 20, self.width, 30);
    self.imageView.frame = self.bounds;
    self.gifImage.frame = CGRectMake(0, 0, 31, 31);
    self.seeBigButton.frame = CGRectMake(0, self.height- 43, self.width, 43);
    
    self.progressView.size = CGSizeMake(100, 100);
    self.progressView.center = self.imageView.center;
    
}
-(void)setTopic:(DCTopic *)topic {
    _topic = topic;
    // 网络判断
//    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    if (status == AFNetworkReachabilityStatusReachableViaWWAN) { // 手机自带网络
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image]];
//    } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) { // WIFI
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
//    } else { // 网络有问题, 清空当前显示的图片
//        self.imageView.image = nil;
//    }
    // 由于是模拟器(直接显示大图)
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        // receivedSize : 已经接收的图片大小
        // expectedSize : 图片的总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.hidden = NO;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
        
        if ([topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {
            [self DC_gifForUrl:topic.large_image];
        }
    }];
    
//http://4234234.GIF -> http://4234234.gif
//
//    gif
//    if ([topic.large_image.lowercaseString hasSuffix:@"gif"]) {
//        if ([topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]) {
//            if (topic.is_gif) {
//                self.gifView.hidden = NO;
//            } else {
//                self.gifView.hidden = YES;
//            }
    // gif
    self.gifImage.hidden = !topic.is_gif;
    
    // 查看大图
    if (topic.isBigPicture) {// 超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }

}

/**  gif图片处理 */
- (void)DC_gifForUrl:(NSString*)url {
    
    id obj = [[self getCache] objectForKey:url];
    if (obj != nil ) {
        self.imageView.animatedImage= (FLAnimatedImage*)obj;
        //TGLog(@"缓存中的 -- %@",url);
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        FLAnimatedImage *flImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [[self getCache] setObject:flImage forKey:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            //TGLog(@"下载的 -- %@",url);
            if (self.topic.large_image == url){
                self.imageView.animatedImage= flImage;
            }else{
                //DCLog(@"# 错位了 不用设置gif（重用机制造成的，原理请参考SDWebImage）#");
            }
        });
    });
}
- (NSCache*)getCache{
    static NSCache * cache =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc]init];
        cache.countLimit = GIFCacheCountLimit;//关键
        //TGLog(@"-- 自己的缓存策略 --");
    });
    return cache;
}
/**  点击图片 */
-(void)tapImageView {
    DCTopicPictureController *pictureVC = [[DCTopicPictureController alloc]init];
    pictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVC animated:NO completion:nil];
}
@end
