//
//  DCTopicCell.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/4/13.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicCell.h"
#import "DCTopic.h"
#import "DCComment.h"
#import "DCUser.h"
#import "DCTopicPictureView.h"
#import "DCTopicVideoView.h"
#import "DCTopicVoiceView.h"
@interface DCTopicCell ()
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *createdAtLabel;
@property (strong, nonatomic) UILabel *text_label;
@property (strong, nonatomic) UIButton *moreBtn;
/* 中间控件 */
/** 图片控件 */
@property (nonatomic,weak) DCTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic,weak) DCTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic,weak) DCTopicVideoView *videoView;

/** 最热评论-整体 */
@property (strong, nonatomic) UIView *topCmtView;
@property (nonatomic,strong) UILabel *topTitleLabel;
@property (strong, nonatomic) UILabel *topCmtContentLabel;
/**  底部条 */
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *bottomLineView;
@property (strong, nonatomic) UIButton *dingButton;
@property (strong, nonatomic) UIButton *caiButton;
@property (strong, nonatomic) UIButton *repostButton;
@property (strong, nonatomic) UIButton *commentButton;
@end
@implementation DCTopicCell
-(DCTopicPictureView *)pictureView {
    if (!_pictureView) {
        DCTopicPictureView *pictureView = [[DCTopicPictureView alloc]init];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (DCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        DCTopicVoiceView *voiceView = [[DCTopicVoiceView alloc]init];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (DCTopicVideoView *)videoView
{
    if (!_videoView) {
        DCTopicVideoView *videoView = [[DCTopicVideoView alloc]init];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
+(instancetype)cellWithTableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellID = @"Cell";
    DCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[DCTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpBaseUI];
    }
    return self;
}
-(void)setUpBaseUI {
    self.backgroundView = [[UIImageView alloc]initWithImage:IMAGENAME(@"mainCellBackground")];
    self.backgroundView.userInteractionEnabled = YES;
    
    self.profileImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.profileImageView];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = FONT(15);
    self.nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.nameLabel];
    
    self.createdAtLabel = [[UILabel alloc]init];
    self.createdAtLabel.font = FONT(15);
    self.createdAtLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.createdAtLabel];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setImage:IMAGENAME(@"cellmorebtnnormal") forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(moreBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    
    /**  最热评论 */
    self.topCmtView = [[UIView alloc]init];
//    self.topCmtView.backgroundColor = DCRandomColor;
    [self.contentView addSubview:self.topCmtView];
    
    self.topTitleLabel = [[UILabel alloc]init];
    self.topTitleLabel.font = FONT(16);
    self.topTitleLabel.text = @"最热评论";
    [self.topCmtView addSubview:self.topTitleLabel];
    
    self.topCmtContentLabel = [[UILabel alloc]init];
    self.topCmtContentLabel.font = FONT(14);
    self.topCmtContentLabel.numberOfLines = 0;
    [self.topCmtView addSubview:self.topCmtContentLabel];
    
    /**  底部评论，分享，踩，顶*/
    self.bottomView = [[UIView alloc]init];
    [self.contentView addSubview:self.bottomView];
    self.bottomLineView = [[UIView alloc]init];
    self.bottomLineView.backgroundColor = [UIColor lightGrayColor];
    self.bottomLineView.alpha = 0.4;
    [self.bottomView addSubview:self.bottomLineView];

    self.dingButton = [self createBtnWithImage:@"mainCellDing" title:@"顶" target:self action:@selector(bottomBtnDidClick:)];
    self.dingButton.tag = 11;
    [self.bottomView addSubview:self.dingButton];
    
    self.caiButton = [self createBtnWithImage:@"mainCellCai" title:@"踩" target:self action:@selector(bottomBtnDidClick:)];
    self.caiButton.tag = 12;
    [self.bottomView addSubview:self.caiButton];
    
    self.repostButton = [self createBtnWithImage:@"mainCellShare" title:@"分享" target:self action:@selector(bottomBtnDidClick:)];
    self.repostButton.tag = 13;
    [self.bottomView addSubview:self.repostButton];
    
    self.commentButton = [self createBtnWithImage:@"mainCellComment" title:@"评论" target:self action:@selector(bottomBtnDidClick:)];
    self.commentButton.tag = 14;
    [self.bottomView addSubview:self.commentButton];
    
    self.text_label = [[UILabel alloc]init];
    self.text_label.font = FONT(15);
    self.text_label.numberOfLines = 0;
    [self.contentView addSubview:self.text_label];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.profileImageView.frame = CGRectMake(DCMargin, DCMargin, 35, 35);
    
    self.nameLabel.x = self.profileImageView.right+DCMargin;
    self.nameLabel.y = self.profileImageView.y;
    [self.nameLabel sizeToFit];
    
    self.createdAtLabel.x = self.nameLabel.x;
    self.createdAtLabel.y = self.nameLabel.bottom;
    [self.createdAtLabel sizeToFit];
    
    self.moreBtn.frame = CGRectMake(ScreenWidth-DCMargin-30, DCMargin, 30, 30);
    
    self.text_label.frame = self.topic.contentTextF;
    
    self.topCmtView.frame = self.topic.top_cmt_F;
    
    self.topTitleLabel.frame = CGRectMake(DCMargin, 0, self.topCmtView.width-DCMargin*2, 20);
    self.topCmtContentLabel.frame = CGRectMake(DCMargin, self.topTitleLabel.bottom, self.topCmtView.width, self.topCmtView.height - self.topTitleLabel.height);
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(DCMargin);
        make.right.equalTo(self.contentView).mas_offset(-DCMargin);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(@(50));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(@(CGSizeMake(ScreenWidth-DCMargin*4, 1)));
        make.left.mas_equalTo(@(DCMargin));
        make.top.mas_equalTo(@(1));
    }];
    [self.dingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-DCMargin*2)/4, 30));
        make.top.equalTo(self.bottomView).mas_offset(DCMargin);
        make.left.equalTo(self.bottomView);
    }];
    [self.caiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dingButton);
        make.top.equalTo(self.dingButton);
        make.left.equalTo(self.dingButton.mas_right);
    }];
    [self.repostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dingButton);
        make.top.equalTo(self.dingButton);
        make.left.equalTo(self.caiButton.mas_right);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dingButton);
        make.top.equalTo(self.dingButton);
        make.left.equalTo(self.repostButton.mas_right);
    }];
    
    // 中间内容
    if (self.topic.type == DCTopicTypeVideo) { // 视频
        self.videoView.frame = self.topic.contentF;
    } else if (self.topic.type == DCTopicTypeVoice) { // 音频
        
        self.voiceView.frame = self.topic.contentF;
        
    } else if (self.topic.type == DCTopicTypeWord) { // 段子
        
    } else if (self.topic.type == DCTopicTypePicture) { // 图片
        
        self.pictureView.frame = self.topic.contentF;
        
    }
}
-(void)setTopic:(DCTopic *)topic {
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:IMAGENAME(@"defaultUserIcon")];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 中间内容
    if (topic.type == DCTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == DCTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == DCTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == DCTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    // 最热评论
    if (topic.top_cmt) {// 有最热评论
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content]; // 用户名  评论内容
    }else {// 没有最热评论
        self.topCmtView.hidden = YES;
    }
}
/*
 *  底部按钮点击   顶 踩 分享 评论
 */
-(void)bottomBtnDidClick:(UIButton *)button {
    DCLogFunc
}
-(void)moreBtnDidClick {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
-(void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder {
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/*
 *  创建底部按钮
 */
-(UIButton *)createBtnWithImage:(NSString *)imageName title:(NSString *)title target:(nullable id)target action:(nonnull SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:IMAGENAME(imageName) forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = FONT(15);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/*
 *  设置cell间距
 */
-(void)setFrame:(CGRect)frame {
    frame.size.height -= DCMargin;
    frame.origin.y += DCMargin;
    [super setFrame:frame];
}
@end
