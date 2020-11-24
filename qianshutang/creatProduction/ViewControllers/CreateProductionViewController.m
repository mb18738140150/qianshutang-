//
//  CreateProductionViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreateProductionViewController.h"
#import "GrafitiViewController.h"
#import "ProductPatternSelectView.h"
#import "ProductListCell.h"
#define kProductListCellID @"ProductListCell"
#import <MobileCoreServices/MobileCoreServices.h>
#import "RecordAnimationView.h"
#import "TextPositionView.h"
#import "PageControlLB.h"
#import "HomeworkDetailView.h"
#import "PlayVideoViewController.h"
#import "TaskMetarialPhotoViewController.h"

@interface CreateProductionViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIVideoEditorControllerDelegate, UIScrollViewDelegate, Task_SubmitCreateProduct, Task_CreateTaskProblemContent>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

// 创作作品列表
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)UIButton * addView;// 添加作品按钮
@property (nonatomic, strong)UIButton * editView;// 编辑作品按钮

// 作品显示视图
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIScrollView * scrollView;

// 音频
@property (nonatomic, strong)RecordAnimationView * recoardAnimatView;
@property (nonatomic, strong)UIButton * reRecoardBtn;
@property (nonatomic, strong)UIButton * playAudioBtn;
@property (nonatomic, strong)UILabel * audioLenthLB;

// 编辑
@property (nonatomic, assign)BOOL isEditing;//编辑作品
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

// 视频录制所需参数
@property (nonatomic, strong)NSString * folderName;//创建系统相册名称
@property (nonatomic, strong)NSString * localIdentifier;//录制视频标识符

@property (nonatomic, strong)UIButton * nextBtn;
@property (nonatomic, strong)UIButton * previousBtn;
@property (nonatomic, strong)UIButton * addAudioBtn;
@property (nonatomic, strong)UIButton * addTextBtn;
@property (nonatomic, strong)UIButton * addGraffitiBtn;
@property (nonatomic, strong)PageControlLB * pageControlLB;
@property (nonatomic, strong)NSMutableArray * scrollImageViewArr;

// 作业题
@property (nonatomic, strong)HomeworkDetailView * homeworkDetailView;
@property (nonatomic, strong)UIScrollView * backScrollView;
@property (nonatomic, strong)UIView * createBackView;

@property (nonatomic, strong)HYSegmentedControl * hySegmentControl;

@end

@implementation CreateProductionViewController

- (NSMutableArray *)scrollImageViewArr
{
    if (!_scrollImageViewArr) {
        _scrollImageViewArr = [NSMutableArray array];
    }
    return _scrollImageViewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.folderName = @"qianshutang";
    [self prepareUI];
    
    [self refreshUIWith:self.model];
}

- (void)refreshUIWith:(ProductionModel *)model
{
    if (model.image == nil) {
        return;
    }
    self.editView.enabled = YES;
    self.createProductionType = CreatProductionType_new;
    [self.scrollView removeAllSubviews];
    switch (self.model.modelType) {
        case ProductModelType_text:
        {
            self.createProductionType = CreatProductionType_text;
            for (int i = 0; i < self.model.textProductArray.count; i++) {
                TextProductModel * textModel = [self.model.textProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                imageView.image = textModel.textImage;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.scrollImageViewArr addObject:imageView];
                [self.scrollView addSubview:imageView];
            }
            self.scrollView.contentSize = CGSizeMake(self.model.textProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
        }
            break;
        case ProductModelType_music:
        {
            self.createProductionType = CreatProductionType_music;
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = self.model.image;
            [self.scrollView addSubview:imageView];
            self.reRecoardBtn.hidden = NO;
            self.playAudioBtn.hidden = NO;
            self.audioLenthLB.hidden = NO;
            
            self.audioLenthLB.text = [NSString stringWithFormat:@"%.0f\"", [self getAudioLength:self.model.audioUrl]];
            
        }
            break;
        case ProductModelType_photo:
        {
            self.createProductionType = CreatProductionType_photo;
            for (int i = 0; i < self.model.imageProductArray.count; i++) {
                ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:i];
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.hd_width * i, 0, self.scrollView.hd_width, self.scrollView.hd_height)];
                imageView.image = imageModel.fanleImage;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.scrollImageViewArr addObject:imageView];
                [self.scrollView addSubview:imageView];
                
                if (i == 0) {
                    if (imageModel.audioUrl.length > 0) {
                        self.playAudioBtn.hidden = NO;
                        self.audioLenthLB.hidden = NO;
                        self.audioLenthLB.text = [NSString stringWithFormat:@"%.0f\"", [self getAudioLength:imageModel.audioUrl]];
                        
                        [self.addAudioBtn setImage:[UIImage imageNamed:@"icon_reset_voice"] forState:UIControlStateNormal];
                    }
                }
                
            }
            self.scrollView.contentSize = CGSizeMake(self.model.imageProductArray.count * self.scrollView.hd_width, self.scrollView.hd_height);
        }
            break;
        case ProductModelType_video:
        {
            self.createProductionType = CreatProductionType_video;
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = self.model.image;
            [self.scrollView addSubview:imageView];
            
            UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            playButton.frame = CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10);
            playButton.hd_centerX = imageView.hd_centerX;
            playButton.hd_centerY = imageView.hd_centerY;
            [playButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
            [self.scrollView addSubview:playButton];
            [playButton addTarget:self action:@selector(playVideoAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
            
        default:
            break;
    }
    
    if (model.modelType == ProductModelType_music || model.modelType == ProductModelType_video) {
        [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
        self.editView.enabled = YES;
        [self.addView setImage:[UIImage imageNamed:@"dowork_add_grey_btn"] forState:UIControlStateNormal];
        self.addView.enabled = NO;
    }
    
    [self refreshWithScroll:0];
    
}

- (float)getAudioLength:(NSString *)urlStr
{
    AVURLAsset*audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:urlStr] options:nil];
    
    CMTime audioDuration = audioAsset.duration;
    
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.model == nil) {
        self.model = [[ProductionModel alloc]init];
    }
    if (self.userWorkId > 0) {
        self.model.userWorkId = self.userWorkId;
    }
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_save];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.saveBlock = ^{
        
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            if (self.createProductionType == CreatProductionType_yulan) {
                [SVProgressHUD showInfoWithStatus:@"预览模式下不能提交"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return ;
            }
        }
        
        [weakSelf savaProductAction];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"创作作品";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    
    
    UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    backGroundView.backgroundColor = UIRGBColor(239, 239, 239);
    self.createBackView = backGroundView;
    if (self.isDoTask) {
        self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
        self.backScrollView.backgroundColor = UIColorFromRGB(0xffffff);
        [self.view addSubview:self.backScrollView];
        
        self.homeworkDetailView = [[HomeworkDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - self.navigationView.hd_height) withInfo:[[UserManager sharedManager] getTaskProbemContentInfo]];
        [self.backScrollView addSubview:self.homeworkDetailView];
        self.homeworkDetailView.playVideoIntroBlock = ^(NSDictionary *infoDic) {
            PlayVideoViewController * videoVC = [[PlayVideoViewController alloc]init];
            videoVC.infoDic = @{kMP4Src:[infoDic objectForKey:@"imageIntroURL"]};
            [weakSelf presentViewController:videoVC animated:NO completion:nil];
        };
        
        backGroundView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - self.navigationView.hd_height);
        [self.backScrollView addSubview:backGroundView];
        self.backScrollView.contentSize = CGSizeMake(kScreenWidth * 2, self.backScrollView.hd_height);
        self.backScrollView.scrollEnabled = NO;
        
        self.hySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:kScreenWidth * 0.2 OriginY:0 Titles:@[@"作业题",@"做作业"] delegate:self];
        [self.hySegmentControl hideBottomView];
        [self.hySegmentControl hideSeparateLine];
        [self.navigationView.rightView addSubview:self.hySegmentControl];
        self.hySegmentControl.hidden = NO;
        self.hySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
            if ([segmentControl isEqual:weakSelf.hySegmentControl]) {
                [weakSelf.backScrollView scrollRectToVisible:CGRectMake(kScreenWidth * index, 0, weakSelf.backScrollView.hd_width, weakSelf.backScrollView.hd_height) animated:NO];
            }
        };
        
    }else
    {
        [self.navigationView.rightView addSubview:self.titleLB];
        [self.view addSubview:backGroundView];
    }
    
    self.addView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addView.frame = CGRectMake(kScreenWidth * 0.18 * 3 / 16, 20, kScreenWidth * 0.18 * 0.25, kScreenWidth * 0.18 * 0.25 * 1.4) ;
    [self.addView setImage:[UIImage imageNamed:@"dowork_add_btn"] forState:UIControlStateNormal];
    [self.createBackView addSubview:self.addView];
    
    self.editView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editView.frame = CGRectMake(CGRectGetMaxX(self.addView.frame) + kScreenWidth * 0.18 * 0.125, 20, kScreenWidth * 0.18 * 0.25, kScreenWidth * 0.18 * 0.25 * 1.4);
    [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
    [self.createBackView addSubview:self.editView];
    self.editView.enabled = NO;
    
    [self.addView addTarget:self action:@selector(addProductionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.editView addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.createProductionType != CreatProductionType_new) {
        [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
        self.editView.enabled = YES;
    }
    
    if (self.createProductionType == CreatProductionType_music ) {
        [self.addView setImage:[UIImage imageNamed:@"dowork_add_grey_btn"] forState:UIControlStateNormal];
        self.addView.enabled = NO;
    }
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.18, 13, (int )(kScreenWidth * 0.82 - 10), kScreenHeight* 0.82 - 20)];
    [self.createBackView addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.hd_width * 0.06, 0, self.backView.hd_width * 0.88, self.backView.hd_height)];
    self.tipLB.textColor = UIColorFromRGB(0x515151);
    self.tipLB.numberOfLines = 0;
    self.tipLB.font = [UIFont systemFontOfSize:16];
    self.tipLB.text = @"操作步骤：\n1.点击左侧“添加”选择绘本模式、音频模式、写作模式或者视频模式\n2.绘本模式即可上传多张图片，对图片进行语音、文字、画板编辑\n3.音频模式即可录制一段纯音频\n4.写作模式即可输入纯文字\n5.视频模式则即可拍摄一段视频或者选择一段本地已录制好的短视频大小不可超过300M\n（注：绘本模式中，若某张图片无对应音频，则翻页时间默认为5秒）";
    [self.backView addSubview:self.tipLB];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.backView.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = YES;
    [self.backView addSubview:self.scrollView];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.hidden = YES;
    
    [self addAudioUI];
    [self addTextAndImageOperationUI];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.editView.frame) + 10, self.backView.hd_x - 20, kScreenHeight - CGRectGetMaxY(self.editView.frame) - 20) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ProductListCell class] forCellReuseIdentifier:kProductListCellID];
    self.tableView.backgroundColor = UIRGBColor(239, 239, 239);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.createBackView addSubview:self.tableView];
    
}

- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didRequestCreateTaskProblemContentSuccessed
{
    
}

- (void)didRequestCreateTaskProblemContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.createProductionType == CreatProductionType_text) {
        return self.model.textProductArray.count;
    }else if (self.createProductionType == CreatProductionType_photo)
    {
        return self.model.imageProductArray.count;
    }
    if (self.model.image) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    ProductListCell * cell = [tableView dequeueReusableCellWithIdentifier:kProductListCellID forIndexPath:indexPath];
    [cell resetUI];
    if (self.createProductionType == CreatProductionType_photo) {
        ImageProductModel * model = [self.model.imageProductArray objectAtIndex:indexPath.row];
        cell.contentImageView.image = model.fanleImage;

        [cell showNumber];
        cell.numberLB.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        cell.DeleteProcuctBlock = ^{
            
            [weakSelf.model.imageProductArray removeObjectAtIndex:indexPath.row];
            for (int i = 0; i < weakSelf.model.imageProductArray.count; i++) {
                ImageProductModel * model = weakSelf.model.imageProductArray[i];
                model.imageModelId = [NSString stringWithFormat:@"%d", i];
            }
            
            if (weakSelf.model.imageProductArray.count == 0) {
                [weakSelf.tableView reloadData];
                weakSelf.createProductionType = CreatProductionType_new;
                weakSelf.isEditing = NO;
                weakSelf.editView.enabled = NO;
                weakSelf.model.image = nil;
                [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
                [weakSelf hideAudio];
            }else
            {
                [weakSelf deleteProduct:indexPath.row];
            }
        };
    }
    
    if (self.createProductionType == CreatProductionType_video || self.createProductionType == CreatProductionType_music) {
        cell.contentImageView.image = self.model.image;
        cell.DeleteProcuctBlock = ^{
            weakSelf.createProductionType = CreatProductionType_new;
            weakSelf.isEditing = NO;
            weakSelf.model.phAsset = nil;
            weakSelf.model.image = nil;
            weakSelf.model.videoUrl = nil;
            weakSelf.model.audioUrl = nil;
            [weakSelf.addView setImage:[UIImage imageNamed:@"dowork_add_btn"] forState:UIControlStateNormal];
            weakSelf.addView.enabled = YES;
            [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
            weakSelf.editView.enabled = NO;
            [weakSelf.tableView reloadData];
            [weakSelf hideAudio];
        };
    }
    
    if (self.createProductionType == CreatProductionType_text) {
        TextProductModel * model = [self.model.textProductArray objectAtIndex:indexPath.row];
        cell.contentImageView.image = model.textImage;
        
        [cell showNumber];
        cell.numberLB.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        cell.DeleteProcuctBlock = ^{
            [weakSelf.model.textProductArray removeObjectAtIndex:indexPath.row];
            for (int i = 0; i < weakSelf.model.textProductArray.count; i++) {
                TextProductModel * model = weakSelf.model.textProductArray[i];
                model.textModelId = [NSString stringWithFormat:@"%d", i];
            }
            // 删除完全部文字作品
            if (weakSelf.model.textProductArray.count == 0) {
                [weakSelf.tableView reloadData];
                weakSelf.createProductionType = CreatProductionType_new;
                weakSelf.isEditing = NO;
                weakSelf.editView.enabled = NO;
                weakSelf.model.image = nil;
                [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
                [weakSelf hideAudio];
            }else
            {
                [weakSelf deleteProduct:indexPath.row];
            }
        };
        
    }
    
    if (indexPath.row == self.selectIndexPath.row) {
        [cell refreshBackView];
    }
    
    if (self.isEditing) {
        [cell shwDelete];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.hd_width * 0.75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    [self.tableView reloadData];
    
    [self.scrollView scrollRectToVisible:CGRectMake((self.selectIndexPath.row ) * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self refreshWithScroll:(self.selectIndexPath.row)];
    });
    
}

#pragma mark - add & edit

- (void)addProductionAction
{
    if (self.createProductionType == CreatProductionType_photo) {
        ProductPatternSelectView * view;
        
        if (self.isDoTask) {
            view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withPhoto:YES andDoTask:YES];
        }else
        {
            view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withPhoto:YES];
        }
        
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
                case ProDuctPatternType_Metarial:
                {
                    TaskMetarialPhotoViewController * vc = [[TaskMetarialPhotoViewController alloc]init];
                    vc.TaskMetarialSelectComplateBlock = ^(NSArray *selectArray) {
                        [weakSelf getTaskMetarialPhoto:selectArray];
                    };
                    [self presentViewController:vc animated:NO completion:nil];
                }
                    break;
                default:
                    break;
            }
            [weakView dismiss];
        };
    }else if (self.createProductionType == CreatProductionType_text)
    {
        [self textAction:nil];
    }else if (self.createProductionType == CreatProductionType_video) {
        ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds andVideo:YES];
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
                
                    
                default:
                    break;
            }
            [weakView dismiss];
        };
    }
    else
    {
        ProductPatternSelectView * view ;
        if (self.isDoTask) {
            view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withPhoto:NO andDoTask:YES];
        }else
        {
            view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withPhoto:NO];
        }
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:view];
        
        __weak typeof(self)weakSelf = self;
        __weak typeof(view)weakView = view;
        view.ProductPatternSelectBlock = ^(ProDuctPatternType type) {
            switch (type) {
                case ProDuctPatternType_recoard:
                    weakSelf.createProductionType = CreatProductionType_music;
                    [weakSelf refreshAudioUI:nil];
                    break;
                case ProDuctPatternType_text:
                    weakSelf.createProductionType = CreatProductionType_text;
                    [self textAction:nil];
                    break;
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
                case ProDuctPatternType_Metarial:
                {
                    TaskMetarialPhotoViewController * vc = [[TaskMetarialPhotoViewController alloc]init];
                    
                    vc.TaskMetarialSelectComplateBlock = ^(NSArray *selectArray) {
                        [weakSelf getTaskMetarialPhoto:selectArray];
                    };
                    
                    [self presentViewController:vc animated:NO completion:nil];
                }
                    break;
                    
                default:
                    break;
            }
            [weakView dismiss];
        };
    }
}

- (void)getTaskMetarialPhoto:(NSArray *)array
{
    for (int i = 0; i < array.count; i++) {
        NSDictionary * infoDic = [array objectAtIndex:i];
        
        UIImage * image = [infoDic objectForKey:@"imageData"];
        
        ImageProductModel * imageModel = [[ImageProductModel alloc]init];
        self.createProductionType = CreatProductionType_photo;
        imageModel.originImage = image;
        imageModel.fanleImage = [self getFanalImageWithImage:image andImage:imageModel.textImage andBackRect:imageModel.backRect andRect:imageModel.tetRect];
        [self resreshImageModel:imageModel];
        [self refreshPhotoScrollView:imageModel];
    }
}

- (void)editAction
{
    if (self.isEditing) {
        self.isEditing = NO;
        [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
    }else
    {
        [self.editView setImage:[UIImage imageNamed:@"dowork_editfinish_btn"] forState:UIControlStateNormal];
        self.isEditing = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - text Product
- (void)textAction:(TextProductModel * )model
{
    __weak typeof(self)weakSelf = self;
    TextProductModel * textModel = [[TextProductModel alloc]init];
    
    if (model) {
        textModel = model;
    }else
    {
        textModel.colorStr = kBlack;
    }
    
    ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withText:textModel.text];
    [view resetTextColor:textModel.colorStr];
    __weak typeof(view)weakView = view;
    view.textBlock = ^(NSDictionary *infoDic) {
        textModel.text = [infoDic objectForKey:@"title"];
        textModel.colorStr = [infoDic objectForKey:kcolorStr];
        [weakSelf refreshTextModel:textModel];
        
        [weakSelf textPointAction:infoDic andModel:textModel];
        [weakView dismiss];
    };
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
}

- (void)textPointAction:(NSDictionary *)infoDic andModel:(TextProductModel *)model
{
    __weak typeof(self)weakSelf = self;
    TextPositionView * textView = [[TextPositionView alloc]initWithFrame:self.view.bounds andText:[infoDic objectForKey:@"title"] andColor:[infoDic objectForKey:kcolorStr] andImage:nil];
    __weak typeof(textView)weakView = textView;
    
    textView.textPositionBlock = ^(CGPoint positionPoint, NSDictionary *infoaDic, UIImage *image) {
        
        model.text = [infoaDic objectForKey:@"title"];
        model.textImage = image;
        model.colorStr = [infoaDic objectForKey:kcolorStr];
        [weakSelf refreshTextModel:model];
        [weakSelf refreshTextScrollView:model];
        [weakView cancelAction];
    };
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:textView];
}

- (void)refreshTextModel:(TextProductModel *)model
{
    int num = 1000;
    for (int i = 0; i<self.model.textProductArray.count; i++) {
        TextProductModel * textModel = self.model.textProductArray[i];
        if ([textModel.textModelId isEqualToString:model.textModelId]) {
            num = i;
            break;
        }
    }
    if (num == 1000) {
        model.textModelId = [NSString stringWithFormat:@"%d", self.model.textProductArray.count];
        [self.model.textProductArray addObject:model];
    }else
    {
        [self.model.textProductArray removeObjectAtIndex:num];
        [self.model.textProductArray insertObject:model atIndex:num];
    }
    TextProductModel * imageModel = [self.model.textProductArray objectAtIndex:0];
    self.model.image = imageModel.textImage;
    self.model.modelType = ProductModelType_text;
    [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
    self.editView.enabled = YES;
    [self.tableView reloadData];
}

- (void)refreshTextScrollView:(TextProductModel *)textModel
{
    int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
    int count = self.scrollView.contentSize.width / self.backView.hd_width;

    // 新增文本
    if (count < self.model.textProductArray.count) {
        TextProductModel * model = [self.model.textProductArray lastObject];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.hd_width * count, 0, self.backView.hd_width, self.backView.hd_height)];
        imageView.image = model.textImage;
        imageView.tag = count + 1000;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollImageViewArr addObject:imageView];
        [self.scrollView addSubview:imageView];
        
        self.scrollView.contentSize = CGSizeMake(self.backView.hd_width * self.scrollImageViewArr.count, self.backView.hd_height);
        [self.scrollView scrollRectToVisible:CGRectMake(count * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [self refreshWithScroll:count];
        });
    }else
    {// 编辑已存在文本
        for (int i = 0; i < count; i++) {
            if (i == currentCount) {
                UIImageView * imageView = [self.scrollImageViewArr objectAtIndex:i];
                imageView.image = textModel.textImage;
            }
        }
        
        self.scrollView.contentSize = CGSizeMake(self.backView.hd_width * self.scrollImageViewArr.count, self.backView.hd_height);
        [self.scrollView scrollRectToVisible:CGRectMake(currentCount * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [self refreshWithScroll:currentCount];
        });
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width ;
    
    [self refreshWithScroll:currentCount];
}

- (void)refreshWithScroll:(int)currentCount
{
    int count = self.scrollView.contentSize.width / self.backView.hd_width;
    self.scrollView.hidden = NO;
    self.addTextBtn.hidden = NO;
    self.pageControlLB.hidden = NO;
    if (self.createProductionType == CreatProductionType_text) {
        self.addAudioBtn.hidden = YES;
        self.addGraffitiBtn.hidden = YES;
    }else if (self.createProductionType == CreatProductionType_photo)
    {
        self.addAudioBtn.hidden = NO;
        self.addGraffitiBtn.hidden = NO;
        
        ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:currentCount];
        if (imageModel.musicPath || imageModel.audioUrl) {
            self.playAudioBtn.hidden = NO;
            self.audioLenthLB.hidden = NO;
            
            if (imageModel.audioUrl) {
                self.audioLenthLB.text = [NSString stringWithFormat:@"%.0f\"", [self getAudioLength:imageModel.audioUrl]];
            }
            
            [self.addAudioBtn setImage:[UIImage imageNamed:@"icon_reset_voice"] forState:UIControlStateNormal];
        }else
        {
            self.playAudioBtn.hidden = YES;
            self.audioLenthLB.hidden = YES;
            [self.addAudioBtn setImage:[UIImage imageNamed:@"icon_add_voice"] forState:UIControlStateNormal];
        }
    }else
    {
        self.addTextBtn.hidden = YES;
        self.pageControlLB.hidden = YES;
    }
    
    if (self.model.modelType == ProductModelType_text) {
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.textProductArray.count];
    }else if (self.model.modelType == ProductModelType_photo)
    {
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/%d", currentCount + 1, self.model.imageProductArray.count];
    }else
    {
        self.pageControlLB.pageLB.text = [NSString stringWithFormat:@"%d/1", currentCount + 1];
    }
    
    
    if (self.scrollImageViewArr.count > 1) {
        if (currentCount == self.scrollImageViewArr.count - 1) {
            self.previousBtn.hidden = NO;
            self.nextBtn.hidden = YES;
        }else if (currentCount == 0)
        {
            self.nextBtn.hidden = NO;
            self.previousBtn.hidden = YES;
        }else
        {
            self.nextBtn.hidden = NO;
            self.previousBtn.hidden = NO;
        }
    }else
    {
        self.previousBtn.hidden = YES;
        self.nextBtn.hidden = YES;
    }
    
    self.selectIndexPath = [NSIndexPath indexPathForRow:currentCount inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:self.selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)deleteProduct:(int)count
{
    for (int i = self.scrollImageViewArr.count - 1; i > count; i--) {
        
        if (i - 1 >= 0) {
            UIImageView * image = self.scrollImageViewArr[i];
            UIImageView * nextImage = self.scrollImageViewArr[i - 1];
            image.frame = nextImage.frame;
            
        }
    }
    
    UIImageView * imageView = [self.scrollView viewWithTag:1000 + count];
    [imageView removeFromSuperview];
    [self.scrollImageViewArr removeObjectAtIndex:count];
    
    for (int i = 0; i < self.scrollImageViewArr.count; i++) {
        UIImageView * image = self.scrollImageViewArr[i];
        image.tag = i + 1000;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollImageViewArr.count * self.backView.hd_width, self.backView.hd_height);
    
    if (count <= self.selectIndexPath.row) {
        self.selectIndexPath = [NSIndexPath indexPathForRow:self.selectIndexPath.row - 1 inSection:0];
    }
    [self.scrollView scrollRectToVisible:CGRectMake(self.selectIndexPath.row * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self refreshWithScroll:self.selectIndexPath.row];
    });
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
    __weak typeof(self)weakSelf = self;
    BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
    vc.maxNum = 1;
    vc.imageClipping = NO;
    vc.showCamera = NO;
    [vc initVideoDataProgress:^(CGFloat progress) {
        
    } finished:^(NSArray<UIImage *> *resultAry, NSArray<PHAsset *> *assetsArry, UIImage *editedImage) {
        weakSelf.createProductionType = CreatProductionType_video;
        PHAsset * asset = [assetsArry firstObject];
        weakSelf.model.phAsset = asset;
        weakSelf.model.modelType = ProductModelType_video;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.scrollView.hidden = NO;
            UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            backImageView.contentMode = UIViewContentModeScaleAspectFit;
            backImageView.image = self.model.image;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.hd_width, self.scrollView.hd_height);
            [self.scrollView addSubview:backImageView];
            
            UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            playButton.frame = CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10);
            playButton.hd_centerX = backImageView.hd_centerX;
            playButton.hd_centerY = backImageView.hd_centerY;
            [playButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
            [self.scrollView addSubview:playButton];
            [playButton addTarget:self action:@selector(playVideoAction) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
            weakSelf.editView.enabled = YES;
            [weakSelf.addView setImage:[UIImage imageNamed:@"dowork_add_grey_btn"] forState:UIControlStateNormal];
            weakSelf.addView.enabled = NO;
            [weakSelf.tableView reloadData];
        });
    } cancle:^(NSString *cancleStr) {
        ;
    }];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)playVideoAction
{
    PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    if (self.model.videoUrl.length > 0) {
        [infoDic setObject:self.model.name forKey:kpartName];
        [infoDic setObject:self.model.videoUrl forKey:@"mp4Src"];
    }else
    {
        [infoDic setObject:@"" forKey:kpartName];
        NSURL *pathUrl = [NSURL fileURLWithPath:self.model.sandBoxFilePath];
        
        [infoDic setObject:pathUrl.absoluteString forKey:@"mp4Src"];
    }
    
    playVC.infoDic = infoDic;
    
    [self presentViewController:playVC animated:NO completion:nil];
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
        [self refreshPhotoScrollView:model];
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL * url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString * urlStr = [url path];
        NSLog(@"url = %@", url);
        self.model.modelType = ProductModelType_video;
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
    if ([self isExistFolder:_folderName]) {
//        获取需要文件的localIdentifier
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
                        weakSelf.model.phAsset = asset;
                        weakSelf.model.modelType = ProductModelType_video;
                        weakSelf.createProductionType = CreatProductionType_video;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            self.scrollView.hidden = NO;
                            UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
                            backImageView.contentMode = UIViewContentModeScaleAspectFit;
                            backImageView.image = self.model.image;
                            self.scrollView.contentSize = CGSizeMake(self.scrollView.hd_width, self.scrollView.hd_height);
                            [self.scrollView addSubview:backImageView];
                            
                            UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            playButton.frame = CGRectMake(0, 0, kScreenWidth / 10, kScreenWidth / 10);
                            playButton.hd_centerX = backImageView.hd_centerX;
                            playButton.hd_centerY = backImageView.hd_centerY;
                            [playButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
                            [self.scrollView addSubview:playButton];
                            [playButton addTarget:self action:@selector(playVideoAction) forControlEvents:UIControlEventTouchUpInside];
                            
                            [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
                            weakSelf.editView.enabled = YES;
                            [weakSelf.addView setImage:[UIImage imageNamed:@"dowork_add_grey_btn"] forState:UIControlStateNormal];
                            weakSelf.addView.enabled = NO;
                            [weakSelf.tableView reloadData];
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

- (void)setFolderName:(NSString *)folderName {
    if (!_folderName) {
        _folderName = folderName;
        [self createFolder:folderName];
    }
}


#pragma mark - photo and graffiti
- (void)getPhotoLibrary
{
    __weak typeof(self)weakSelf = self;
    BLImagePickerViewController * vc = [[BLImagePickerViewController alloc]init];
    vc.maxNum = 9;
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
            [weakSelf refreshPhotoScrollView:model];
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
        imageModel.fanleImage = [weakSelf getFanalImageWithImage:image andImage:imageModel.textImage andBackRect:imageModel.backRect andRect:imageModel.tetRect];
        [weakSelf resreshImageModel:imageModel];
        [weakSelf refreshPhotoScrollView:imageModel];
    };
    
    [self presentViewController:graffitiVC animated:NO completion:nil];
}

- (void)resreshImageModel:(ImageProductModel *)model
{
    int num = 1000;
    for (int i = 0; i<self.model.imageProductArray.count; i++) {
        ImageProductModel * imageModel = self.model.imageProductArray[i];
        if ([imageModel.imageModelId isEqualToString:model.imageModelId]) {
            num = i;
            return;
        }
    }
    if (num == 1000) {
        model.imageModelId = [NSString stringWithFormat:@"%d", self.model.imageProductArray.count];
        [self.model.imageProductArray addObject:model];
    }else
    {
        [self.model.imageProductArray removeObjectAtIndex:num];
        [self.model.imageProductArray insertObject:model atIndex:num];
    }
    ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:0];
    self.model.image = imageModel.fanleImage;
    self.model.modelType = ProductModelType_photo;
    [self.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
    self.editView.enabled = YES;
    [self.tableView reloadData];
}

- (void)refreshPhotoScrollView:(ImageProductModel *)textModel
{
    int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width;
    int count = self.scrollView.contentSize.width / self.backView.hd_width;
    
    if (count < self.model.imageProductArray.count) {
        ImageProductModel * model = [self.model.imageProductArray lastObject];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.hd_width * count, 0, self.backView.hd_width, self.backView.hd_height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = model.fanleImage;
        imageView.tag = count + 1000;;
        [self.scrollImageViewArr addObject:imageView];
        [self.scrollView addSubview:imageView];
        
        self.scrollView.contentSize = CGSizeMake(self.backView.hd_width * self.scrollImageViewArr.count, self.backView.hd_height);
        [self.scrollView scrollRectToVisible:CGRectMake(count * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self refreshWithScroll:count];
        });
    }else
    {
        for (int i = 0; i < count; i++) {
            if (i == currentCount) {
                UIImageView * imageView = [self.scrollImageViewArr objectAtIndex:i];
                imageView.image = textModel.fanleImage;
            }
        }
        self.scrollView.contentSize = CGSizeMake(self.backView.hd_width * self.scrollImageViewArr.count, self.backView.hd_height);
        [self.scrollView scrollRectToVisible:CGRectMake(currentCount * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self refreshWithScroll:currentCount];
        });
    }
}


- (void)addTextAndImageOperationUI
{
    self.previousBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(5, self.backView.hd_height / 2 - self.backView.hd_height * 0.057, self.backView.hd_height * 0.08, self.backView.hd_height * 0.114);
    [self.previousBtn setImage:[UIImage imageNamed:@"page_icon_left "] forState:UIControlStateNormal];
    [self.backView addSubview:self.previousBtn];
    
    self.nextBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(self.backView.hd_width - 5 - self.backView.hd_height * 0.08, self.backView.hd_height / 2 - self.backView.hd_height * 0.057, self.backView.hd_height * 0.08, self.backView.hd_height * 0.114);
    [self.nextBtn setImage:[UIImage imageNamed:@"page_icon_right"] forState:UIControlStateNormal];
    [self.backView addSubview:self.nextBtn];
    
    
    self.addAudioBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    self.addAudioBtn.frame = CGRectMake(self.backView.hd_width * 0.22, self.backView.hd_height * 0.85, self.backView.hd_width * 0.14, self.backView.hd_height * 0.112);
    [self.addAudioBtn setImage:[UIImage imageNamed:@"icon_add_voice"] forState:UIControlStateNormal];
    [self.backView addSubview:self.addAudioBtn];
    
    self.addTextBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTextBtn.frame = CGRectMake(self.backView.hd_width * 0.43, self.backView.hd_height * 0.85, self.backView.hd_width * 0.14, self.backView.hd_height * 0.112);
    [self.addTextBtn setImage:[UIImage imageNamed:@"icon_script_describe_shallow"] forState:UIControlStateNormal];
    [self.backView addSubview:self.addTextBtn];
    
    self.addGraffitiBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    self.addGraffitiBtn.frame = CGRectMake(self.backView.hd_width * 0.64, self.backView.hd_height * 0.85, self.backView.hd_width * 0.14, self.backView.hd_height * 0.112);
    [self.addGraffitiBtn setImage:[UIImage imageNamed:@"icon_draw_board_shallow"] forState:UIControlStateNormal];
    [self.backView addSubview:self.addGraffitiBtn];
    
    self.pageControlLB = [[PageControlLB alloc]initWithFrame:CGRectMake(self.backView.hd_width * 0.89, self.backView.hd_height * 0.895, self.backView.hd_width * 0.086, self.backView.hd_height * 0.07)];
    [self.backView addSubview:self.pageControlLB];
    
    self.previousBtn.hidden = YES;
    self.nextBtn.hidden = YES;
    self.addAudioBtn.hidden = YES;
    self.addTextBtn.hidden = YES;
    self.addGraffitiBtn.hidden = YES;
    self.pageControlLB.hidden = YES;
    
    [self.previousBtn addTarget:self action:@selector(previousAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.addAudioBtn addTarget:self action:@selector(addAudioAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.addTextBtn addTarget:self action:@selector(addTextAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.addGraffitiBtn addTarget:self action:@selector(addGraffitiAction ) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)previousAction
{
    if (self.selectIndexPath.row - 1 < 0) {
        return;
    }
    [self.scrollView scrollRectToVisible:CGRectMake((self.selectIndexPath.row - 1) * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self refreshWithScroll:(self.selectIndexPath.row - 1)];
    });
}

- (void)nextAction
{
    int count = 0;
    if (self.createProductionType == CreatProductionType_text) {
        count = self.model.textProductArray.count;
    }else if (self.createProductionType == CreatProductionType_photo)
    {
        count = self.model.imageProductArray.count;
    }
    
    if (self.selectIndexPath.row + 1 > count) {
        return;
    }
    [self.scrollView scrollRectToVisible:CGRectMake((self.selectIndexPath.row + 1) * self.backView.hd_width, 0, self.backView.hd_width, self.backView.hd_height) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self refreshWithScroll:(self.selectIndexPath.row + 1)];
    });
}

- (void)addAudioAction
{
    ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:self.selectIndexPath.row];
    if (imageModel.musicPath || imageModel.audioUrl) {
        [self.addAudioBtn setImage:[UIImage imageNamed:@"icon_add_voice"] forState:UIControlStateNormal];
        imageModel.audioUrl = nil;
        imageModel.musicPath = nil;
        [self resreshImageModel:imageModel];
        [self refreshPhotoScrollView:imageModel];
        
    }else
    {
        [self refreshAudioUI:imageModel];
    }
}

#pragma mark - 添加文字
- (void)addTextAction
{
    if (self.createProductionType == CreatProductionType_text) {
        // 文字模型，修改文字
        TextProductModel * model = self.model.textProductArray[self.selectIndexPath.row];
        [self textAction:model];
    }else
    {
        // 图片模型上添加文字
        ImageProductModel * model = self.model.imageProductArray[self.selectIndexPath.row];
        [self textImageAction:model];
    }
}

- (void)textImageAction:(ImageProductModel * )model
{
    __weak typeof(self)weakSelf = self;
    ImageProductModel * imageModel = [[ImageProductModel alloc]init];
    
    if (model) {
        imageModel = model;
        if (!imageModel.colorStr) {
            imageModel.colorStr = kBlack;
        }
    }
    
    ProductPatternSelectView * view = [[ProductPatternSelectView alloc]initWithFrame:self.view.bounds withText:imageModel.text];
    [view resetTextColor:model.colorStr];
    __weak typeof(view)weakView = view;
    view.textBlock = ^(NSDictionary *infoDic) {
        imageModel.text = [infoDic objectForKey:@"title"];
        imageModel.colorStr = [infoDic objectForKey:kcolorStr];
        [weakSelf textImagePointAction:infoDic andModel:imageModel];
        [weakView dismiss];
    };
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
}

- (void)textImagePointAction:(NSDictionary *)infoDic andModel:(ImageProductModel *)model
{
    __weak typeof(self)weakSelf = self;
    TextPositionView * textView = [[TextPositionView alloc]initWithFrame:self.view.bounds andText:[infoDic objectForKey:@"title"] andColor:[infoDic objectForKey:kcolorStr] andImage:model.originImage];
    __weak typeof(textView)weakView = textView;
    
    textView.textPositionRectBlock = ^(CGRect positionRect,CGRect imageRect, NSDictionary *infoaDic, UIImage *image) {
        model.text = [infoaDic objectForKey:@"title"];
        model.textImage = image;
        model.colorStr = [infoaDic objectForKey:kcolorStr];
        model.tetRect = positionRect;
        model.backRect = imageRect;
        model.textTop = positionRect.origin.y * 100 / imageRect.size.height;
        model.textLeft = positionRect.origin.x * 100 / imageRect.size.width;
//        model.fanleImage = image;
        model.fanleImage = [weakSelf getFanalImageWithImage:model.originImage andImage:image andBackRect:imageRect andRect:positionRect];
        [weakSelf refreshPhotoScrollView:model];
        [weakView cancelAction];
    };
    
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:textView];
}

- (UIImage *)getFanalImageWithImage:(UIImage *)img andImage:(UIImage *)logo andBackRect:(CGRect)backRect andRect:(CGRect)rect
{
    if (logo == nil) {
        return img;
    }
    
    int w = backRect.size.width * 2;
    int h = backRect.size.height * 2;
    int logoWidth = rect.size.width * 2;
    int logoHeight = rect.size.height * 2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(rect.origin.x * 2, h - rect.origin.y * 2 - logoHeight, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

- (void)addGraffitiAction
{
    ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:self.selectIndexPath.row];
    [self graffiti:imageModel];
}

#pragma mark - audio
- (void)addAudioUI
{
    self.playAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = self.backView.hd_width;
    CGFloat height = self.backView.hd_height;
    
    self.playAudioBtn.frame = CGRectMake(width * 0.033, width * 0.033, width * 0.066, width * 0.066);
    [self.playAudioBtn setImage:[UIImage imageNamed:@"play_btn_three"] forState:UIControlStateNormal];
    [self.backView addSubview:self.playAudioBtn];
    self.playAudioBtn.hidden = YES;
    
    self.audioLenthLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.playAudioBtn.frame) + 6, self.playAudioBtn.hd_centerY, 100, width * 0.033)];
    self.audioLenthLB.textColor = UIColorFromRGB(0xFF944D);
    self.audioLenthLB.font = kMainFont;
    self.audioLenthLB.text = @"3”";
    [self.backView addSubview:self.audioLenthLB];
    self.audioLenthLB.hidden = YES;
    
    self.reRecoardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reRecoardBtn.frame = CGRectMake(width * 0.43, self.backView.hd_height* 0.85 , width * 0.14, height * 0.11);
    [self.reRecoardBtn setImage:[UIImage imageNamed:@"icon_reset_voice"] forState:UIControlStateNormal];
    [self.backView addSubview:self.reRecoardBtn];
    self.reRecoardBtn.hidden = YES;
    
    [self.playAudioBtn addTarget:self action:@selector(playAudioAction) forControlEvents:UIControlEventTouchUpInside];
    [self.reRecoardBtn addTarget:self action:@selector(reRecoardAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)refreshAudioUI:(ImageProductModel *)model
{
    __weak typeof(self)weakSelf = self;
    if (nil == model) {
        self.model.image = [UIImage imageNamed:@"type_frequency_bg"];
        [self.tableView reloadData];
        
        [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
        weakSelf.editView.enabled = YES;
        [weakSelf.addView setImage:[UIImage imageNamed:@"dowork_add_grey_btn"] forState:UIControlStateNormal];
        weakSelf.addView.enabled = NO;
        
        self.scrollView.hidden = NO;
        UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
        backImageView.image = [UIImage imageNamed:@"type_frequency_bg"];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.hd_width, self.scrollView.hd_height);
        [self.scrollView addSubview:backImageView];
        
        self.recoardAnimatView = [[RecordAnimationView alloc]initWithFrame:self.view.bounds];
        [self.recoardAnimatView show];
        self.recoardAnimatView.cancelRecoardBlock = ^{
            
            [weakSelf hideAudio];
            
            [weakSelf.editView setImage:[UIImage imageNamed:@"dowork_edit_btn"] forState:UIControlStateNormal];
            weakSelf.editView.enabled = NO;
            [weakSelf.addView setImage:[UIImage imageNamed:@"dowork_add_btn"] forState:UIControlStateNormal];
            weakSelf.addView.enabled = YES;
            
            weakSelf.model.image = nil;
            [weakSelf.recoardAnimatView removeFromSuperview];
            [weakSelf.tableView reloadData];
            [backImageView removeFromSuperview];
            weakSelf.scrollView.hidden = YES;
        };
        self.recoardAnimatView.ComplateRecoardBlock = ^(int time){
            weakSelf.model.musicPath = [RecordTool sharedInstance].savePath;
            weakSelf.model.modelType = ProductModelType_music;
            weakSelf.reRecoardBtn.hidden = NO;
            weakSelf.playAudioBtn.hidden = NO;
            weakSelf.audioLenthLB.hidden = NO;
            weakSelf.audioLenthLB.text = [NSString stringWithFormat:@"%d\"", (int )time];
            [weakSelf.recoardAnimatView removeFromSuperview];
        };
    }else
    {
        self.recoardAnimatView = [[RecordAnimationView alloc]initWithFrame:self.view.bounds];
        [self.recoardAnimatView show];
        self.recoardAnimatView.cancelRecoardBlock = ^{
            [weakSelf.recoardAnimatView dismiss];
        };
        self.recoardAnimatView.ComplateRecoardBlock = ^(int time){
            model.audioUrl = nil;
            model.musicPath = [RecordTool sharedInstance].savePath;
            weakSelf.audioLenthLB.text = [NSString stringWithFormat:@"%d\"", (int )time];
            
            [weakSelf resreshImageModel:model];
            [weakSelf refreshPhotoScrollView:model];
            
            [weakSelf.recoardAnimatView removeFromSuperview];
        };
    }
}

- (void)playAudioAction
{
    
    if (self.model.modelType == ProductModelType_music) {
        if (self.model.audioUrl.length > 0) {
            if ([BTVoicePlayer share].isPlaying) {
                [[BTVoicePlayer share] stop];
            }else
            {
                [[BTVoicePlayer share] playLine:self.model.audioUrl];
            }
            return;
        }
        
        
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
        }else
        {
//            if (self.createProductionType == CreatProductionType_photo) {
//                ImageProductModel * model = [self.model.imageProductArray objectAtIndex:self.selectIndexPath.row];
//                [[BTVoicePlayer share] play:model.musicPath];
//            }else
//            {
//            }
            [[BTVoicePlayer share] play:self.model.musicPath];
        }
    }else
    {
        int currentCount = self.scrollView.contentOffset.x / self.backView.hd_width ;
        ImageProductModel * imageModel = [self.model.imageProductArray objectAtIndex:currentCount];
        
        if (imageModel.audioUrl.length > 0) {
            if ([BTVoicePlayer share].isPlaying) {
                [[BTVoicePlayer share] stop];
            }else
            {
                [[BTVoicePlayer share] playLine:imageModel.audioUrl];
            }
            return;
        }
        
        
        if ([BTVoicePlayer share].isLocalPlaying) {
            [[BTVoicePlayer share] localstop];
        }else
        {
            ImageProductModel * model = [self.model.imageProductArray objectAtIndex:self.selectIndexPath.row];
            [[BTVoicePlayer share] play:model.musicPath];
            
        }
        
    }
    
}

- (void)reRecoardAction
{
    __weak typeof(self)weakSelf = self;
    self.recoardAnimatView = [[RecordAnimationView alloc]initWithFrame:self.view.bounds];
    [self.recoardAnimatView show];
    [self.recoardAnimatView startAnimation];
    self.recoardAnimatView.cancelRecoardBlock = ^{
        [weakSelf.recoardAnimatView removeFromSuperview];
    };
    self.recoardAnimatView.ComplateRecoardBlock = ^(int time){
        
        weakSelf.model.audioUrl = nil;
        weakSelf.model.musicPath = [RecordTool sharedInstance].savePath;
        
        weakSelf.reRecoardBtn.hidden = NO;
        weakSelf.playAudioBtn.hidden = NO;
        weakSelf.audioLenthLB.hidden = NO;
        weakSelf.audioLenthLB.text = [NSString stringWithFormat:@"%d\"", (int )time];
        [weakSelf.recoardAnimatView removeFromSuperview];
    };
}

- (void)hideAudio
{
    [self.scrollImageViewArr removeAllObjects];
    self.scrollView.contentSize = CGSizeMake(0, self.backView.hd_height);
    self.selectIndexPath = nil;
    [self.scrollView removeAllSubviews];
    self.scrollView.hidden = YES;
    self.playAudioBtn.hidden = YES;
    self.reRecoardBtn.hidden = YES;
    self.audioLenthLB.hidden = YES;
    
    self.previousBtn.hidden = YES;
    self.nextBtn.hidden = YES;
    self.addAudioBtn.hidden = YES;
    self.addTextBtn.hidden = YES;
    self.addGraffitiBtn.hidden = YES;
    self.pageControlLB.hidden = YES;
}

#pragma mark - sava product
- (void)savaProductAction
{
    
    
    
    if (self.model.image == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先创作作品"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_tf andTitle:self.model.name withAnimation:NO];
    __weak typeof(toolView)weakToolView = toolView;
    [self.view addSubview:toolView];
    toolView.TextBlock = ^(NSString *text) {
        if (text.length == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
        weakSelf.model.name = text;
        [weakSelf submitProduct:weakSelf.model];
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        [weakToolView removeFromSuperview];
    };
    
}

- (void)submitProduct:(ProductionModel *)model
{
    
    switch (model.modelType) {
        case ProductModelType_text:
            {
                [self submitTextProduct:model];
            }
            break;
        case ProductModelType_music:
        {
            [self submitRecordProduct:model];
        }
            break;
        case ProductModelType_photo:
        {
            [self submitPhotoProduct:model];
        }
            break;
        case ProductModelType_video:
        {
            [self submitVideoModel:model];
        }
            break;
        default:
            break;
    }
}

- (void)submitPhotoProduct:(ProductionModel *)model
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    // 上传音频
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        // 有录音数组
        NSMutableArray *pageRecordArray = [NSMutableArray array];
        NSMutableArray * recordArray = [NSMutableArray array];
        for (int i = 0; i < model.imageProductArray.count; i++) {
            ImageProductModel * imageModel = model.imageProductArray[i];
            if (imageModel.musicPath && imageModel.musicPath.length > 0) {
                HDPicModle * picModel = [[HDPicModle alloc]init];
                picModel.picName = [NSString stringWithFormat:@"%d", i];
                picModel.url = imageModel.musicPath;
                [pageRecordArray addObject:picModel];
                [recordArray addObject:imageModel];
            }
            
        }
        
        [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andMP3Array:pageRecordArray progress:^(NSProgress * _Nullable progress) {
            //            [SVProgressHUD showProgress:(progress.completedUnitCount / progress.totalUnitCount)];
        } success:^(id  _Nonnull responseObject) {
            //            [SVProgressHUD dismiss];
            
            NSLog(@"[responseObject class] = %@", [responseObject class]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"record  jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    
#pragma mark - 音频上传完成处理
                    NSArray * urlArray = [jsonStr componentsSeparatedByString:@";"];
                    for (int i = 0; i < urlArray.count; i++) {
                        NSLog(@"record url = %@", urlArray[i]);
                        ImageProductModel * textModel = recordArray[i];
                        textModel.audioUrl = urlArray[i];
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
    
    
    // 上传原图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        // 原图
        NSMutableArray *originImageArray = [NSMutableArray array];
        for (int i = 0; i < model.imageProductArray.count; i++) {
            ImageProductModel * imageModel = model.imageProductArray[i];
            
            HDPicModle * picModel = [[HDPicModle alloc]init];
            picModel.picName = [NSString stringWithFormat:@"yuan%d", i];
            picModel.pic = imageModel.originImage;
            [originImageArray addObject:picModel];
            
        }
        
        [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andPicArray:originImageArray progress:^(NSProgress * _Nullable progress) {
//            [SVProgressHUD showProgress:(progress.completedUnitCount / progress.totalUnitCount)];
        } success:^(id  _Nonnull responseObject) {
//            [SVProgressHUD dismiss];
            
            NSLog(@"[responseObject class] = %@", [responseObject class]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"originImage jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    
                    NSArray * urlArray = [jsonStr componentsSeparatedByString:@";"];
                    for (int i = 0; i < urlArray.count; i++) {
                        NSLog(@"originImage url = %@", urlArray[i]);
#pragma mark - 原图上传完毕处理
                        ImageProductModel * textModel = model.imageProductArray[i];
                        textModel.originImageUrl = urlArray[i];
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
    
    // 上传背景图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        // finalImage图
        NSMutableArray *finalImageArray = [NSMutableArray array];
        for (int i = 0; i < model.imageProductArray.count; i++) {
            ImageProductModel * imageModel = model.imageProductArray[i];
            HDPicModle * picModel = [[HDPicModle alloc]init];
            picModel.picName = [NSString stringWithFormat:@"beijing%d", i];
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
#pragma mark - 背景图上传完毕处理
                        ImageProductModel * textModel = model.imageProductArray[i];
                        textModel.fanleImageUrl = urlArray[i];
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
    
    // 上传封面图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = model.name;
        picModel.pic = model.image;
        
        NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);
        
        [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(id  _Nonnull responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    model.imageUrl = jsonStr;
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
            

            NSMutableArray * fileList = [NSMutableArray array];
            for (int i = 0; i < model.imageProductArray.count; i++) {
                ImageProductModel * imageModel = model.imageProductArray[i];
                NSDictionary * textDic = [NSDictionary dictionary];
                NSDictionary * imageDic = [NSDictionary dictionary];
                NSDictionary * recordDic = [NSDictionary dictionary];
                
                if (imageModel.text && imageModel.text.length > 0) {
                    textDic = @{kfileType:@(1),kfileContent:imageModel.text,kfileSort:@(i+1),ktextColor:imageModel.colorStr, ktextLeft:@((int)imageModel.textLeft),ktextTop:@((int)imageModel.textTop),kgroupIcon:imageModel.fanleImageUrl};
                }
                imageDic = @{kfileType:@(2),kfileContent:imageModel.originImageUrl,kfileSort:@(i+1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:imageModel.fanleImageUrl};
                if (imageModel.musicPath && imageModel.musicPath.length > 0) {
                    recordDic = @{kfileType:@(3),kfileContent:imageModel.audioUrl,kfileSort:@(i+1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:imageModel.fanleImageUrl};
                }else if (imageModel.audioUrl && imageModel.audioUrl.length > 0)
                {
                    NSString * audioUrl = [[imageModel.audioUrl componentsSeparatedByString:@".com"] lastObject];
                    recordDic = @{kfileType:@(3),kfileContent:audioUrl,kfileSort:@(i+1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:imageModel.fanleImageUrl};
                }
                
                [fileList addObject:imageDic];
                if ([textDic objectForKey:kfileContent]) {
                    [fileList addObject:textDic];
                }
                if ([recordDic objectForKey:kfileContent]) {
                    [fileList addObject:recordDic];
                }
            }
            
            for (NSDictionary * infoDicq in fileList) {
                NSLog(@"\n******%@\n", infoDicq);
            }
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId),@"type":@(4),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":fileList} withNotifiedObject:self];
        });
    });
}

- (void)submitTextProduct:(ProductionModel *)model
{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    // 上传写作
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        NSMutableArray *pageRecordArray = [NSMutableArray array];
        
        for (int i = 0; i < model.textProductArray.count; i++) {
            TextProductModel * textModel = model.textProductArray[i];
            
            HDPicModle * picModel = [[HDPicModle alloc]init];
            picModel.picName = [NSString stringWithFormat:@"%@", textModel.text];
            picModel.pic = textModel.textImage;
            [pageRecordArray addObject:picModel];
        }
        
        [[HDNetworking sharedHDNetworking] POST:@"url" parameters:@{} andPicArray:pageRecordArray progress:^(NSProgress * _Nullable progress) {
            [SVProgressHUD showProgress:progress.fractionCompleted];
        } success:^(id  _Nonnull responseObject) {
            [SVProgressHUD dismiss];
            
            NSLog(@"[responseObject class] = %@", [responseObject class]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    
                    NSArray * urlArray = [jsonStr componentsSeparatedByString:@";"];
                    for (int i = 0; i < urlArray.count; i++) {
                        NSLog(@"url = %@", urlArray[i]);
                        TextProductModel * textModel = model.textProductArray[i];
                        textModel.textImageUrl = urlArray[i];
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
    
    // 上传封面图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = model.name;
        picModel.pic = model.image;
        
        NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);
        
        [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(id  _Nonnull responseObject) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    model.imageUrl = jsonStr;
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
            
            NSMutableArray * fileList = [NSMutableArray array];
            for (int i = 0; i < model.textProductArray.count; i++) {
                TextProductModel * textModel = model.textProductArray[i];
                NSDictionary * textDic = @{kfileType:@(1),kfileContent:textModel.text,kfileSort:@(i+1),ktextColor:textModel.colorStr, ktextLeft:@0,ktextTop:@0,kgroupIcon:textModel.textImageUrl};
                NSDictionary * imageDic = @{kfileType:@(2),kfileContent:textModel.textImageUrl,kfileSort:@(i+1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:textModel.textImageUrl};
                [fileList addObject:textDic];
                [fileList addObject:imageDic];
            }
            
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId),@"type":@(2),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":fileList} withNotifiedObject:self];
        });
    });
    
}

- (void)submitRecordProduct:(ProductionModel*)model
{
    if (self.model.audioUrl.length > 0) {
        [SVProgressHUD show];
        
        NSString * audioUrl = [[model.audioUrl componentsSeparatedByString:@".com"] lastObject];
        
        [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId), @"type":@(1),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":@[@{kfileType:@(3),kfileContent:audioUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl},@{kfileType:@(2),kfileContent:model.imageUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl}]} withNotifiedObject:self];
        return;
    }
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    // 上传音频
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        NSMutableArray *pageRecordArray = [NSMutableArray array];
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = [NSString stringWithFormat:@"%@", model.name];
        picModel.url = model.musicPath;
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
                    model.audioUrl = jsonStr;
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
    
    // 上传封面图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = model.name;
        picModel.pic = model.image;
        
        NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);
        
        [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(id  _Nonnull responseObject) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    model.imageUrl = jsonStr;
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
            [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId), @"type":@(1),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":@[@{kfileType:@(3),kfileContent:model.audioUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl},@{kfileType:@(2),kfileContent:model.imageUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl}]} withNotifiedObject:self];
        });
    });
}

- (void)submitVideoModel:(ProductionModel *)model
{
    if (model.videoUrl.length > 0) {
        [SVProgressHUD show];
        NSString * videoUrl = [[model.videoUrl componentsSeparatedByString:@".com"] lastObject];
        [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId),@"type":@(3),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":@[@{kfileType:@(4),kfileContent:videoUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl},@{kfileType:@(2),kfileContent:model.imageUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl}]} withNotifiedObject:self];
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("cn.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    // 上传视频
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = model.name;
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
                    model.videoUrl = jsonStr;
                }else
                {
                    jsonStr = @"";
                }
                
                dispatch_group_leave(group);
            });
            
        } failure:^(NSError * _Nonnull error) {
            ;[SVProgressHUD dismiss];
            dispatch_async(dispatch_get_main_queue(), ^{
                model.videoUrl = @"";
                dispatch_group_leave(group);
            });
        }];
        
    });
    
    // 上传封面图
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        HDPicModle * picModel = [[HDPicModle alloc]init];
        picModel.picName = model.name;
        picModel.pic = model.image;

        NSLog(@"model.sandBoxFilePath = %@", model.sandBoxFilePath);

        [[HDNetworking sharedHDNetworking] POST:@"" parameters:@{} andPic:picModel progress:^(NSProgress * _Nullable progress) {
            ;
        } success:^(id  _Nonnull responseObject) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"jsonStr = %@", jsonStr);
                if (![jsonStr isKindOfClass:[NSNull class]] && jsonStr.length > 0) {
                    model.imageUrl = jsonStr;
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
            [[UserManager sharedManager] didRequestSubmitCreateProductWithWithDic:@{kProductId:@(self.productId),@"type":@(3),kProductName:model.name, kProductIcon:model.imageUrl,kuserWorkId:@(model.userWorkId),@"fileList":@[@{kfileType:@(4),kfileContent:model.videoUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl},@{kfileType:@(2),kfileContent:model.imageUrl,kfileSort:@(1),ktextColor:@"", ktextLeft:@0,ktextTop:@0,kgroupIcon:model.imageUrl}]} withNotifiedObject:self];
        });
    });
}

- (void)didRequestSubmitCreateProductSuccessed
{
    [SVProgressHUD dismiss];
    
    if (self.productId > 0) {
        if (self.modifyProductSuccessBlock) {
            self.modifyProductSuccessBlock(YES);
        }
    }
    
    if (self.userWorkId > 0) {
        if (self.ComplateTaskSuccessBlock) {
            self.ComplateTaskSuccessBlock(YES);
        }
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didRequestSubmitCreateProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
