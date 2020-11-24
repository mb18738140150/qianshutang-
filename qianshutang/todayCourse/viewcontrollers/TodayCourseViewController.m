//
//  TodayCourseViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/20.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TodayCourseViewController.h"
#import "TodayCourseCollectionViewCell.h"
#define kTodayCourseCollectionCellID @"TodayCourseCollectionViewCell"
#import "TimeTableViewController.h"

@interface TodayCourseViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MyStudy_MyCourse_BigCourseList>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)UIButton * timetableBtn;
@property (nonatomic, strong)FailedView * failedView;// 暂无数据view
@end

@implementation TodayCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self prepareUI];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    [[UserManager sharedManager] didRequestMyCourse_BigCourseListWithWithDic:@{kTime:timeStr} withNotifiedObject:self];
}

- (void)prepareUI
{
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    __weak typeof(self)weakSelf = self;
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.timetableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timetableBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.navigationView.rightView.hd_height + 10, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.timetableBtn setTitle:@"课表" forState:UIControlStateNormal];
    [self.timetableBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.timetableBtn.backgroundColor = kMainColor;
    self.timetableBtn.layer.cornerRadius = self.timetableBtn.hd_height / 2;
    self.timetableBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.timetableBtn];
    [self.timetableBtn addTarget:self action:@selector(timetableAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"今日课程";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    self.backImageView.image = [UIImage imageNamed:@"course_bg"];
    [self.view addSubview:self.backImageView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.18, kScreenWidth, kScreenHeight * 0.689) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[TodayCourseCollectionViewCell class] forCellWithReuseIdentifier:kTodayCourseCollectionCellID];
    
    self.failedView = [[FailedView alloc]initWithFrame:self.collectionView.frame andImage:[UIImage imageNamed:@""] andContent:@"" andDetail:[[NSMutableAttributedString alloc] initWithString:@""]];
    self.failedView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.failedView];
    self.failedView.hidden = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodayCourseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTodayCourseCollectionCellID forIndexPath:indexPath];
    [cell resetWith:self.dataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark - courseClick
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.46, kScreenHeight * 0.689);
}

- (void)didRequestMyCourse_BigCourseListSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[[UserManager sharedManager] getMyCourse_BigCourseList] mutableCopy];
    [self.collectionView reloadData];
    [self addnoDataView];
}

- (void)didRequestMyCourse_BigCourseListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)timetableAction
{
    TimeTableViewController * vc = [[TimeTableViewController alloc]init];
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)addnoDataView
{
    if (self.dataArray.count == 0) {
        self.failedView.hidden = NO;
    }else
    {
        self.failedView.hidden = YES;
    }
    
    UIImage * image = [UIImage imageNamed:@""];
    NSString * content = @"";
    NSMutableAttributedString * detail ;
    image = [UIImage imageNamed:@"default_homework_icon"];
    content = @"暂无课程";
    detail = [[NSMutableAttributedString alloc]initWithString:@""];
    
    
    [self.failedView refreshWithImage:image andContent:content andDetail:detail];
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
