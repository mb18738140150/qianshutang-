//
//  XilieTaskYulanSelectDayView.m
//  qianshutang
//
//  Created by aaa on 2018/10/7.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "XilieTaskYulanSelectDayView.h"

#import "XilieTaskYulanCollectionViewCell.h"
#define kSelectDayCellID    @"XilieTaskYulanCollectionViewCell"


@interface XilieTaskYulanSelectDayView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIButton * previousBtn;
@property (nonatomic, strong)UIButton * nextBtn;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSArray *weekdays;
@property (nonatomic, strong)NSDateFormatter * formatter;

@property (nonatomic, assign)int currentPage;
@property (nonatomic, assign)int totalPage;

@property (nonatomic, strong)NSIndexPath * indexPath;

@property (nonatomic, strong)NSMutableArray * currentWeekCourseDataArray;

@property (nonatomic, assign)int count;

@end

@implementation XilieTaskYulanSelectDayView

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)currentWeekCourseDataArray
{
    if (!_currentWeekCourseDataArray) {
        _currentWeekCourseDataArray = [NSMutableArray array];
    }
    return _currentWeekCourseDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadData];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(0, self.hd_height / 2 - 10, 15, 20);
    [self.previousBtn setImage:[UIImage imageNamed:@"arrows_left"] forState:UIControlStateNormal];
    [self addSubview:self.previousBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(self.hd_width - 20, self.hd_height / 2 - 10, 15, 20);
    [self.nextBtn setImage:[UIImage imageNamed:@"arrows_right"] forState:UIControlStateNormal];
    [self addSubview:self.nextBtn];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((self.hd_width - self.previousBtn.hd_width * 2 - 20) / 7, self.hd_height);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.previousBtn.frame) + 10, 0, self.hd_width - self.previousBtn.hd_width * 2 - 20, self.hd_height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[XilieTaskYulanCollectionViewCell class] forCellWithReuseIdentifier:kSelectDayCellID];
    [self addSubview:self.collectionView];
    
    self.currentPage = 0;
    
    [self.previousBtn addTarget:self action:@selector(previousAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XilieTaskYulanCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSelectDayCellID forIndexPath:indexPath];
    
    [cell resetWith:self.dataArray[indexPath.row]];
    
    if (self.count > indexPath.row) {
        [cell isHaveCourse:YES];
    }else
    {
        [cell isHaveCourse:NO];
    }
    
    if ([self.indexPath isEqual:indexPath]) {
        [cell selectReset];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.count <= indexPath.row) {
        return;
    }
    NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
    self.indexPath = indexPath;
    [self.collectionView reloadData];
    if (self.SelectDayBlock) {
        self.SelectDayBlock(indexPath.row);
    }
}

- (void)resetTaskCount:(NSInteger)count
{
    self.count = count;
    [self loadData];
    [self.collectionView reloadData];
}
- (void)loadData
{
    int page1 = self.count / 7;
    int page2 = 0;
    if (self.count % 7) {
        page2 = 1;
    }
    self.totalPage = page1 + page2;
    
    for (int i = 0; i < self.totalPage * 7 ; i++) {
        NSString * str = [NSString stringWithFormat:@"第%d天", i + 1];
        NSDictionary * infpDic = @{@"title":str};
        [self.dataArray addObject:infpDic];
    }
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)previousAction
{
    if (self.currentPage == 0) {
        return;
    }
    self.currentPage--;
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.hd_width * self.currentPage, 0, self.collectionView.hd_width, self.collectionView.hd_height) animated:NO];
}


- (void)nextAction
{
    if (self.currentPage == self.totalPage - 1) {
        return;
    }
    self.currentPage++;
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.hd_width * self.currentPage, 0, self.collectionView.hd_width, self.collectionView.hd_height) animated:NO];
}


@end
