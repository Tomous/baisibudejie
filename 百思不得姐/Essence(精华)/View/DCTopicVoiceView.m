//
//  DCTopicVoiceView.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/7.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicVoiceView.h"
#import "DCTopic.h"
@interface DCTopicVoiceView ()
@property (nonatomic,strong) UIImageView *markImage;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *playCountLabel;
@property (strong, nonatomic) UILabel *voiceTimeLabel;
@property (nonatomic,strong) UIButton *playBtn;
@end
@implementation DCTopicVoiceView
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
        
        self.voiceTimeLabel = [[UILabel alloc]init];
        self.voiceTimeLabel.font = FONT(15);
        self.voiceTimeLabel.text = @"03:20";
        self.voiceTimeLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.voiceTimeLabel];
        
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:IMAGENAME(@"playButtonPlay") forState:UIControlStateNormal];
        [self.playBtn setBackgroundImage:IMAGENAME(@"playButton") forState:UIControlStateNormal];
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
    
    self.voiceTimeLabel.right = self.imageView.right;
    self.voiceTimeLabel.bottom = self.imageView.bottom;
    [self.voiceTimeLabel sizeToFit];
    
    self.playBtn.size = CGSizeMake(71, 71);
    self.playBtn.center = self.imageView.center;
}

-(void)setTopic:(DCTopic *)topic {
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
-(void)playBtnDidClick {
    DCLogFunc
}
@end
