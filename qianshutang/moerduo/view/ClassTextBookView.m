//
//  ClassTextBookView.m
//  qianshutang
//
//  Created by aaa on 2018/9/19.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassTextBookView.h"

#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"

#import "StartCollectionViewCell.h"
#define kStartCellID   @"startCellID"

#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"


@interface ClassTextBookView()<HYSegmentedControlDelegate, UICollectionViewDelegate, UICollectionViewDataSource,MyClassroom_classTextbook, MyClassroom_classCourseWare>

@property (nonatomic, strong)HYSegmentedControl *segmentControl;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

//@property (nonatomic, strong)UIButton * latestBtn;
@property (nonatomic, strong)UIButton * closeBtn;
//@property (nonatomic, strong)UIView * latestView;

@property (nonatomic, strong)UIImageView * latestProductTypeImage;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSDictionary * infoDic;

@property (nonatomic, assign)teacherCollectionCellType collectionCellType;

@end

@implementation ClassTextBookView

- (instancetype)initWithFrame:(CGRect)frame andInfoDic:(NSDictionary *)infoDic
{
    if (self = [super initWithFrame:frame]) {
        self.infoDic = infoDic;
        [self loadData];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    self.backgroundColor = [UIColor whiteColor];
    self.segmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"课本",@"课件"] delegate:self];
    [self.segmentControl hideBottomView];
    [self.segmentControl hideSeparateLine];
    [self addSubview:self.segmentControl];
    self.segmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        [weakSelf reloadData:weakSelf.infoDic];
    };
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 75)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"选择内容";
    self.titleLB.hidden = YES;
    [self addSubview:self.titleLB];
    
    CGFloat viewHeigth = kScreenHeight * 0.15;
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - viewHeigth + 10, 5, viewHeigth - 10, viewHeigth - 10);
    [self.closeBtn setImage:[UIImage imageNamed:@"close_chat_btn_green"] forState:UIControlStateNormal];
    self.closeBtn.backgroundColor = kMainColor;
    self.closeBtn.layer.cornerRadius = self.closeBtn.hd_height / 2;
    self.closeBtn.layer.masksToBounds = YES;
    [self addSubview:self.closeBtn];
    [self.closeBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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

- (void)setTaskEditType:(TaskEditType)taskEditType
{
    if (taskEditType == TaskEditType_AggangrXiLieTask || taskEditType == TaskEditType_addClassroomTextBook) {
        self.segmentControl.hidden = YES;
        self.titleLB.hidden = NO;
    }
}

- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
}

- (void)reloadData:(NSDictionary *)infoDic
{
    self.infoDic = infoDic;
    if (self.segmentControl.selectIndex == 0) {
        self.collectionCellType = collectionCellType_textbook;
        if ([[[UserManager sharedManager] getClassTextbookArray] count] > 0) {
            ;
        }else
        {
            [[UserManager sharedManager] didRequestClassTextbookWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
        }
    }else
    {
        self.collectionCellType = collectionCellType_courseware;
        [[UserManager sharedManager] didRequestClassCourseWareWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId]} withNotifiedObject:self];
    }
    
    [self refreshTableView];
}

- (void)refreshTableView
{
    if (self.segmentControl.selectIndex == 0) {
        self.collectionDataArray = [[[UserManager sharedManager] getClassTextbookArray] mutableCopy];
        
        [self.collectionView reloadData];
    }else
    {
        self.collectionDataArray = [[[UserManager sharedManager] getClassCourseWareArray] mutableCopy];
        
        [self.collectionView reloadData];
    }
}

- (void)didRequestclassTextbookSuccessed
{
    [SVProgressHUD dismiss];
    [self refreshTableView];
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
    [self refreshTableView];
}

- (void)didRequestclassCourseWareFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
#pragma mark - collectionView delegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeachingMaterailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTeachingMaterailCellID forIndexPath:indexPath];
    
    [cell resetWithInfoDic:self.collectionDataArray[indexPath.item]];
//    if (self.segmentControl.selectIndex == 0) {
//    }else
//    {
//        if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
//            cell.isTeacherExplain = YES;
//        }
//        [cell resetCCoursewareWithInfoDic:self.collectionDataArray[indexPath.row]];
//    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2  + 15);
//    if (self.collectionCellType == collectionCellType_textbook) {
//    }else if (self.collectionCellType == collectionCellType_courseware )
//    {
//        return CGSizeMake(kScreenWidth * 0.2, kScreenWidth * 0.2  + 65);
//    }
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isTextbook = NO;
    if (self.segmentControl.selectIndex == 0) {
        isTextbook = YES;
    }else
    {
        isTextbook = NO;
    }
    if (self.selectProductBlock) {
        self.selectProductBlock(self.collectionDataArray[indexPath.row],isTextbook);
    }
}

- (void)refreshTitleWith:(NSString *)text
{
    self.titleLB.text = text;
}

- (void)deleteAction
{
    [self removeFromSuperview];
}


@end
