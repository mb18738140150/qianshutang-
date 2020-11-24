//
//  CreateTaskViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "ProductPatternSelectView.h"
#import "CreateProductionViewController.h"
#import "GrafitiViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CreateTaskViewController ()<UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIVideoEditorControllerDelegate,Teacher_createMetarial,Task_CreateTaskProblemContent,ChangeMusicProtocol>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)NSDictionary * createTaskInfoDic;

@property (nonatomic, strong)UITextField * taskNameTf;
@property (nonatomic, strong)UILabel * taskNameCountLB;
@property (nonatomic, strong)MKPPlaceholderTextView * taskDetailTv;
@property (nonatomic, strong)UIImageView * taskVoiceDetailBtn;
@property (nonatomic, strong)UILabel * recordTimeLB;
@property (nonatomic, strong)UIButton * reRecordBtn;
@property (nonatomic, assign)BOOL cancelLongPressRecord;// 是否取消长按录音
@property (nonatomic, strong)UIImageView * recordAnimationImageView;
@property (nonatomic, assign)BOOL isPlayLineRecord;

@property (nonatomic, strong)UIImageView * singleImageBtn;
@property (nonatomic, strong)UIImageView * singleImageDeleteBtn;
@property (nonatomic, assign)BOOL isDeleteSingleImage;// 是否删除图片、视频描述


@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, assign)BOOL collectionViewDeleteType;// 是否删除作业素材

@property (nonatomic, assign)BOOL isSingleModel;// 是否图片、视频模型
@property (nonatomic, strong)ProductionModel * singleModel;
@property (nonatomic, strong)ProductionModel * materialModel;

@property (nonatomic, assign)CreatProductionType createProductionType;

// 视频录制所需参数
@property (nonatomic, strong)NSString * folderName;//创建系统相册名称
@property (nonatomic, strong)NSString * localIdentifier;//录制视频标识符


@property (nonatomic, strong)NSString * coverIconUrl;
@property (nonatomic, strong)NSString * recordIntroUrl;
@property (nonatomic, strong)NSString * mp4Url;
@property (nonatomic, strong)NSString * mp4IconUrl;
@property (nonatomic, strong)NSMutableArray * metarialImageUrlArray;

@end

@implementation CreateTaskViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    if (self.singleModel == nil) {
        self.singleModel = [[ProductionModel alloc]init];
    }
    if (self.materialModel == nil) {
        self.materialModel = [[ProductionModel alloc]init];
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.mp4Url = @"";
    self.mp4IconUrl = @"";
    self.recordIntroUrl = @"";
    self.coverIconUrl = @"";
    self.metarialImageUrlArray = [NSMutableArray array];
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_save];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.saveBlock = ^{
        [weakSelf savaProductAction];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"自主学习";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    [self.view addSubview:self.backView];
    
    UIControl * control = [[UIControl alloc]initWithFrame:self.backView.bounds];
    [control addTarget:self action:@selector(controlAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:control];
    
    UILabel * taskNameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.027, kScreenWidth * 0.185, kScreenHeight * 0.059)];
    taskNameLB.text = @"作业标题";
    taskNameLB.font = [UIFont boldSystemFontOfSize:17];
    taskNameLB.textAlignment = NSTextAlignmentRight;
    taskNameLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskNameLB];
    
    self.taskNameTf = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(taskNameLB.frame) + kScreenWidth * 0.023, taskNameLB.hd_y, kScreenWidth * 0.756, kScreenHeight * 0.059)];
    self.taskNameTf.backgroundColor = [UIColor whiteColor];
    self.taskNameTf.delegate = self;
    self.taskNameTf.textColor = UIColorFromRGB(0x555555);
    self.taskNameTf.returnKeyType = UIReturnKeyDone;
    [self.backView addSubview:self.taskNameTf];
    
    self.taskNameCountLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskNameTf.frame) - 60, self.taskNameTf.hd_y, 60, self.taskNameTf.hd_height)];
    self.taskNameCountLB.text = @"0/20";
    self.taskNameCountLB.textColor = UIColorFromRGB(0x555555);
    self.taskNameCountLB.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:self.taskNameCountLB];
    
    
    UILabel * taskDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.031 + CGRectGetMaxY(taskNameLB.frame), kScreenWidth * 0.185, kScreenHeight * 0.059)];
    taskDetailLB.text = @"作业文字描述";
    taskDetailLB.font = [UIFont boldSystemFontOfSize:17];
    taskDetailLB.textAlignment = NSTextAlignmentRight;
    taskDetailLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskDetailLB];
    
    self.taskDetailTv = [[MKPPlaceholderTextView alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, taskDetailLB.hd_y, self.taskNameTf.hd_width, kScreenHeight * 0.177)];
    self.taskDetailTv.backgroundColor = [UIColor whiteColor];
    self.taskDetailTv.textColor = UIColorFromRGB(0x555555);
    if (self.isCreateTask) {
        self.taskNameTf.text = @"创作作业";
        self.taskDetailTv.text = @"创作作业";
    }else
    {
        self.taskDetailTv.text = @"视频作业";
        self.taskNameTf.text = @"视频作业";
    }
    [self.backView addSubview:self.taskDetailTv];
    
    UILabel * taskVoiceDetailLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.168 + CGRectGetMaxY(taskDetailLB.frame), kScreenWidth * 0.185, kScreenHeight * 0.039)];
    taskVoiceDetailLB.text = @"作业语音描述";
    taskVoiceDetailLB.font = [UIFont boldSystemFontOfSize:17];
    taskVoiceDetailLB.textAlignment = NSTextAlignmentRight;
    taskVoiceDetailLB.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:taskVoiceDetailLB];
 
    
    UILabel * taskVoiceDetailBackLB = [[UILabel alloc]initWithFrame:CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.taskDetailTv.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.096)];
    taskVoiceDetailBackLB.text = @"长按录音";
    taskVoiceDetailBackLB.textAlignment = NSTextAlignmentCenter;
    taskVoiceDetailBackLB.textColor = kMainColor;
    taskVoiceDetailBackLB.backgroundColor = UIColorFromRGB(0xD5FFEF);
    taskVoiceDetailBackLB.layer.cornerRadius = 5;
    taskVoiceDetailBackLB.layer.masksToBounds = YES;
    [self.backView addSubview:taskVoiceDetailBackLB];
    
    self.recordAnimationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight / 3 / 107 * 72, kScreenHeight / 3)];
    self.recordAnimationImageView.image = [UIImage imageNamed:@"record_animate_01"];
    self.recordAnimationImageView.hd_centerX = kScreenWidth / 2;
    self.recordAnimationImageView.hd_centerY = kScreenHeight / 2;
    [self.backView addSubview:self.recordAnimationImageView];
    self.recordAnimationImageView.hidden = YES;
    
    
    self.taskVoiceDetailBtn = [[UIImageView alloc]init];
    self.taskVoiceDetailBtn.frame = CGRectMake(self.taskNameTf.hd_x, CGRectGetMaxY(self.taskDetailTv.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.096);
    self.taskVoiceDetailBtn.backgroundColor = [UIColor clearColor];
    self.taskVoiceDetailBtn.layer.cornerRadius = 5;
    self.taskVoiceDetailBtn.layer.masksToBounds = YES;
    self.taskVoiceDetailBtn.userInteractionEnabled = YES;
    [self.backView addSubview:self.taskVoiceDetailBtn];
    
    UITapGestureRecognizer * voiceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(voiceAction)];
    [self.taskVoiceDetailBtn addGestureRecognizer:voiceTap];
    UILongPressGestureRecognizer * voiceLongTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(voiceLongtapAction:)];
    [self.taskVoiceDetailBtn addGestureRecognizer:voiceLongTap];
    
    self.recordTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.taskVoiceDetailBtn.frame) - 50, self.taskVoiceDetailBtn.hd_y, 50, self.taskVoiceDetailBtn.hd_height)];
    self.recordTimeLB.textColor = [UIColor whiteColor];
    self.recordTimeLB.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.recordTimeLB];
    
    self.reRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reRecordBtn.frame = CGRectMake(CGRectGetMaxX(self.taskVoiceDetailBtn.frame) + kScreenWidth * 0.023, CGRectGetMaxY(self.taskDetailTv.frame) + kScreenHeight * 0.029, kScreenWidth * 0.15, kScreenHeight * 0.096);
    [self.reRecordBtn setTitle:@"重录" forState:UIControlStateNormal];
    [self.reRecordBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.reRecordBtn.backgroundColor =  UIColorFromRGB(0xD5FFEF);
    self.recordTimeLB.layer.cornerRadius = 5;
    self.recordTimeLB.layer.masksToBounds = YES;
    [self.backView addSubview:self.reRecordBtn];
    self.reRecordBtn.hidden = YES;
    [self.reRecordBtn addTarget:self action:@selector(reRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.singleImageBtn.image = [UIImage imageNamed:@"icon_material_add"];
    self.singleImageBtn.contentMode = UIViewContentModeScaleAspectFit;
    self.singleImageBtn.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.singleImageBtn.userInteractionEnabled = YES;
    self.singleImageBtn.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    self.singleImageBtn.layer.borderWidth = 3;
    [self.backView addSubview:self.singleImageBtn];
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleImageAction)];
    [self.singleImageBtn addGestureRecognizer:singleTap];
    UILongPressGestureRecognizer * singleLongTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(singleLongtapAction:)];
    [self.singleImageBtn addGestureRecognizer:singleLongTap];
    
    self.singleImageDeleteBtn = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.singleImageBtn.frame) - self.singleImageBtn.hd_width / 6, self.singleImageBtn.hd_y, self.singleImageBtn.hd_width / 6, self.singleImageBtn.hd_width / 6)];
    self.singleImageDeleteBtn.image = [UIImage imageNamed:@"icon_material_delete"];
    [self.backView addSubview:self.singleImageDeleteBtn];
    self.singleImageDeleteBtn.hidden = YES;
    
    
    UILabel * materialLB = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.092 + CGRectGetMaxY(singleLB.frame), kScreenWidth * 0.185 - kScreenHeight * 0.039, kScreenHeight * 0.039)];
    materialLB.textColor = UIColorFromRGB(0x222222);
    materialLB.font = [UIFont boldSystemFontOfSize:17];
    materialLB.text = @"作业素材";
    materialLB.textAlignment = NSTextAlignmentRight;
    [self.backView addSubview:materialLB];
    
    UIImageView * materialImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(materialLB.frame), materialLB.hd_y, kScreenHeight * 0.039, kScreenHeight * 0.039)];
    materialImageView.image = [UIImage imageNamed:@"icon_material_help"];
    [self.backView addSubview:materialImageView];
    
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
    
    if (self.madeId > 0) {
        [self loadData];
    }
}

- (void)loadData
{
    [[UserManager sharedManager] didRequestCreateTaskProblemContentWithWithDic:@{kmadeId:@(self.madeId)} withNotifiedObject:self];
}

- (void)refreshView
{
    NSLog(@"%@", [[UserManager sharedManager] getTaskProbemContentInfo]);
    self.createTaskInfoDic = [[UserManager sharedManager] getTaskProbemContentInfo];
    self.taskNameTf.text = [self.createTaskInfoDic objectForKey:@"title"];
    self.taskDetailTv.text = [self.createTaskInfoDic objectForKey:@"detail"];
    if ([[self.createTaskInfoDic objectForKey:@"audioIntroURL"] length] > 0) {
        self.isPlayLineRecord = YES;
        self.reRecordBtn.hidden = NO;
        self.taskVoiceDetailBtn.image = [UIImage imageNamed:@"voice_shape_three"];
    }
    [self.singleImageBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.createTaskInfoDic objectForKey:@"imageIntroURL"]]] placeholderImage:[UIImage imageNamed:@"icon_material_add"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.singleImageBtn.image = image;
    }];
    
    for (int i = 0; i < [[self.createTaskInfoDic objectForKey:@"materialList"] count]; i++) {
        NSDictionary * materialImageImfo = [[self.createTaskInfoDic objectForKey:@"materialList"] objectAtIndex:i];
        UIImageView * imageView = [[UIImageView alloc]init];
        NSString * urlStr = [[[materialImageImfo objectForKey:@"imageUrl"] componentsSeparatedByString:@";"] firstObject];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            ImageProductModel * model = [[ImageProductModel alloc]init];
            model.originImage = image;
            model.fanleImage = image;
            [self resreshImageModel:model];
        }];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 20) {
        textField.text = [textField.text substringToIndex:20];
    }
    self.taskNameCountLB.text = [NSString stringWithFormat:@"%d/20", textField.text.length];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.materialModel.imageProductArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    UILongPressGestureRecognizer * collectionViewLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCollectionCellAction:)];
    collectionViewLongPress.minimumPressDuration = 1.5;
    [cell addGestureRecognizer:collectionViewLongPress];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, cell.hd_width - 10, cell.hd_height)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    
    
    if (indexPath.row == 0) {
        imageView.frame = CGRectMake(0, 0, cell.hd_height * 0.5, cell.hd_height * 0.5);
        imageView.hd_centerX = cell.hd_width / 2;
        imageView.hd_centerY = cell.hd_height / 2;
        cell.backgroundColor = UIColorFromRGB(0xeeeeee);
        imageView.backgroundColor = UIColorFromRGB(0xeeeeee);
        imageView.image = [UIImage imageNamed:@"icon_material_add"];
    }else
    {
        cell.backgroundColor = UIColorFromRGB(0xf7f7f7);
        ImageProductModel * model = [self.materialModel.imageProductArray objectAtIndex:indexPath.row - 1];
        imageView.image = model.fanleImage;
        
        if (self.collectionViewDeleteType) {
            UIImageView * deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.hd_width / 6 * 5, imageView.hd_y , imageView.hd_width / 6, imageView.hd_width / 6)];
            deleteImage.image = [UIImage imageNamed:@"icon_material_delete"];
            [cell.contentView addSubview:deleteImage];
        }
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        self.isSingleModel = NO;
        [self addmaterialImage];
        self.collectionViewDeleteType = NO;
        [self.collectionView reloadData];
    }else
    {
        if (self.collectionViewDeleteType) {
            [self.materialModel.imageProductArray removeObjectAtIndex:indexPath.row - 1];
            [self.collectionView reloadData];
        }
    }
}

- (void)voiceAction
{
    // 判断是否能播放
    if (!self.reRecordBtn.hidden) {
        
        // 播放在线录音
        if (self.isPlayLineRecord) {
            // 判断是否正在播放
            if ([BTVoicePlayer share].isPlaying) {
                [[BTVoicePlayer share] stop];
                [self.taskVoiceDetailBtn stopAnimating];
                self.taskVoiceDetailBtn.animationImages = nil;
            }else
            {
                self.taskVoiceDetailBtn.animationImages = @[[UIImage imageNamed:@"voice_shape_one"],[UIImage imageNamed:@"voice_shape_two"],[UIImage imageNamed:@"voice_shape_three"]];
                self.taskVoiceDetailBtn.animationDuration = 1.0;
                [BTVoicePlayer share].delegate = self;
                [[BTVoicePlayer share] playLine:[self.createTaskInfoDic objectForKey:@"audioIntroURL"]];
                [self.taskVoiceDetailBtn startAnimating];
                
            }
            return;
        }
        
        // 播放本地录音
        // 判断是否正在播放
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
            [self.taskVoiceDetailBtn stopAnimating];
            self.taskVoiceDetailBtn.animationImages = nil;
        }else
        {
            self.taskVoiceDetailBtn.animationImages = @[[UIImage imageNamed:@"voice_shape_one"],[UIImage imageNamed:@"voice_shape_two"],[UIImage imageNamed:@"voice_shape_three"]];
            self.taskVoiceDetailBtn.animationDuration = 1.0;
            [[BTVoicePlayer share] play:[RecordTool sharedInstance].savePath];
            [self.taskVoiceDetailBtn startAnimating];
            [[BTVoicePlayer share] audioPlayerDidFinish:^(AVAudioPlayer *player, BOOL flag) {
                [self.taskVoiceDetailBtn stopAnimating];
            }];
        }
    }
}

- (void)changeMusic
{
    [self.taskVoiceDetailBtn stopAnimating];
}

- (void)voiceLongtapAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [[RecordTool sharedInstance]startRecordVoice];
        self.recordAnimationImageView.hidden = NO;
    }else if (longPress.state == UIGestureRecognizerStateEnded)
    {
        CGPoint loc = [longPress locationInView:self.backView];
        if (!CGRectContainsPoint(self.taskVoiceDetailBtn.frame, loc) && loc.y < self.taskVoiceDetailBtn.hd_y) {
            [[RecordTool sharedInstance] stopRecordVoice];
        }else
        {
            [[RecordTool sharedInstance] stopRecordVoice];
            self.reRecordBtn.hidden = NO;
            self.recordTimeLB.hidden = NO;
            self.taskVoiceDetailBtn.image = [UIImage imageNamed:@"voice_shape_three"];
            self.recordTimeLB.text = [NSString stringWithFormat:@"%.0f''", [[RecordTool sharedInstance] timelenght]];
        }
        self.recordAnimationImageView.hidden = YES;
    }
}

- (void)reRecordAction
{
    if ([BTVoicePlayer share].isLocalPlaying) {
        [[BTVoicePlayer share] localstop];
        [self.taskVoiceDetailBtn stopAnimating];
        self.taskVoiceDetailBtn.animationImages = nil;
    }
    if ([BTVoicePlayer share].isPlaying) {
        [[BTVoicePlayer share] stop];
        [self.taskVoiceDetailBtn stopAnimating];
        self.taskVoiceDetailBtn.animationImages = nil;
    }
    
    [RecordTool sharedInstance].savePath = @"";
    self.taskVoiceDetailBtn.image = [UIImage imageNamed:@""];
    self.reRecordBtn.hidden = YES;
    self.recordTimeLB.hidden = YES;
    self.isPlayLineRecord = NO;
}

- (void)deleteCollectionCellAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.collectionViewDeleteType = YES;
        [self.collectionView reloadData];
    }
}

- (void)singleLongtapAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        if (self.singleModel.image) {
            self.singleImageDeleteBtn.hidden = NO;
            self.isDeleteSingleImage = YES;
        }
    }
}


#pragma mark - 点击去除选中效果

- (void)controlAction
{
    [self.taskNameTf resignFirstResponder];
    [self.taskDetailTv resignFirstResponder];
    self.collectionViewDeleteType = NO;
    [self.collectionView reloadData];
}

#pragma mark - 添加作品
- (void)addmaterialImage
{
    ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds andVideoPhoto:NO];
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    
    __weak typeof(self)weakSelf = self;
    __weak typeof(view)weakView = view;
    view.ProductPatternSelectBlock = ^(ProDuctPatternType type) {
        switch (type) {
            case ProDuctPatternType_photo:
                [self getPhotoLibrary];
                break;
            case ProDuctPatternType_photograph:
                [self openCamera];
                break;
            case ProDuctPatternType_graffiti:
                [weakSelf graffiti:nil];
                break;
                
            default:
                break;
        }
        [weakView dismiss];
    };
}

- (void)singleImageAction
{
    if (self.isDeleteSingleImage) {
        self.isDeleteSingleImage = NO;
        self.singleImageDeleteBtn.hidden = YES;
        self.singleImageBtn.image = [UIImage imageNamed:@"icon_material_add"];
        self.singleModel.image = nil;
        self.singleModel.sandBoxFilePath = @"";
        return;
    }
    
    if (![UIImagePNGRepresentation(self.singleImageBtn.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"icon_material_add"])]) {
        
#pragma mark - 已有选择的图片
        
        return;
    }
    
    
    self.isSingleModel = YES;
    ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds andVideoPhoto:YES];
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    
    __weak typeof(self)weakSelf = self;
    __weak typeof(view)weakView = view;
    view.ProductPatternSelectBlock = ^(ProDuctPatternType type) {
        switch (type) {
            case ProDuctPatternType_film:
                [self filmAction];
                break;
            case ProDuctPatternType_video:
                [self getAllVideo];
                break;
            case ProDuctPatternType_photo:
                [self getPhotoLibrary];
                break;
            case ProDuctPatternType_photograph:
                [self openCamera];
                break;
            case ProDuctPatternType_graffiti:
                [weakSelf graffiti:nil];
                break;
                
            default:
                break;
        }
        [weakView dismiss];
    };
    
}




#pragma mark - photo and graffiti
- (void)getPhotoLibrary
{
    __weak typeof(self)weakSelf = self;
    BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
    if (self.isSingleModel) {
        vc.maxNum = 1;
    }else
    {
        vc.maxNum = 9;
    }
    vc.imageClipping = NO;
    vc.showCamera = NO;
    [vc initDataProgress:^(CGFloat progress) {
        
    } finished:^(NSArray<UIImage *> *resultAry, NSArray<PHAsset *> *assetsArry, UIImage *editedImage) {
        
        for (int i = 0; i < resultAry.count; i++) {
            weakSelf.createProductionType = CreatProductionType_photo;
            UIImage *img = [resultAry objectAtIndex:i];
            ImageProductModel * model = [[ImageProductModel alloc]init];
            model.originImage = img;
            model.fanleImage = img;
            [weakSelf resreshImageModel:model];
        }
        
    } cancle:^(NSString *cancleStr) {
        
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)graffiti:(ImageProductModel *)imageModel
{
    __weak typeof(self)weakSelf = self;
    GrafitiViewController * graffitiVC = [[GrafitiViewController alloc]init];
    
    if (imageModel != nil) {
        graffitiVC.sourceimage = imageModel.originImage;
    }else
    {
        imageModel = [[ImageProductModel alloc]init];
    }
    
    graffitiVC.SavaImageProDuctBlock = ^(UIImage * image) {
        weakSelf.createProductionType = CreatProductionType_photo;
        imageModel.originImage = image;
        imageModel.fanleImage = image;
        [weakSelf resreshImageModel:imageModel];
    };
    
    [self presentViewController:graffitiVC animated:NO completion:nil];
}

- (void)resreshImageModel:(ImageProductModel *)model
{
    ProductionModel * productModel ;
    if (self.isSingleModel) {
        productModel = self.singleModel;
        productModel.modelType = ProductModelType_video;
        [productModel.imageProductArray removeAllObjects];
        model.imageModelId = [NSString stringWithFormat:@"%d", productModel.imageProductArray.count];
        [productModel.imageProductArray addObject:model];
        productModel.image = model.fanleImage;
        self.singleImageBtn.image = productModel.image;
        return;
    }else
    {
        productModel = self.materialModel;
    }
    
    productModel.modelType = ProductModelType_photo;
    int num = 1000;
    for (int i = 0; i<productModel.imageProductArray.count; i++) {
        ImageProductModel * imageModel = productModel.imageProductArray[i];
        if ([imageModel.imageModelId isEqualToString:model.imageModelId]) {
            num = i;
            return;
        }
    }
    if (num == 1000) {
        model.imageModelId = [NSString stringWithFormat:@"%d", productModel.imageProductArray.count];
        [productModel.imageProductArray addObject:model];
    }else
    {
        [productModel.imageProductArray removeObjectAtIndex:num];
        [productModel.imageProductArray insertObject:model atIndex:num];
    }
    ImageProductModel * imageModel = [productModel.imageProductArray objectAtIndex:0];
    productModel.image = imageModel.fanleImage;
    productModel.modelType = ProductModelType_photo;
    [self.collectionView reloadData];
}

#pragma mark -  video
- (void)filmAction
{
    [SoftManager shareSoftManager].isCamera = YES;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.sourceType = sourceType;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    //    picker.videoMaximumDuration = 5;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    picker.accessibilityLanguage = NSCalendarIdentifierChinese;
    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)getAllVideo
{
    ProductionModel * productModel ;
    if (self.isSingleModel) {
        productModel = self.singleModel;
    }else
    {
        productModel = self.materialModel;
    }
    
    
    __weak typeof(self)weakSelf = self;
    BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
    vc.maxNum = 1;
    vc.imageClipping = NO;
    vc.showCamera = NO;
    [vc initVideoDataProgress:^(CGFloat progress) {
        
    } finished:^(NSArray<UIImage *> *resultAry, NSArray<PHAsset *> *assetsArry, UIImage *editedImage) {
        weakSelf.createProductionType = CreatProductionType_video;
        PHAsset * asset = [assetsArry firstObject];
        productModel.phAsset = asset;
        productModel.modelType = ProductModelType_video;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.singleImageBtn.image = productModel.image;
        });
    } cancle:^(NSString *cancleStr) {
        ;
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)openCamera
{
    if([[BLImageHelper shareImageHelper] cameraPermissions]){
        [SoftManager shareSoftManager].isCamera = YES;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.sourceType = sourceType;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        picker.accessibilityLanguage = NSCalendarIdentifierChinese;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请允许app获得您的相机权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [SoftManager shareSoftManager].isCamera = NO;
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSLog(@"%@", info);
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        self.createProductionType = CreatProductionType_photo;
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        ImageProductModel * model = [[ImageProductModel alloc]init];
        model.originImage = img;
        model.fanleImage = img;
        [self resreshImageModel:model];
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL * url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString * urlStr = [url path];
        
        [self saveVideoPath:urlStr];
    }
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [SoftManager shareSoftManager].isCamera = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveVideoPath:(NSString *)videoPath {
    NSURL *url = [NSURL fileURLWithPath:videoPath];
    
    //标识保存到系统相册中的标识
    __block NSString *localIdentifier;
    __weak typeof(self)weakSelf = self;
    //首先获取相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        //folderName是我们写入照片的相册
        if ([assetCollection.localizedTitle isEqualToString:_folderName])  {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                //请求创建一个Asset
                PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
                //请求编辑相册
                PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                //为Asset创建一个占位符，放到相册编辑请求中
                PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
                //相册中添加视频
                [collectonRequest addAssets:@[placeHolder]];
                
                localIdentifier = placeHolder.localIdentifier;
                weakSelf.localIdentifier = placeHolder.localIdentifier;
            } completionHandler:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"保存图片成功!");
                    
                    [weakSelf getFile:videoPath];
                } else {
                    NSLog(@"保存图片失败:%@", error);
                }
                
            }];
        }
    }];
}

- (void)getFile:(NSString *)filePath {
    
    ProductionModel * productModel ;
    if (self.isSingleModel) {
        productModel = self.singleModel;
    }else
    {
        productModel = self.materialModel;
    }
    
    if ([self isExistFolder:_folderName]) {
        //        获取需要得到的文件的localIdentifier
        //        NSDictionary *dict = [self readFromPlist];
        //        NSString *localIdentifier = [dict valueForKey:[self showFileNameFromPath:filePath]];
        __weak typeof(self)weakSelf = self;
        PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
        [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PHAssetCollection *assetCollection = obj;
            if ([assetCollection.localizedTitle isEqualToString:_folderName])  {
                PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
                [assetResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    PHAsset *asset = obj;
                    if ([weakSelf.localIdentifier isEqualToString:asset.localIdentifier]) {
                        productModel.phAsset = asset;
                        productModel.modelType = ProductModelType_video;
                        weakSelf.createProductionType = CreatProductionType_video;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            weakSelf.singleImageBtn.image = productModel.image;
                        });
                    }
                }];
            }
        }];
    }
}

- (BOOL)isExistFolder:(NSString *)folderName {
    //首先获取用户手动创建相册的集合
    PHFetchResult *collectonResuts = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    __block BOOL isExisted = NO;
    //对获取到集合进行遍历
    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PHAssetCollection *assetCollection = obj;
        //folderName是我们写入照片的相册
        if ([assetCollection.localizedTitle isEqualToString:folderName])  {
            isExisted = YES;
        }
    }];
    
    return isExisted;
}

- (void)createFolder:(NSString *)folderName {
    if (![self isExistFolder:folderName]) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //添加HUD文件夹
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:folderName];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"创建相册文件夹成功!");
            } else {
                NSLog(@"创建相册文件夹失败:%@", error);
            }
        }];
    }
}

- (void)savaProductAction
{
    __weak typeof(self)weakSelf = self;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    // 上传音频
    // 有本地录音
    if ([RecordTool sharedInstance].savePath.length > 0) {
        
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            
            NSMutableArray *pageRecordArray = [NSMutableArray array];
            HDPicModle * picModel = [[HDPicModle alloc]init];
            picModel.picName = @"录音介绍";
            picModel.url = [RecordTool sharedInstance].savePath;
            [pageRecordArray addObject:picModel];
            
            [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andMP3Array:pageRecordArray progress:^(NSProgress * _Nullable progress) {
                [SVProgressHUD showProgress:progress.fractionCompleted];
            } success:^(id  _Nonnull responseObject) {
                [SVProgressHUD dismiss];
                
                NSLog(@"[responseObject class] = %@", [responseObject class]);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"jsonStr = %@", jsonStr);
                    if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                        weakSelf.recordIntroUrl = jsonStr;
                    }else
                    {
                        jsonStr = @"";
                    }
                    
                    dispatch_group_leave(group);
                });
            } failure:^(NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_group_leave(group);
                });
            }];
            
        });
    }else
    {
        if (self.madeId > 0) {
            self.recordIntroUrl = [[[self.createTaskInfoDic objectForKey:@"audioIntroURL"] componentsSeparatedByString:@".comh"] lastObject];
        }else
        {
            self.recordIntroUrl = @"";
        }
    }
    
    if (self.singleModel && self.singleModel.modelType == ProductModelType_video) {
        
        // 上传单图介绍
        if (self.singleModel.sandBoxFilePath.length <= 0) {// 单图片
            ProductionModel * model= self.singleModel;
            // 上传背景图
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                
                // finalImage图
                NSMutableArray *finalImageArray = [NSMutableArray array];
                for (int i = 0; i < model.imageProductArray.count; i++) {
                    ImageProductModel * imageModel = model.imageProductArray[i];
                    HDPicModle * picModel = [[HDPicModle alloc]init];
                    picModel.picName = [NSString stringWithFormat:@"single%d", i];
                    picModel.pic = imageModel.fanleImage;
                    [finalImageArray addObject:picModel];
                    
                }
                
                [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andPicArray:finalImageArray progress:^(NSProgress * _Nullable progress) {
                    [SVProgressHUD showProgress:progress.fractionCompleted];
                } success:^(id  _Nonnull responseObject) {
                    [SVProgressHUD dismiss];
                    
                    NSLog(@"[responseObject class] = %@", [responseObject class]);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSLog(@"finalimage jsonStr = %@", jsonStr);
                        if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                            
                            NSArray * urlArray = [jsonStr componentsSeparatedByString:@";"];
                            for (int i = 0; i < urlArray.count; i++) {
                                NSLog(@"finalimage url = %@", urlArray[i]);
                                
                                weakSelf.mp4Url = urlArray[i];
                            }
                            
                        }else
                        {
                            jsonStr = @"";
                        }
                        
                        dispatch_group_leave(group);
                    });
                } failure:^(NSError * _Nonnull error) {
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        dispatch_group_leave(group);
                    });
                }];
                
            });
        }else// 单视频
        {
            ProductionModel * model = self.singleModel;
            // 上传视频
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                
                HDPicModle * picModel = [[HDPicModle alloc]init];
                picModel.picName = @"danshipin";
                picModel.url = model.sandBoxFilePath;
                
                NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);
                
                [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andVideoUrl:picModel progress:^(NSProgress * _Nullable progress) {
                    [SVProgressHUD showProgress:progress.fractionCompleted];
                } success:^(id  _Nonnull responseObject) {
                    [SVProgressHUD dismiss];
                    NSLog(@"[responseObject class] = %@", [responseObject class]);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSLog(@"jsonStr = %@", jsonStr);
                        if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                            weakSelf.mp4Url = jsonStr;
                        }else
                        {
                            jsonStr = @"";
                        }
                        
                        dispatch_group_leave(group);
                    });
                    
                } failure:^(NSError * _Nonnull error) {
                    ;[SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        dispatch_group_leave(group);
                    });
                }];
                
            });
            
            
            // 上传封面图
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                
                HDPicModle * picModel = [[HDPicModle alloc]init];
                picModel.picName = @"singleCover";
                picModel.pic = model.image;
                
                NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);
                
                [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
                    ;
                } success:^(id  _Nonnull responseObject) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                        NSLog(@"jsonStr = %@", jsonStr);
                        if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                            weakSelf.mp4IconUrl = jsonStr;
                        }else
                        {
                            jsonStr = @"";
                        }
                        
                        dispatch_group_leave(group);
                    });
                    
                } failure:^(NSError * _Nonnull error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        dispatch_group_leave(group);
                    });
                }];
            });
            
        }
        
    }else
    {
        self.mp4Url = @"";
    }
    
    self.metarialImageUrlArray = [NSMutableArray array];
    if (self.materialModel) {
        ProductionModel * model= self.materialModel;
        // 上传背景图
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            
            // finalImage图
            NSMutableArray *finalImageArray = [NSMutableArray array];
            for (int i = 0; i < model.imageProductArray.count; i++) {
                ImageProductModel * imageModel = model.imageProductArray[i];
                HDPicModle * picModel = [[HDPicModle alloc]init];
                picModel.picName = [NSString stringWithFormat:@"metarial%d", i];
                picModel.pic = imageModel.fanleImage;
                [finalImageArray addObject:picModel];
                
            }
            
            [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andPicArray:finalImageArray progress:^(NSProgress * _Nullable progress) {
                [SVProgressHUD showProgress:progress.fractionCompleted];
            } success:^(id  _Nonnull responseObject) {
                [SVProgressHUD dismiss];
                
                NSLog(@"[responseObject class] = %@", [responseObject class]);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSLog(@"finalimage jsonStr = %@", jsonStr);
                    if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                        
                        NSArray * urlArray = [jsonStr componentsSeparatedByString:@";"];
                        for (int i = 0; i < urlArray.count; i++) {
                            NSLog(@"finalimage url = %@", urlArray[i]);
                            NSDictionary * imageInfoDic = @{@"imageUrl":urlArray[i]};
                            
                            [weakSelf.metarialImageUrlArray addObject:imageInfoDic];
                        }
                        
                    }else
                    {
                        jsonStr = @"";
                    }
                    
                    dispatch_group_leave(group);
                });
            } failure:^(NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_group_leave(group);
                });
            }];
            
        });
    }
    
    
    // 上传封面图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = @"CoverIcon";;
        picModel.pic = [self getGraffitiImage];
        
        [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(id  _Nonnull responseObject) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    weakSelf.coverIconUrl = jsonStr;
                }else
                {
                    jsonStr = @"";
                }
                
                dispatch_group_leave(group);
            });
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                dispatch_group_leave(group);
            });
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD show];
            
            NSMutableDictionary * infoDic = [NSMutableDictionary dictionary];
            [infoDic setObject:self.taskNameTf.text forKey:@"title"];
            [infoDic setObject:self.coverIconUrl forKey:kcoverImg];
            [infoDic setObject:self.taskDetailTv.text forKey:ktxtDescribe];
            [infoDic setObject:self.recordIntroUrl forKey:kmp3Describe];
            [infoDic setObject:self.mp4Url forKey:kimagemp4Describe];
            [infoDic setObject:self.metarialImageUrlArray forKey:kmaterImg];
            [infoDic setObject:@(self.madeId) forKey:kmadeId];
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTeacher_createMetarialWithWithDic:infoDic withNotifiedObject:self];
            
        });
    });
}

- (void)didRequestTeacher_createMetarialSuccessed
{
#pragma mark - 获取到madeId
    
    if (self.madeId > 0) {
        if (self.changeMetarialBlock) {
            self.changeMetarialBlock(@{});
        }
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    
    if (self.createMetarialBlock) {
        self.createMetarialBlock(@{@"name":self.taskNameTf.text,@"madeId":[[[UserManager sharedManager] getCreateMetarial_madeId] objectForKey:kmadeId]});
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didRequestTeacher_createMetarialFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCreateTaskProblemContentSuccessed
{
    // create
    [SVProgressHUD dismiss];
    [self refreshView];
}

- (void)didRequestCreateTaskProblemContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (UIImage *)getGraffitiImage
{
    CGRect scope = CGRectMake(self.view.frame.origin.x + 1, self.view.frame.origin.y + 1, self.view.frame.size.width - 2, self.view.frame.size.height - 2);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:self.view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    //    UIGraphicsBeginImageContextWithOptions(scope.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);// 下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    return image;
    
}
- (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setFolderName:(NSString *)folderName {
    if (!_folderName) {
        _folderName = folderName;
        [self createFolder:folderName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
