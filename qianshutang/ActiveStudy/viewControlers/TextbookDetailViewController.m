//
//  TextbookDetailViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/14.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TextbookDetailViewController.h"

#import "TextbookMetarialCollectionViewCell.h"
#define kTextbokDetailCellID @"TextbokDetailCell"
#import "LearnTextViewController.h"
#import "PlayVideoViewController.h"
#import "PlayAudioViewController.h"

@interface TextbookDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ActiveStudy_TextContent>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)UIView * bottomView;
@property (nonatomic, strong)UICollectionView * bottomCollectionView;
@property (nonatomic, strong)NSMutableArray * bottomCollectionViewArray;
@property (nonatomic, strong)NSIndexPath * bottomIndexpath;

@property (nonatomic, strong)NSNumber * lastRecordId;
@property (nonatomic, strong)NSIndexPath * lastIndexPath;

@property (nonatomic, strong)UITableView * searchTextTableView;
@property (nonatomic, strong)NSMutableArray * searchTextArray;
@property (nonatomic, strong)ToolTipView * toolView;
@property (nonatomic, strong)NSIndexPath * searchIndexPath;
@property (nonatomic, assign)LearnTextType  learntextType;

@property (nonatomic, strong)NSDictionary * currentSelectTextInfo;

@end

@implementation TextbookDetailViewController

- (NSMutableArray *)searchTextArray
{
    if (!_searchTextArray) {
        _searchTextArray = [NSMutableArray array];
    }
    return _searchTextArray;
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
    
    self.view.backgroundColor = UIRGBColor(239, 239, 239);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_search];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.searchBlock = ^(BOOL isSearch){
        [weakSelf searchMember];
    };
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = [self.infoDic objectForKey:kitemName];
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 4 - 0.5, kScreenHeight * 0.61);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + kScreenHeight * 0.03, kScreenWidth, kScreenHeight * 0.61) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    [self.collectionView registerClass:[TextbookMetarialCollectionViewCell class] forCellWithReuseIdentifier:kTextbokDetailCellID];
    self.collectionView.contentSize = CGSizeMake(kScreenWidth / 4 * self.dataArray.count, kScreenHeight * 0.61);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.81, kScreenWidth, kScreenHeight * 0.19)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIBezierPath * bottomPath = [UIBezierPath bezierPath];
    [bottomPath moveToPoint:CGPointMake(0, 30)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth / 2 - kScreenWidth / 10 - 8, 30)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth / 2 - kScreenWidth / 10, 0)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth / 2 + kScreenWidth / 10, 0)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth / 2 + kScreenWidth / 10 + 8, 30)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth, 30)];
    [bottomPath addLineToPoint:CGPointMake(kScreenWidth, kScreenHeight * 0.19)];
    [bottomPath addLineToPoint:CGPointMake(0, kScreenHeight * 0.19)];
    [bottomPath stroke];
    
    CAShapeLayer * bottomLayer = [[CAShapeLayer alloc]init];
    bottomLayer.frame = self.bottomView.bounds;
    bottomLayer.path = bottomPath.CGPath;
    [bottomLayer setFillColor:[UIColor whiteColor].CGColor];
    [self.bottomView.layer setMask:bottomLayer];
    
    [self.view addSubview:self.bottomView];
    
    UILabel * bottomTitleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 40, 0, 80, 30)];
    bottomTitleLB.textAlignment = NSTextAlignmentCenter;
    bottomTitleLB.textColor = kMainColor;
    bottomTitleLB.text = @"单元";
    [self.bottomView addSubview:bottomTitleLB];
    
    UICollectionViewFlowLayout * bottomLayout = [[UICollectionViewFlowLayout alloc]init];
    bottomLayout.itemSize = CGSizeMake(kScreenWidth / 4 - 0.5, self.bottomView.hd_height - 30);
    bottomLayout.minimumLineSpacing = 0;
    bottomLayout.minimumInteritemSpacing = 0;
    bottomLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.bottomCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.bottomView.hd_height - 30) collectionViewLayout:bottomLayout];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.bottomView addSubview:self.bottomCollectionView];
    self.bottomCollectionView.backgroundColor = [UIColor whiteColor];
    
     [self loadDataWith:0];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.collectionView]) {
        return self.dataArray.count;
    }
    return self.bottomCollectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if ([collectionView isEqual:self.collectionView]) {
        TextbookMetarialCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTextbokDetailCellID forIndexPath:indexPath];
        cell.currentpage = indexPath.row + 1;
        cell.totalPage = self.dataArray.count;
        
        NSLog(@"self.bottomIndexpath.row = %d \n** indexPath.row = %d \n ** %d ** row = %d", self.bottomIndexpath.row, indexPath.row, self.lastIndexPath.section, self.lastIndexPath.row);
        
        // 上次阅读记录
        if (self.bottomIndexpath.row == self.lastIndexPath.section && self.lastIndexPath.row == indexPath.row) {
            cell.isLastReadRecord = YES;
        }else
        {
            cell.isLastReadRecord = NO;
        }
        
        [cell resetWithInfoDic:self.dataArray[indexPath.row]];
        
        // 搜索课文
        if (self.bottomIndexpath.row == self.searchIndexPath.section && self.searchIndexPath.row == indexPath.row) {
            [cell searchReset];
        }else{
            [cell reSearchReset];
        }
        
        cell.readTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_read;
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:kpartId]} withNotifiedObject:self];
           weakSelf.currentSelectTextInfo = [weakSelf.dataArray objectAtIndex:indexPath.row];
        };
        cell.recordTextBlock = ^(NSDictionary *infoDic) {
            weakSelf.learntextType = LearnTextType_record;
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:kpartId]} withNotifiedObject:self];
            weakSelf.currentSelectTextInfo = [weakSelf.dataArray objectAtIndex:indexPath.row];
        };
#pragma mark - play video 
        cell.videoBlock = ^(NSDictionary *infoDic) {
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            playVC.infoDic = infoDic;
            
            [weakSelf presentViewController:playVC animated:NO completion:nil];
        };
        
        return cell;
    }
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.hd_width, cell.hd_height)];
    if (self.bottomCollectionViewArray.count > 0) {
        titleLB.text = [[self.bottomCollectionViewArray objectAtIndex:indexPath.item] objectForKey:kUnitName];
    }
    if ([self.bottomIndexpath isEqual:indexPath]) {
        titleLB.textColor = kMainColor;
    }else
    {
        titleLB.textColor = UIColorFromRGB(0x555555);
    }
    titleLB.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLB];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([collectionView isEqual:self.bottomCollectionView]) {
        
        self.searchIndexPath = [NSIndexPath indexPathForRow:10000 inSection:0];
        
        self.bottomIndexpath = indexPath;
        [self.bottomCollectionView reloadData];
        
        self.dataArray = [self.bottomCollectionViewArray[indexPath.row] objectForKey:@"partList"];
        
        [self loadDataWith:indexPath.item];
    }else
    {
        self.currentSelectTextInfo = [self.dataArray objectAtIndex:indexPath.row];
        self.searchIndexPath = [NSIndexPath indexPathForRow:10000 inSection:0];
        [self.collectionView reloadData];
        
        NSDictionary * infoDic = self.dataArray[indexPath.row];
        
        if ([[self.infoDic objectForKey:kitemType] intValue] == 4) {
            // 单视频
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            playVC.infoDic = infoDic;
            
            [self presentViewController:playVC animated:NO completion:nil];
            return;
        }
        
        if ([[self.infoDic objectForKey:kitemType] intValue] == 3) {
            // 音频
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:kpartId]} withNotifiedObject:self];
            self.learntextType = LearnTextType_audio;
            
            return;
        }
        if ([[infoDic objectForKey:@"mp4Src"] length] > 0 && [[infoDic objectForKey:@"haveImgMp3"] intValue] == 0) {
            PlayVideoViewController * playVC = [[PlayVideoViewController alloc]init];
            playVC.infoDic = infoDic;
            
            [self presentViewController:playVC animated:NO completion:nil];
            return;
        }
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTextContentWithWithDic:@{kpartId:[infoDic objectForKey:kpartId]} withNotifiedObject:self];
        self.learntextType = LearnTextType_read;
        
    }
}

- (void)didRequestTextContentSuccessed
{
    NSLog(@"%@", self.currentSelectTextInfo);
    
    // 阅读课文或听录音，先缓存课文
    NSDictionary * infoDic = self.currentSelectTextInfo;
    NSArray * mp3UrlList = [infoDic objectForKey:@"mp3List"];
    for (int j = 0 ; j < mp3UrlList.count; j++) {
        NSString * mp3Str = [mp3UrlList objectAtIndex:j];
        
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //设置保存路径和生成文件名
        NSString *filePath = [NSString stringWithFormat:@"%@/%@-%d.mp3",docDirPath, [infoDic objectForKey:kpartName], j];
        //保存
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [SVProgressHUD dismiss];
            // 已下载 存储路径
            [self saveDownloadAudio:infoDic andNumber:j];
            
        }else
        {
            // 未下载。先下载，再存储路径
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:mp3Str]];
            if ([audioData writeToFile:filePath atomically:YES]) {
                    NSLog(@"succeed");
                
                [self saveDownloadAudio:infoDic andNumber:j];
                
            }else{
                    NSLog(@"faild");
            }
            
        }
        
    }
    [SVProgressHUD dismiss];
//    return;
    
    // 缓存完毕 进入课文页面
    if (self.learntextType == LearnTextType_audio) {
        PlayAudioViewController * audioVC = [[PlayAudioViewController alloc]init];
        audioVC.infoDic = self.currentSelectTextInfo;
        [self presentViewController:audioVC animated:NO completion:nil];
        return;
    }
    
    LearnTextViewController * vc = [[LearnTextViewController alloc]init];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:self.currentSelectTextInfo];
    [mInfo setObject:[self.infoDic objectForKey:kitemId] forKey:kitemId];
    vc.infoDic = mInfo;
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

- (void)loadDataWith:(NSInteger )item
{
    if (self.bottomCollectionViewArray.count < 4) {
        self.bottomCollectionView.frame = CGRectMake(kScreenWidth / 2 - self.bottomCollectionViewArray.count * kScreenWidth / 8, self.bottomCollectionView.hd_y, self.bottomCollectionViewArray.count * kScreenWidth / 4, self.bottomCollectionView.hd_height);
    }else
    {
        self.bottomCollectionView.frame = CGRectMake(0, self.bottomCollectionView.hd_y, kScreenWidth, self.bottomCollectionView.hd_height);
    }
    
    [self.bottomCollectionView reloadData];
    
    if (self.dataArray.count < 4) {
        self.collectionView.frame = CGRectMake(kScreenWidth / 2 - self.dataArray.count * kScreenWidth / 8, self.collectionView.hd_y, self.dataArray.count * kScreenWidth / 4, self.collectionView.hd_height);
    }else
    {
        self.collectionView.frame = CGRectMake(0, self.collectionView.hd_y, kScreenWidth, self.collectionView.hd_height);
    }
    
    [self.collectionView reloadData];
}

- (void)loadData
{
    self.bottomIndexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.lastIndexPath = [NSIndexPath indexPathForRow:10000 inSection:0];
    self.searchIndexPath = [NSIndexPath indexPathForRow:10000 inSection:0];
    
    self.bottomCollectionViewArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    
    self.bottomCollectionViewArray = [[[UserManager sharedManager] getTextbookContentArray] objectForKey:@"data"];
    self.lastRecordId = [[[UserManager sharedManager] getTextbookContentArray] objectForKey:@"lastRecordId"];
    
    if ([self.bottomCollectionViewArray class] == [NSNull class]) {
        return;
    }
    
    for (int i = 0; i < self.bottomCollectionViewArray.count; i++) {
        NSArray * infoArray = [self.bottomCollectionViewArray[i] objectForKey:@"partList"];
        for (int j = 0; j< [infoArray count]; j++) {
            
            NSDictionary * infoDic = infoArray[j];
            if ([[infoDic objectForKey:kpartId] isEqual:self.lastRecordId]) {
                self.lastIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    
    if (self.bottomCollectionViewArray.count > 0) {
        if (self.lastIndexPath.section >= 0) {
            self.bottomIndexpath = [NSIndexPath indexPathForRow:self.lastIndexPath.section inSection:0];
            self.dataArray = [self.bottomCollectionViewArray[self.lastIndexPath.section] objectForKey:@"partList"];// 有阅读记录的话，直接显示阅读记录所在单元
            
        }else
        {
            self.dataArray = [self.bottomCollectionViewArray[0] objectForKey:@"partList"];// 没有阅读记录，从第一单元开始显示
        }
    }
    [self.bottomCollectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.bottomCollectionViewArray.count > 0) {
            [self.bottomCollectionView scrollToItemAtIndexPath:self.bottomIndexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    });
}


#pragma mark - search
- (void)searchMember
{
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_searchText andTitle:@"" andPlaceHold:@"请输入课文名称" withAnimation:NO];
    __weak typeof(toolView)weakToolView = toolView;
    self.toolView = toolView;
    [self.view addSubview:toolView];
    toolView.TextBlock = ^(NSString *text) {
        if (text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入内容"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        if (self.searchTextArray.count == 0) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"该课本下没有[%@]这篇课文", text]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        NSDictionary * infoDic = [weakSelf.searchTextArray objectAtIndex:0];
        weakSelf.searchIndexPath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"]intValue] inSection:[[infoDic objectForKey:@"section"]intValue]];
        
        [weakSelf reloadUIWithSearchIndexPath:self.searchIndexPath];
        
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        [weakSelf.searchTextArray removeAllObjects];
        [weakSelf.searchTextTableView reloadData];
        [weakSelf.searchTextTableView removeFromSuperview];
        [weakToolView removeFromSuperview];
    };
    toolView.SearchTextBlock = ^(NSString *text) {
        [weakSelf refreshSearchTextTableView:text];
    };
    
}
- (void)refreshSearchTextTableView:(NSString *)tetx
{
    [self.searchTextArray removeAllObjects];
    for (int i = 0; i < self.bottomCollectionViewArray.count; i++) {
        NSArray * dateArray = [self.bottomCollectionViewArray[i] objectForKey:@"partList"];
        for (int j = 0; j< dateArray.count; j++) {
            NSDictionary * infoDic = [dateArray objectAtIndex:j];
            NSString * string = [infoDic objectForKey:kpartName];
            
            if ([string containsString:tetx]) {
                NSRange  range = [string rangeOfString:tetx];
                NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD8753)};
                NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:string];
                [mStr addAttributes:attribute range:range];
                
                NSMutableDictionary * mInfoDic = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
                [mInfoDic setObject:mStr forKey:@"title"];
                
                [mInfoDic setObject:@(j) forKey:@"row"];
                [mInfoDic setObject:@(i) forKey:@"section"];
                [self.searchTextArray addObject:mInfoDic];
            }
        }
    }
    if (!self.searchTextTableView) {
        self.searchTextTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.08 + 5, kScreenHeight * 0.42, kScreenWidth * 0.84 - 10, kScreenHeight * 0.15) style:UITableViewStylePlain];
        self.searchTextTableView.delegate = self;
        self.searchTextTableView.dataSource = self;
        [self.searchTextTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        self.searchTextTableView.backgroundColor = [UIColor whiteColor];
        self.searchTextTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    if (self.searchTextArray.count <= 5) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchTextTableView.hd_height = 40 * self.searchTextArray.count;
        });
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchTextTableView.hd_height = 40 * 5;
        });
    }
    
    [self.toolView addSubview:self.searchTextTableView];
    [self.searchTextTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchTextArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView removeAllSubviews];
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, cell.hd_width - 40, cell.hd_height)];
    titleLB.textColor = UIColorFromRGB(0x555555);
    titleLB.attributedText = [self.searchTextArray[indexPath.row] objectForKey:@"title"];
    [cell.contentView addSubview:titleLB];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.searchTextArray objectAtIndex:indexPath.row];
    self.searchIndexPath = [NSIndexPath indexPathForRow:[[infoDic objectForKey:@"row"]intValue] inSection:[[infoDic objectForKey:@"section"]intValue]];
    [self reloadUIWithSearchIndexPath:self.searchIndexPath];
    [self.toolView removeFromSuperview];
}

- (void)reloadUIWithSearchIndexPath:(NSIndexPath*)indexPath
{
    self.bottomIndexpath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    self.dataArray = [self.bottomCollectionViewArray[indexPath.section] objectForKey:@"partList"];
    [self loadDataWith:indexPath.item];
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.bottomCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
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
