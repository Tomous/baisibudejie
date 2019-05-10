//
//  DCPlayViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/8.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCPlayViewController.h"
#import "DCTopic.h"
#import "SRVideoPlayer.h"
@interface DCPlayViewController ()<closeBtnDelegate>
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic, strong) SRVideoPlayer *videoPlayer;
@end
@implementation DCPlayViewController
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_videoPlayer destroyPlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self setUpUI];
}
-(void)setUpUI {
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(DCMargin, DCMargin, 35, 35);
    [self.backBtn setImage:IMAGENAME(@"show_image_back_icon") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    /*
     *  播放地址
     */
    NSURL *url = [NSURL URLWithString:self.topic.videouri];
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    playerView.center = self.view.center;
    [self.view addSubview:playerView];
    _videoPlayer = [SRVideoPlayer playerWithVideoURL:url playerView:playerView playerSuperView:playerView.superview];
    _videoPlayer.videoName = @"Here Is The Video Name";
    _videoPlayer.playerEndAction = SRVideoPlayerEndActionStop;
    _videoPlayer.delegate = self;
    [_videoPlayer play];
}
-(void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma closeBtnDelegate
-(void)selectedWithCloseBtn {
    [self back];
}
@end
