//
//  HomeworkDetailView.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "HomeworkDetailView.h"
#import "ShowCreateTaskMetarialView.h"
#import "PlayVideoViewController.h"

@interface HomeworkDetailView()<UICollectionViewDelegate, UICollectionViewDataSource, ChangeMusicProtocol>

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UITextField * taskNameTf;

@property (nonatomic, strong)MKPPlaceholderTextView * taskDetailTv;
@property (nonatomic, strong)UIImageView * taskVoiceDetailBtn;
@property (nonatomic, strong)UILabel * recordTimeLB;

@property (nonatomic, strong)UIImageView * singleImageBtn;


@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)NSDictionary * infoDic;
@property (nonatomic, strong)ShowCreateTaskMetarialView * showCreateTaskMetarialView;
@property (nonatomic, strong)ShowCreateTaskMetarialView * showIntrolImageView;

@end

@implementation HomeworkDetailView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame withInfo:(NSDictionary *)infoDic
{
    if (self = [super initWithFrame:frame]) {
        self.infoDic = infoDic;
        [self prepareUI:infoDic];
    }
    return self;
}

- (void)prepareUI:(NSDictionary *)infoDic
{
    self.backView = [[UIView alloc]initWithFrame:self.bounds];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self addSubview:self.backView];
    
    UILabel * taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.027, kScreenWidth * 0.185, kScreenHeight * 0.059)];
    taskNameLB.text = @"作业标题";
    taskNameLB.font = [UIFont boldSystemFontOfSize:17];
    taskNameLB.textAlignment = NSTextAlignmentRight;
    taskNameLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskNameLB];
    
    self.taskNameTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(taskNameLB.frame) + kScreenWidth * 0.023, taskNameLB.hd_y, kScreenWidth * 0.756, kScreenHeight * 0.059)];
    self.taskNameTf.backgroundColor = [UIColor whiteColor];
    self.taskNameTf.textColor = UIColorFromRGB(0x555555);
    self.taskNameTf.returnKeyType = UIReturnKeyDone;
    [self.backView addSubview:self.taskNameTf];
    self.taskNameTf.text = [infoDic objectForKey:@"title"];
    self.taskNameTf.enabled = NO;
    
    UILabel * taskDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.031 + CGRectGetMaxY(taskNameLB.frame), kScreenWidth * 0.185, kScreenHeight * 0.059)];
    taskDetailLB.text = @"作业文字描述";
    taskDetailLB.font = [UIFont boldSystemFontOfSize:17];
    taskDetailLB.textAlignment = NSTextAlignmentRight;
    taskDetailLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskDetailLB];
    
    self.taskDetailTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, taskDetailLB.hd_y, self.taskNameTf.hd_width, kScreenHeight * 0.177)];
    self.taskDetailTv.backgroundColor = [UIColor whiteColor];
    self.taskDetailTv.textColor = UIColorFromRGB(0x555555);
    self.taskDetailTv.text = [infoDic objectForKey:@"detail"];
    
    [self.backView addSubview:self.taskDetailTv];
    
    UILabel * taskVoiceDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.168 + CGRectGetMaxY(taskDetailLB.frame), kScreenWidth * 0.185, kScreenHeight * 0.039)];
    taskVoiceDetailLB.text = @"作业语音描述";
    taskVoiceDetailLB.font = [UIFont boldSystemFontOfSize:17];
    taskVoiceDetailLB.textAlignment = NSTextAlignmentRight;
    taskVoiceDetailLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskVoiceDetailLB];
    
    
    UILabel * taskVoiceDetailBackLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.taskDetailTv.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.096)];
    taskVoiceDetailBackLB.text = @"无";
    taskVoiceDetailBackLB.textColor = UIColorFromRGB(0x222222);
    taskVoiceDetailBackLB.layer.cornerRadius = 5;
    taskVoiceDetailBackLB.layer.masksToBounds = YES;
    [self.backView addSubview:taskVoiceDetailBackLB];
    
    self.taskVoiceDetailBtn = [[UIImageView alloc]init];
    self.taskVoiceDetailBtn.frame = CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.taskDetailTv.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.096);
    self.taskVoiceDetailBtn.backgroundColor = [UIColor clearColor];
    self.taskVoiceDetailBtn.layer.cornerRadius = 5;
    self.taskVoiceDetailBtn.layer.masksToBounds = YES;
    self.taskVoiceDetailBtn.userInteractionEnabled = YES;
    [self.backView addSubview:self.taskVoiceDetailBtn];
    
    UITapGestureRecognizer * voiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(voiceAction)];
    if ([infoDic objectForKey:@"audioIntroURL"] && [[infoDic objectForKey:@"audioIntroURL"] length] > 0) {
        self.taskVoiceDetailBtn.hidden = NO;
        taskVoiceDetailBackLB.hidden = YES;
        self.taskVoiceDetailBtn.image = [UIImage imageNamed:@"voice_shape_three"];
        [self.taskVoiceDetailBtn addGestureRecognizer:voiceTap];
    }else
    {
        self.taskVoiceDetailBtn.hidden = YES;
        taskVoiceDetailBackLB.hidden = NO;
    }
    
    
    self.recordTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskVoiceDetailBtn.frame) - 50, self.taskVoiceDetailBtn.hd_y, 50, self.taskVoiceDetailBtn.hd_height)];
    self.recordTimeLB.textColor = [UIColor whiteColor];
    self.recordTimeLB.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.recordTimeLB];
    
    
    UILabel * singleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.109 + CGRectGetMaxY(taskVoiceDetailLB.frame), kScreenWidth * 0.185, kScreenHeight * 0.135)];
    NSString * str = @"图片/视频描述\n(仅单个图片/视频) 长按可删除";
    singleLB.font = [UIFont boldSystemFontOfSize:17];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:@"图片/视频描述\n(仅单个图片/视频)\n长按可删除"];
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [mStr addAttributes:attribute range:NSMakeRange(8, str.length - 8)];
    singleLB.attributedText = mStr;
    singleLB.numberOfLines = 0;
    singleLB.textAlignment = NSTextAlignmentRight;
    singleLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:singleLB];
    
    self.singleImageBtn = [[UIImageView alloc]init];
    self.singleImageBtn.frame = CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.taskVoiceDetailBtn.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.189);
    self.singleImageBtn.contentMode = UIViewContentModeScaleAspectFit;
    self.singleImageBtn.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.singleImageBtn.userInteractionEnabled = YES;
    self.singleImageBtn.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.singleImageBtn.layer.borderWidth = 3;
    [self.backView addSubview:self.singleImageBtn];
    UITapGestureRecognizer * singleImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleImageTapAction)];
    [self.singleImageBtn addGestureRecognizer:singleImageTap];
    
    UIButton * playVideoIntroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playVideoIntroBtn.frame = CGRectMake(self.singleImageBtn.hd_width / 4, (self.singleImageBtn.hd_height - self.singleImageBtn.hd_width / 2) / 2, self.singleImageBtn.hd_width / 2, self.singleImageBtn.hd_width / 2);
    [playVideoIntroBtn setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    [self.singleImageBtn addSubview:playVideoIntroBtn];
    [playVideoIntroBtn addTarget:self action:@selector(singleImageTapAction) forControlEvents:UIControlEventTouchUpInside];
    playVideoIntroBtn.hidden = YES;
    
    UILabel * singleImageBackLB = [[UILabel alloc]initWithFrame:CGRectMake(self.singleImageBtn.hd_x, self.singleImageBtn.hd_centerY - kScreenHeight * 0.048, kScreenWidth * 0.15, kScreenHeight * 0.096)];
    singleImageBackLB.text = @"无";
    singleImageBackLB.textColor = UIColorFromRGB(0x222222);
    singleImageBackLB.layer.cornerRadius = 5;
    singleImageBackLB.layer.masksToBounds = YES;
    [self.backView addSubview:singleImageBackLB];
    
    if ([infoDic objectForKey:@"imageIntroURL"] && [[infoDic objectForKey:@"imageIntroURL"] length] > 0) {
        
        NSString * urlStr = [self.infoDic objectForKey:@"imageIntroURL"];
        if ([urlStr containsString:@".mp4"]) {
            playVideoIntroBtn.hidden = NO;
            self.singleImageBtn.image = [UIUtility thumbnailImageForVideo:[NSURL URLWithString:[infoDic objectForKey:@"imageIntroURL"]] atTime:0];
        }else
        {
            [self.singleImageBtn sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageIntroURL"]] placeholderImage:[UIImage imageNamed:@"icon_material_add"]];
        }
        
        singleImageBackLB.hidden = YES;
        self.singleImageBtn.hidden = NO;
    }else
    {
        self.singleImageBtn.hidden = YES;
        singleImageBackLB.hidden = NO;
    }
    
    self.dataArray = [infoDic objectForKey:@"materialList"];
    
    UILabel * materialLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.092 + CGRectGetMaxY(singleLB.frame), kScreenWidth * 0.185 - kScreenHeight * 0.039, kScreenHeight * 0.039)];
    materialLB.textColor = UIColorFromRGB(0x222222);
    materialLB.font = [UIFont boldSystemFontOfSize:17];
    materialLB.text = @"作业素材";
    materialLB.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:materialLB];
    
    UIImageView * materialImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(materialLB.frame), materialLB.hd_y, kScreenHeight * 0.039, kScreenHeight * 0.039)];
    materialImageView.image = [UIImage imageNamed:@"icon_material_help"];
    [self.backView addSubview:materialImageView];
    
    
    UILabel * materialImageBackLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.singleImageBtn.frame) + kScreenHeight * 0.029, kScreenWidth * 0.8, kScreenHeight * 0.189)];
    materialImageBackLB.text = @"无";
    materialImageBackLB.textColor = UIColorFromRGB(0x222222);
    materialImageBackLB.layer.cornerRadius = 5;
    materialImageBackLB.layer.masksToBounds = YES;
    [self.backView addSubview:materialImageBackLB];
    
    UILabel * materialLB2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(materialLB.frame) + 5, kScreenWidth * 0.185, 15)];
    materialLB2.text = @"(支持多个图片)";
    materialLB2.textAlignment = NSTextAlignmentRight;
    materialLB2.textColor = UIColorFromRGB(0x222222);
    materialLB2.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:materialLB2];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth * 0.15, kScreenHeight * 0.189);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.singleImageBtn.frame) + kScreenHeight * 0.029, kScreenWidth * 0.8, kScreenHeight * 0.189) collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.backView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    if (self.dataArray.count > 0) {
        self.collectionView.hidden = NO;
        materialImageBackLB.hidden = YES;
    }else
    {
        self.collectionView.hidden = YES;
        materialImageBackLB.hidden = NO;
    }
    
//    UILongPressGestureRecognizer * collectionViewLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCollectionCellAction:)];
//    collectionViewLongPress.minimumPressDuration = 1.5;
//    [self.collectionView addGestureRecognizer:collectionViewLongPress];
    
    [BTVoicePlayer share].delegate = self;
    
    self.showCreateTaskMetarialView = [[ShowCreateTaskMetarialView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andDataArray:self.dataArray];
    self.showIntrolImageView = [[ShowCreateTaskMetarialView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andDataArray:@[@{@"imageUrl":[self.infoDic objectForKey:@"imageIntroURL"]}]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, cell.hd_width - 10, cell.hd_height)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = image;
    }];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.window addSubview:self.showCreateTaskMetarialView];
    [self.showCreateTaskMetarialView resetCurrentIndex:indexPath.row];
}

- (void)singleImageTapAction
{
    NSString * urlStr = [self.infoDic objectForKey:@"imageIntroURL"];
    if ([urlStr containsString:@".mp4"]) {
        
        if (self.playVideoIntroBlock) {
            self.playVideoIntroBlock(self.infoDic);
        }
        
        return;
    }
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.window addSubview:self.showIntrolImageView];
    [self.showIntrolImageView resetCurrentIndex:0];
}

#pragma mark - 播放语音描述
- (void)voiceAction
{
    // 判断是否正在播放
    if ([BTVoicePlayer share].isPlaying) {
        [[BTVoicePlayer share] stop];
        [self.taskVoiceDetailBtn stopAnimating];
        self.taskVoiceDetailBtn.animationImages = nil;
    }else
    {
        self.taskVoiceDetailBtn.animationImages = @[[UIImage imageNamed:@"voice_shape_one"],[UIImage imageNamed:@"voice_shape_two"],[UIImage imageNamed:@"voice_shape_three"]];
        self.taskVoiceDetailBtn.animationDuration = 1.0;
        if ([self.infoDic objectForKey:@"audioIntroURL"]) {
            [[BTVoicePlayer share] playLine:[self.infoDic objectForKey:@"audioIntroURL"]];
        }else
        {
            [[BTVoicePlayer share] play:[RecordTool sharedInstance].savePath];
        }
        [self.taskVoiceDetailBtn startAnimating];
    }
    
}

- (void)changeMusic
{
    [self.taskVoiceDetailBtn stopAnimating];
}

@end
