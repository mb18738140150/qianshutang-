//
//  ClassroomMemberProductView.m
//  qianshutang
//
//  Created by aaa on 2018/8/28.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomMemberProductView.h"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "StartCollectionViewCell.h"
#define kStartCellID   @"startCellID"

#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"

@interface ClassroomMemberProductView()<HYSegmentedControlDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)HYSegmentedControl *segmentControl;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UIButton * latestBtn;
@property (nonatomic, strong)UIButton * closeBtn;
@property (nonatomic, strong)UIView * latestView;

@property (nonatomic, strong)UIImageView * latestProductTypeImage;
@property (nonatomic, strong)UILabel * titleLB;
@end

@implementation ClassroomMemberProductView

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
    __weak typeof(self)weakSelf = self;
    self.backgroundColor = [UIColor whiteColor];
    self.segmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    [self.segmentControl hideBottomView];
    [self.segmentControl hideSeparateLine];
    [self addSubview:self.segmentControl];
    self.segmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        [weakSelf reloadData];
    };
    
    CGFloat viewHeigth = kScreenHeight * 0.15;
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - viewHeigth + 10, 5, viewHeigth - 10, viewHeigth - 10);
    [self.closeBtn setImage:[UIImage imageNamed:@"close_chat_btn_green"] forState:UIControlStateNormal];
    self.closeBtn.backgroundColor = kMainColor;
    self.closeBtn.layer.cornerRadius = self.closeBtn.hd_height / 2;
    self.closeBtn.layer.masksToBounds = YES;
    [self addSubview:self.closeBtn];
    [self.closeBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.latestView = [[UIView alloc]initWithFrame:CGRectMake(self.closeBtn.hd_x - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, viewHeigth - 10)];
    self.latestView.backgroundColor = kMainColor;
    self.latestView.layer.cornerRadius = 5;
    self.latestView.layer.masksToBounds = YES;
    [self addSubview:self.latestView];
    
    NSString * str = @"最新作品";
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat totalWidth = textSize.width + 10 + 15;
    
    UILabel * titlaLB = [[UILabel alloc]initWithFrame:CGRectMake((self.latestView.hd_width - totalWidth) / 2, self.latestView.hd_height / 2 - 10, textSize.width, 20)];
    titlaLB.text = str;
    titlaLB.textColor = [UIColor whiteColor];
    self.titleLB = titlaLB;
    [self.latestView addSubview:self.titleLB];
    
    self.latestProductTypeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlaLB.frame) + 9, self.latestView.hd_height / 2 - 5, 15, 10)];
    self.latestProductTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
    [self.latestView addSubview:self.latestProductTypeImage];
    
    self.latestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.latestBtn.frame = self.latestView.bounds;
    //    [self.latestBtn setTitle:@"删除" forState:UIControlStateNormal];
    //    [self.latestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.latestBtn.backgroundColor = [UIColor clearColor];
    self.latestBtn.layer.cornerRadius = 5;
    self.latestBtn.layer.masksToBounds = YES;
    [self.latestView addSubview:self.latestBtn];
    [self.latestBtn addTarget:self action:@selector(latestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.15, kScreenWidth * 0.8, kScreenHeight * 0.85) collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TeachingMaterailCollectionViewCell class] forCellWithReuseIdentifier:kTeachingMaterailCellID];
    [self.collectionView registerClass:[StartCollectionViewCell class] forCellWithReuseIdentifier:kStartCellID];
    [self.collectionView registerClass:[CreatProductionCollectionViewCell class] forCellWithReuseIdentifier:kCreatProductionCellID];
    
}
- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
}

- (void)reloadData
{
    if (self.segmentControl.selectIndex == 0) {
        self.collectionDataArray = [[[UserManager sharedManager] getProductShowRecordArray] mutableCopy];
    }else
    {
        self.collectionDataArray = [[[UserManager sharedManager] getProductShowCreateArray] mutableCopy];
    }
    [self.collectionView reloadData];
}

#pragma mark - collectionView delegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StartCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStartCellID forIndexPath:indexPath];
    
    NSDictionary * infoDic = self.collectionDataArray[indexPath.item];
    [cell resetWithInfoDic:infoDic];
    cell.selectNumberLB.hidden = NO;
    cell.selectNumberLB.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2 + 55);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectProductBlock) {
        self.selectProductBlock(self.collectionDataArray[indexPath.row]);
    }
    if (self.selectProductAndSegmentBlock) {
        self.selectProductAndSegmentBlock(self.collectionDataArray[indexPath.row], self.segmentControl.selectIndex);
    }
}

- (void)refreshTitleWith:(NSString *)text
{
    self.titleLB.text = text;
}
- (void)refreshLatestView
{
    self.latestBtn.selected = !self.latestBtn.selected;
    self.latestProductTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
}
- (void)deleteAction
{
    [self removeFromSuperview];
}

- (void)latestAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        self.latestProductTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white_up"];
        if (self.latestProductBlock) {
            self.latestProductBlock(YES,self.latestView.frame);
        }
    }else
    {
        self.latestProductTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
        if (self.latestProductBlock) {
            self.latestProductBlock(NO,self.latestView.frame);
        }
    }
}




@end
