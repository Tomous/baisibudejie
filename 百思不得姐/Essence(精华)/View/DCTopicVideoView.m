//
//  DCTopicVideoView.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/7.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicVideoView.h"
#import "DCTopic.h"
#import "DCPlayViewController.h"
@interface DCTopicVideoView ()
@property (nonatomic,strong) UIImageView *markImage;
@property (strong, nonatomic) UILabel *playCountLabel;
@property (strong, nonatomic) UILabel *videoTimeLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic,strong) UIButton *playBtn;
@end
@implementation DCTopicVideoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *markImage = [[UIImageView alloc]initWithImage:IMAGENAME(@"imageBackground")];
        markImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:markImage];
        self.markImage = markImage;
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.imageView];
        
        self.playCountLabel = [[UILabel alloc]init];
        self.playCountLabel.font = FONT(15);
        self.playCountLabel.text = @"4344343播放";
        self.playCountLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.playCountLabel];
        
        self.videoTimeLabel = [[UILabel alloc]init];
        self.videoTimeLabel.font = FONT(15);
        self.videoTimeLabel.text = @"03:20";
        self.videoTimeLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.videoTimeLabel];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:IMAGENAME(@"video-play") forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(playBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.markImage.frame = CGRectMake(0, 20, self.width, 30);
    
    self.imageView.frame = self.bounds;
    
    self.playCountLabel.right = self.imageView.right;
    self.playCountLabel.y = 0;
    [self.playCountLabel sizeToFit];
    
    self.videoTimeLabel.right = self.imageView.right;
    self.videoTimeLabel.bottom = self.imageView.bottom;
    [self.videoTimeLabel sizeToFit];
    
    self.playBtn.size = CGSizeMake(71, 71);
    self.playBtn.center = self.imageView.center;
}

-(void)setTopic:(DCTopic *)topic {
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    // %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
-(void)playBtnDidClick {
    DCLogFunc
    DCPlayViewController *playVC = [[DCPlayViewController alloc]init];
    playVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:NO completion:nil];
}
@end
