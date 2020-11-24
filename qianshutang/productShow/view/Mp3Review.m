//
//  Mp3Review.m
//  qianshutang
//
//  Created by aaa on 2018/10/25.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "Mp3Review.h"
@interface Mp3Review()
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UIButton * recordBtn;
@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * complateBtn;

@property (nonatomic, assign)BOOL isRecorded;

@end
@implementation Mp3Review

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.hd_width / 4, 5, self.hd_width / 2, self.hd_width / 5 - 10)];
    self.imageView.animationImages = @[[UIImage imageNamed:@"ls_bottom_record_one_rectangle"],[UIImage imageNamed:@"ls_bottom_record_two_rectangle"],[UIImage imageNamed:@"ls_bottom_record_three_rectangle"],[UIImage imageNamed:@"ls_bottom_record_four_rectangle"],[UIImage imageNamed:@"ls_bottom_record_five_rectangle"],[UIImage imageNamed:@"ls_bottom_record_six_rectangle"]];
    [self addSubview:self.imageView];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake(self.hd_width / 3, self.hd_height / 2 - self.hd_height / 6, self.hd_width / 3, self.hd_height / 3);
    [self addSubview:self.recordBtn];
    [self.recordBtn setImage:[UIImage imageNamed:@"play_record_btn_play"] forState:UIControlStateNormal];
    [self.recordBtn setImage:[UIImage imageNamed:@"play_record_btn_action"] forState:UIControlStateSelected];
    [self.recordBtn addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(5, self.hd_height * 0.8 - 5, self.hd_width / 2 - 6, self.hd_height / 5);
    self.cancelBtn.backgroundColor = kMainColor;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.cancelBtn];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.hd_width / 2 + 1, self.hd_height * 0.8 - 5, self.hd_width / 2 - 6, self.hd_height / 5);
    self.complateBtn.backgroundColor = kMainColor;
    [self.complateBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.complateBtn];
    
    self.cancelBtn.hidden = YES;
    self.complateBtn.hidden = YES;
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
        self.recordBtn.selected = NO;
        [self.imageView stopAnimating];
    }];
    
}

- (void)recordAction
{
    self.recordBtn.selected = !self.recordBtn.selected;
    
    if (self.recordBtn.selected) {
        if (self.isRecorded) {
            [[BTVoicePlayer share] play:[RecordTool sharedInstance].savePath];
            [self.imageView startAnimating];
            return;
        }
        
        [[RecordTool sharedInstance] startRecordVoice];
        [self.imageView startAnimating];
    }else
    {
        if (self.isRecorded) {
            [[BTVoicePlayer share] localstop];
            [self.imageView stopAnimating];
            return;
        }
        self.isRecorded = YES;
        self.cancelBtn.hidden = NO;
        self.complateBtn.hidden = NO;
        [[RecordTool sharedInstance] stopRecordVoice];
        [self.imageView stopAnimating];
    }
}

- (void)cancelAction
{
    if (self.voiceCommentCancelBlock) {
        self.voiceCommentCancelBlock(@{});
    }
    [self removeFromSuperview];
}

- (void)complateAction
{
    NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
    if (self.isRecorded) {
        [mInfo setObject:@1 forKey:@"record"];
    }else
    {
        [mInfo setObject:@0 forKey:@"record"];
    }
    if (self.voiceCommentComplateBlock) {
        self.voiceCommentComplateBlock(mInfo);
    }
    [self removeFromSuperview];
}

@end
