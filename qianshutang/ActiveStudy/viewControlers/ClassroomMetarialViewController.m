//
//  ClassroomMetarialViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomMetarialViewController.h"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "TextbookDetailViewController.h"
#import "LearnTextViewController.h"
#import "PlayVideoViewController.h"


@interface ClassroomMetarialViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyClassroom_classTextbook, MyClassroom_classCourseWare, ActiveStudy_TextBookContentList,ActiveStudy_TextContent, ActiveStudy_CollectTextBook>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;
@property (nonatomic, strong)HYSegmentedControl *  metarialHySegmentControl;
@property (nonatomic, assign)teacherCollectionCellType collectionCellType;

@property (nonatomic, strong)NSDictionary * currentInfoDic;// 当前选中收藏课本
@property (nonatomic, strong)ToolTipView * recordShotTipView;// 收藏提示

@property (nonatomic, strong)NSDictionary * currentTextBookInfo; // 当前选中课本
@property (nonatomic, strong)NSDictionary * currentCourseWareInfo;
@property (nonatomic, assign)LearnTextType  learntextType;
@property (nonatomic, strong)NSMutableArray * textBookSelectArray;
@property (nonatomic, assign)BOOL isCollect;

@end

@implementation ClassroomMetarialViewController
- (NSMutableArray *)textBookSelectArray
{
    if (!_textBookSelectArray) {
        _textBookSelectArray = [NSMutableArray array];
    }
    return _textBookSelectArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[BTVoicePlayer share] isHavePlayerItem]) {
        [[BTVoicePlayer share] stop];
    }
    if ([BTVoicePlayer share].isHaveLocalPlayerItem) {
        [[BTVoicePlayer share] localstop];
    }
    
    [self loadData];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_searchAndCollect];
    [self.navigationView hideSearchBtn];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.collectCourseBlock = ^{
        if (weakSelf.isCollect) {
            weakSelf.isCollect = NO;
        }else
        {
            weakSelf.isCollect = YES;
        }
        [weakSelf.collectionView reloadData];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.metarialHySegmentControl = [[HYSegmentedControl alloc]initWithOriginX:kScreenWidth * 0.2 OriginY:0 Titles:@[@"课本",@"课件"] delegate:self];
    [self.metarialHySegmentControl hideBottomView];
    [self.metarialHySegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.metarialHySegmentControl];
    self.metarialHySegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if ([segmentControl isEqual:weakSelf.metarialHySegmentControl]) {
            if (weakSelf.metarialHySegmentControl.selectIndex == 0) {
                [weakSelf.navigationView showCollectBtn];
                weakSelf.collectionCellType = collectionCellType_textbook;
                weakSelf.currentCourseWareInfo = nil;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[weakSelf.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
            }else
            {
                [weakSelf.navigationView hideCollectBtn];
                weakSelf.collectionCellType = collectionCellType_courseware;
                weakSelf.currentTextBookInfo = nil;
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestClassCourseWareWithWithDic:@{kClassroomId:[weakSelf.infoDic objectForKey:kClassroomId]} withNotifiedObject:weakSelf];
            }
            [weakSelf.collectionView reloadData];
        }
    };
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TeachingMaterailCollectionViewCell class] forCellWithReuseIdentifier:kTeachingMaterailCellID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    
    if (self.collectionCellType == collectionCellType_textbook) {
        [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
        
        if (self.isCollect) {
            BOOL isHaveInfo = [self isHaveInfoDic:self.collectionDataArray[indexPath.item]];
            if (isHaveInfo) {
                [cell haveCollect];
            }else
            {
                [cell selectReset];
            }
        }
        
    }else
    {
        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
            cell.isTeacherExplain = YES;
        }
        [cell resetCCoursewareWithInfoDic:self.collectionDataArray[indexPath.row]];
        __weak typeof(self)weakSelf = self;
        cell.readTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_read;
            [SVProgressHUD show];
            weakSelf.currentCourseWareInfo = infoDic;
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:weakSelf];
            
        };
        cell.recordTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_record;
            [SVProgressHUD show];
            weakSelf.currentCourseWareInfo = infoDic;
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:weakSelf];
        };
        cell.videoBlock = ^(NSDictionary *infoDic) {
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            
            NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
            [mInfo setObject:[infoDic objectForKey:@"coursewareName"] forKey:kpartName];
            playVC.infoDic = mInfo;
            [weakSelf presentViewController:playVC animated:NO completion:nil];
        };
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionCellType == collectionCellType_textbook) {
        return CGSizeMake(kScreenWidth / 5 - 0.5, kScreenWidth / 5  + 15);
    }else if (self.collectionCellType == collectionCellType_courseware )
    {
        return CGSizeMake(kScreenWidth / 5  - 0.5, kScreenWidth / 5  + 65);
    }
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = self.collectionDataArray[indexPath.row];
    if (self.collectionCellType == collectionCellType_textbook) {
        self.currentInfoDic = infoDic;
        if (self.isCollect) {
            BOOL isHaveInfo = [self isHaveInfoDic:infoDic];
            if (isHaveInfo) {
                
                [SVProgressHUD showInfoWithStatus:@"已收藏"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else
            {
                __weak typeof(self)weakSelf = self;
                self.recordShotTipView = [[ToolTipView alloc] initWithFrame:self.view.bounds andType:ToolTipTye_shareToSchoolLibrary andTitle:@"收藏课本" withAnimation:YES];
                [self.recordShotTipView resetContentLbTetx:[NSString stringWithFormat:@"将%@加入我的收藏?", [infoDic objectForKey:kTextBookName]]];
                [self.view addSubview:self.recordShotTipView];
                self.recordShotTipView.DismissBlock = ^{
                    [weakSelf.recordShotTipView removeFromSuperview];
                };
                self.recordShotTipView.ContinueBlock = ^(NSString *str) {
                    [weakSelf.recordShotTipView removeFromSuperview];
                    weakSelf.recordShotTipView = nil;
                    [SVProgressHUD show];
                    [[UserManager sharedManager] didRequestCollectTextBookWithWithDic:@{kitemId:[infoDic objectForKey:kTextBookId], kitemType:@(1)} withNotifiedObject:weakSelf];
                };
                
            }
            [collectionView reloadData];
            
            return;
        }
        
        
        self.currentTextBookInfo = infoDic;
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:kTextBookId]} withNotifiedObject:self];
        
    }else
    {
        self.currentCourseWareInfo = infoDic;
        if ([[infoDic objectForKey:@"coursewareType"] intValue] == 5) {
            // 课文单独处理
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:self];
            self.learntextType = LearnTextType_read;
            
        }else
        {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextBookContentListWithWithDic:@{kTextBookId:[infoDic objectForKey:@"coursewareId"]} withNotifiedObject:self];
        }
    }
}

- (BOOL)isHaveInfoDic:(NSDictionary *)infoDIc
{
    BOOL isHaveInfo = NO;
    for (NSDictionary * selectInfo in self.textBookSelectArray) {
        if ([[infoDIc objectForKey:kTextBookId]isEqual:[selectInfo objectForKey:kTextBookId]]) {
            isHaveInfo = YES;
        }
    }
    if (isHaveInfo) {
        return YES;
    }else
    {
        return NO;
    }
}
#pragma mark = collect
- (void)didRequestCollectTextBookSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    [self.textBookSelectArray addObject:self.currentInfoDic];
    [self.collectionView reloadData];
}

- (void)didRequestCollectTextBookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - requestData
- (void)didRequestTextContentSuccessed
{
    NSMutableDictionary * mInfoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentCourseWareInfo];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareId"] forKey:kpartId];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareName"] forKey:kpartName];
    [mInfoDic setObject:[self.currentCourseWareInfo objectForKey:@"bookId"] forKey:kitemId];
    
    
    // 阅读课文或听录音，先缓存课文
    NSArray * mp3UrlList = [mInfoDic objectForKey:@"mp3List"];
    for (int j = 0 ; j < mp3UrlList.count; j++) {
        NSString * mp3Str = [mp3UrlList objectAtIndex:j];
        
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //设置保存路径和生成文件名
        NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [mInfoDic objectForKey:kpartName], j];
        //保存
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [SVProgressHUD dismiss];
            // 已下载 存储路径
            [self saveDownloadAudio:mInfoDic andNumber:j];
            
        }else
        {
            // 未下载。先下载，再存储路径
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
            if ([audioData writeToFile:filePath atomically:YES]) {
                NSLog(@"succeed");
                
                [self saveDownloadAudio:mInfoDic andNumber:j];
                
            }else{
                NSLog(@"faild");
            }
            
        }
        
    }
    
    [SVProgressHUD dismiss];
    
    LearnTextViewController * vc = [[LearnTextViewController alloc]init];
    vc.infoDic = mInfoDic;
    vc.learntextType = self.learntextType;
    [self presentViewController:vc  animated:NO completion:nil];
}

- (void)saveDownloadAudio:(NSDictionary *)infoDic andNumber:(int )j
{
    NSMutableDictionary * audioDic = [NSMutableDictionary dictionary];
    [audioDic setObject:[infoDic objectForKey:kpartName] forKey:kAudioName];
    [audioDic setObject:[NSString stringWithFormat:@"%@-%d", [infoDic objectForKey:kpartName],j] forKey:kAudioId];
    [audioDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioDic setObject:@(j) forKey:@"number"];
    [[DBManager sharedManager] saveDownloadAudioInfo:audioDic];
    
    NSMutableDictionary * audioListDic = [NSMutableDictionary dictionary];
    [audioListDic setObject:[infoDic objectForKey:kpartName] forKey:kpartName];
    [audioListDic setObject:[NSString stringWithFormat:@"%@", [infoDic objectForKey:kpartId]] forKey:kpartId];
    [audioListDic setObject:[NSString stringWithFormat:@"%d", [[UserManager sharedManager] getUserId]] forKey:kUserId];
    [audioListDic setObject:@(DownloadAudioType_read) forKey:@"type"];
    [[DBManager sharedManager] saveDownloadAudioListInfo:audioListDic];
}

- (void)didRequestTextContentFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTextBookContentListSuccessed
{
    [SVProgressHUD dismiss];
    TextbookDetailViewController * vc = [[TextbookDetailViewController alloc]init];
    
    if (self.currentTextBookInfo) {
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentTextBookInfo];
        [infoDic setObject:[self.currentTextBookInfo objectForKey:kTextBookId] forKey:kitemId];
        vc.infoDic = infoDic;
    }else
    {
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.currentCourseWareInfo];
        [infoDic setObject:[self.currentCourseWareInfo objectForKey:@"coursewareType"] forKey:kitemType];
        [infoDic setObject:[self.currentCourseWareInfo objectForKey:@"bookId"] forKey:kitemId];
        vc.infoDic = infoDic;
    }
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestTextBookContentListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
}

- (void)didRequestclassTextbookSuccessed
{
    [SVProgressHUD dismiss];
    self.collectionDataArray = [[[UserManager sharedManager] getClassTextbookArray] mutableCopy];
    [self.collectionView reloadData];
}

- (void)didRequestclassTextbookFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestclassCourseWareSuccessed
{
    [SVProgressHUD dismiss];
    self.collectionDataArray = [[[UserManager sharedManager] getClassCourseWareArray] mutableCopy];
    [self.collectionView reloadData];
}

- (void)didRequestclassCourseWareFailed:(NSString *)failedInfo
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
