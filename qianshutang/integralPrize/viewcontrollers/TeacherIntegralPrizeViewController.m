//
//  TeacherIntegralPrizeViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TeacherIntegralPrizeViewController.h"

#import "UserCenterTableView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "IntegralRulerDetailViewController.h"
#import "PrizeCollectionViewCell.h"
#define kPrizeCollectionCellID @"PrizeCollectionViewCell"
#import "TeacherPrizeDetailViewController.h"
#import "AddressView.h"
#import "CreatePrizeView.h"
#import "MyClassroomViewController.h"
#import "HaveSelectPrizeStudentViewController.h"
#import "AllIntegralPrizeViewController.h"

@interface TeacherIntegralPrizeViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, Integral_Teacher_memberPrize, Integral_Teacher_haveSendIntegral,Integral_PrizeList, Integral_Teacher_CreateConvertPrizeRecord, Integral_Teacher_sendGoods,Integral_ConvertPrizeRecord,Integral_CancelConvertPrize,Integral_Teacher_getAddressInfo, Teacher_editHaveSendIntegralRemark>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * myIntegralLB;
@property (nonatomic, strong)UILabel * canUseLB;
@property (nonatomic, strong)UIButton * IntegralRulerBtn;

@property (nonatomic, strong)ToolTipView * changeRemarkTipView;

@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, assign)BOOL isHaveConversion;


@property (nonatomic, strong)PopListView * arrangePopListView;
@property (nonatomic, strong)NSMutableArray * arrangePopList;
@property (nonatomic, strong)ToolTipView * toolView;
@property (nonatomic, strong)AddressView *addressView;// 发货地址view
@property (nonatomic, strong)NSDictionary * currentSelectSendPrizeLogLogInfo;// 选中发货记录

// 创建礼品
@property (nonatomic, strong)UIButton * createBtn;
@property (nonatomic, strong)CreatePrizeView * createPrizeView;


@end

@implementation TeacherIntegralPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.font = [UIFont systemFontOfSize:22];
    self.titleLB.text = @"积分记录";
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.createBtn.frame = CGRectMake(kScreenWidth * 0.675 - 15, 5, kScreenWidth * 0.125, self.navigationView.hd_height - 10);
    self.createBtn.backgroundColor = kMainColor;
    [self.createBtn setTitle:@"创建" forState:UIControlStateNormal];
    [self.createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createBtn.layer.cornerRadius = 5;
    self.createBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.createBtn];
    self.createBtn.hidden = YES;
    [self.createBtn addTarget:self action:@selector(createAction ) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.IntegralRulerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.IntegralRulerBtn.frame = CGRectMake(leftView.hd_width * 0.08, leftView.hd_height * 0.065, leftView.hd_width * 0.6, leftView.hd_height * 0.06);
    self.IntegralRulerBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.IntegralRulerBtn setTitle:@"积分规则" forState:UIControlStateNormal];
    [self.IntegralRulerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftView addSubview:self.IntegralRulerBtn];
    
    UIImageView * rulerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.IntegralRulerBtn.frame), self.IntegralRulerBtn.hd_y + 1, self.IntegralRulerBtn.hd_height - 2, self.IntegralRulerBtn.hd_height - 2)];
    rulerImageView.image = [UIImage imageNamed:@"icon_integral_help"];
    [leftView addSubview:rulerImageView];
    rulerImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * rulerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rulerAction)];
    [rulerImageView addGestureRecognizer:rulerTap];
    [self.IntegralRulerBtn addTarget:self action:@selector(rulerAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + kScreenHeight * 0.168, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height - kScreenHeight * 0.168) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = kMainColor;
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 8, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.backView.hd_width / 3 - 0.5, kScreenHeight * 0.5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.backView.bounds collectionViewLayout:layout];
    [self.backView addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIColorFromRGB(0xf7f7f7);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[PrizeCollectionViewCell class] forCellWithReuseIdentifier:kPrizeCollectionCellID];
    self.collectionView.hidden = YES;
    
    self.userTableview = [[UserCenterTableView alloc]initWithFrame:self.backView.bounds];
    [self.backView addSubview:self.userTableview];
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacher_studentIntegralList];
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        
    };
    self.userTableview.editPrizeRemarkBlock = ^(NSDictionary *infoDic) {
        [weakSelf changeNameAction:infoDic];
    };
    self.userTableview.headRefreshBlock = ^{
        [weakSelf reloadData];
    };
    
    self.userTableview.teacher_StudentPrizeRecordBlock = ^(NSDictionary *infoDic, CGRect rect) {
        weakSelf.currentSelectSendPrizeLogLogInfo = infoDic;
        [weakSelf addArrangePoplistView:infoDic andRect:rect];
    };
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableDataArray addObject:@{@"title":@"学员积分"}];
    [self.tableDataArray addObject:@{@"title":@"已送积分"}];
    [self.tableDataArray addObject:@{@"title":@"上架奖品"}];
    [self.tableDataArray addObject:@{@"title":@"未上架奖品"}];
    [self.tableDataArray addObject:@{@"title":@"兑奖记录"}];
    
    self.collectionDataArray = [NSMutableArray array];
    
    self.arrangePopList = [NSMutableArray array];
    [self.arrangePopList addObject:@{@"title":@"发货"}];
    [self.arrangePopList addObject:@{@"title":@"取消"}];
    [self reloadData];
}

- (void)reloadData
{
    switch (self.selectIndexPath.row) {
        case 0:
            {
                [[UserManager sharedManager] didRequestTeacher_memberIntegralWithWithDic:@{} withNotifiedObject:self];
            }
            break;
        case 1:
        {
            [[UserManager sharedManager] didRequestTeacher_haveSendIntegralWithWithDic:@{} withNotifiedObject:self];
        }
            break;
        case 2:
        {
            [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@1} withNotifiedObject:self];
        }
            break;
        case 3:
        {
            [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@0} withNotifiedObject:self];
        }
            break;
        case 4:
        {
            [[UserManager sharedManager] didRequestConvertPrizeRecordWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
        }
            break;
            
        default:
            break;
    }
}

- (void)refreshUI
{
    [self.userTableview endRefresh];
    self.collectionView.hidden = YES;
    self.userTableview.hidden = YES;
    self.createBtn.hidden = YES;
    switch (self.selectIndexPath.row) {
        case 0:
            self.titleLB.text = @"学员积分";
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacher_studentIntegralList];
            break;
        case 1:
            self.titleLB.text = @"已送积分";
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacher_haveSendIntegral];
            break;
        case 2:
            self.titleLB.text = @"上架奖品";
//            self.isHaveConversion = NO;
            self.collectionView.hidden = NO;
            
            break;
        case 3:
            self.titleLB.text = @"未上架奖品";
//            self.isHaveConversion = NO;
            self.collectionView.hidden = NO;
            break;
        case 4:
            self.titleLB.text = @"兑奖记录";
            self.userTableview.hidden = NO;
            self.createBtn.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_teacher_studentIntegralPrizeRecord];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.tableDataArray[indexPath.row]];
        if ([self.selectIndexPath isEqual:indexPath]) {
            [cell selectReset];
        }
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight / 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    [SVProgressHUD show];
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PrizeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrizeCollectionCellID forIndexPath:indexPath];
    cell.isHaveConversion = YES;
    [cell refreshWith:self.collectionDataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherPrizeDetailViewController * vc = [[TeacherPrizeDetailViewController alloc]init];
    vc.infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    [self presentViewController:vc animated:NO completion:nil];
}

- (UILabel *)headLB:(CGRect)rect andTitle:(NSString *)title
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    return label;
}

- (NSMutableAttributedString *)getAttributeFontText:(NSString *)str
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [mStr setAttributes:attribute range:NSMakeRange(5, str.length - 5)];
    
    return mStr;
}

- (NSMutableAttributedString *)getAttributeColorText:(NSString *)str
{
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0xFD824C)};
    [mStr setAttributes:attribute range:NSMakeRange(3, str.length - 3)];
    
    return mStr;
}

- (void)rulerAction
{
    IntegralRulerDetailViewController * vc = [[IntegralRulerDetailViewController alloc]init];
    [self presentViewController:vc  animated:NO completion:nil];
}

#pragma mark - create Prize Record
- (void)createAction
{
    CreatePrizeView * createPrizeView = [[CreatePrizeView alloc]initWithFrame:self.view.bounds];
    self.createPrizeView = createPrizeView;
    __weak typeof(self)weakSelf = self;
    createPrizeView.selectStudentBlock = ^{
        [weakSelf selectStudentAction:weakSelf.createPrizeView.selectStudentArray];
    };
    createPrizeView.selectPrizeBlock = ^{
        [weakSelf selectPrizeAction];
    };
    
    createPrizeView.selectTimeBlock = ^(NSString *timeStr) {
//        weakSelf.createPrizeSendTime = timeStr;
    };
    
    createPrizeView.complateBlock = ^(BOOL complate) {// 立即发货
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_createConverPrizeRecordWithWithDic:@{@"deliveryTime":weakSelf.createPrizeView.createPrizeSendTime,kmemberId:weakSelf.createPrizeView.selectStudentIdsStr,kPrizeId:[weakSelf.createPrizeView.createPeize_prizeInfo objectForKey:kPrizeId],@"doType":@2} withNotifiedObject:self];
        [weakSelf.createPrizeView removeFromSuperview];
    };
    createPrizeView.storeBlock = ^(BOOL cancel) {
        NSLog(@"保存");
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_createConverPrizeRecordWithWithDic:@{@"deliveryTime":weakSelf.createPrizeView.createPrizeSendTime,kmemberId:weakSelf.createPrizeView.selectStudentIdsStr,kPrizeId:[weakSelf.createPrizeView.createPeize_prizeInfo objectForKey:kPrizeId],@"doType":@1} withNotifiedObject:self];
        [weakSelf.createPrizeView removeFromSuperview];
    };
    createPrizeView.cancelBlock = ^(BOOL cancel) {
        [weakSelf.createPrizeView removeFromSuperview];
    };
    
    [self.view addSubview:createPrizeView];
}

- (void)selectStudentAction:(NSArray *)selectStudentArray
{
    __weak typeof(self)weakSelf = self;
//    if (selectStudentArray.count > 0) {
//        HaveSelectPrizeStudentViewController * haveVC = [[HaveSelectPrizeStudentViewController alloc]init];
//        haveVC.haveSelectStudentArray = selectStudentArray;
//        haveVC.selectPrizeStudentBlock = ^(NSArray *array) {
//            NSLog(@"selectStudent %@", array);
//            [weakSelf.createPrizeView resetSelectArrayWith:array];
//        };
//        [self presentViewController:haveVC animated:NO completion:nil];
//        return;
//    }
    
    MyClassroomViewController * classroomVC = [[MyClassroomViewController alloc]init];
    classroomVC.classroomType = MyClassroomType_CreatePrize_selectStudent;
    classroomVC.selectPrizeStudentBlock = ^(NSArray *array) {
        NSLog(@"selectStudent %@", array);
        [weakSelf.createPrizeView resetSelectArrayWith:array];
    };
    
    [self presentViewController:classroomVC animated:NO completion:nil];
}

- (void)selectPrizeAction
{
    AllIntegralPrizeViewController * allPrizeVC = [[AllIntegralPrizeViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    allPrizeVC.selectPrizeBlock = ^(NSDictionary *infoDic) {
        [weakSelf.createPrizeView resetSelectPrizeInfoWith:infoDic];
    };
    
    [self presentViewController:allPrizeVC animated:NO completion:nil];
}

#pragma mark - operation
- (void)addArrangePoplistView:(NSDictionary *)taskInfoDic andRect:(CGRect)rect
{
    CGRect convertRect = [self.userTableview convertRect:rect toView:self.view];
    if (self.arrangePopListView == nil) {
        self.arrangePopListView = [[PopListView alloc]initWithFrame:self.view.bounds andDataArr:self.arrangePopList andArrowRect:convertRect andWidth:90];
        
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.arrangePopListView];
        
        __weak typeof(self.arrangePopListView)weakListView = self.arrangePopListView;
        __weak typeof(self)weakSelf = self;
        self.arrangePopListView.dismissBlock = ^{
            [weakListView removeFromSuperview];
        };
        self.arrangePopListView.SelectBlock = ^(NSDictionary *infoDic) {
            int row = [[infoDic objectForKey:@"row"] intValue];
            if (row == 0) {
#pragma mark - 立即发货
                [weakSelf deliverPrizeAction:taskInfoDic];
            }else
            {
#pragma mark - cancel
                [weakSelf cancelDeliver:taskInfoDic];
            }
            [weakListView removeFromSuperview];
        };
    }else
    {
        AppDelegate * delegate = [UIApplication sharedApplication].delegate;
        [delegate.window addSubview:self.arrangePopListView];
        [self.arrangePopListView refreshWithRecr:convertRect];
    }
}

- (void)cancelDeliver:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    self.toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_deleteTeacherCourse andTitle:@"提示" withAnimation:YES];
    [self.toolView resetContentLbTetx:[NSString stringWithFormat:@"取消该兑奖？"]];
    [self.view addSubview:self.toolView];
    self.toolView.DismissBlock = ^{
        [weakSelf.toolView removeFromSuperview];
    };
    self.toolView.ContinueBlock = ^(NSString *str) {
        [SVProgressHUD dismiss];
        [[UserManager sharedManager] didRequestCancelConvertPrizeWith:@{kLogId:[infoDic objectForKey:kLogId]} withNotifiedObject:weakSelf];
        [weakSelf.toolView removeFromSuperview];
    };
}

// 发货
- (void)deliverPrizeAction:(NSDictionary *)infoDic
{
    NSLog(@"%@", infoDic);
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestTeacher_GetAddressInfoWithWithDic:@{kmemberId:[infoDic objectForKey:kUserId]} withNotifiedObject:self];
}

#pragma mark - 修改备注
- (void)changeNameAction:(NSDictionary *)infoDic
{
    __weak typeof(self)weakSelf = self;
    self.changeRemarkTipView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_changeName andTitle:@"修改备注" andPlaceHold:@"请输入备注" withAnimation:NO];
    self.changeRemarkTipView.maxCount = 100;
    [self.changeRemarkTipView resetNameTvText:[infoDic objectForKey:@"remark"]];
    
    self.changeRemarkTipView.DismissBlock = ^{
        ;[weakSelf.changeRemarkTipView removeFromSuperview];
    };
    self.changeRemarkTipView.ContinueBlock = ^(NSString *str) {
        
        NSLog(@"%@", infoDic);
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestTeacher_editHaveSendIntegralRemarkWithDic:@{kLogId:[infoDic objectForKey:kLogId],kRemark:str} withNotifiedObject:weakSelf];
        [weakSelf.changeRemarkTipView removeFromSuperview];
    };
    [self.view addSubview:self.changeRemarkTipView];
}

#pragma mark - request
- (void)didRequestTeacher_memberPrizeFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_memberPrizeSuccessed
{
    [SVProgressHUD dismiss];
    [self refreshUI];
}

- (void)didRequestTeacher_haveSendIntegralSuccessed
{
    [SVProgressHUD dismiss];
    [self refreshUI];
}

- (void)didRequestTeacher_haveSendIntegralFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self refreshUI];
}

- (void)didRequestConvertPrizeRecordFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestPrizeListSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.collectionDataArray removeAllObjects];
    for (NSDictionary * infoDic in [[UserManager sharedManager] getPrizeList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
        [mInfo setObject:[infoDic objectForKey:@"prizeIntegral"] forKey:@"integral"];
        [mInfo setObject:[infoDic objectForKey:kPrizeName] forKey:@"title"];
        [self.collectionDataArray addObject:mInfo];
    }
    
    [self refreshUI];
}

- (void)didRequestPrizeListFailed:(NSString *)failedInfo
{
    [self.userTableview endRefresh];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher__CreateConvertPrizeRecordSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher__CreateConvertPrizeRecordFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_sendGoodsSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher_sendGoodsFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCancelConvertPrizeSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"取消成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    [self reloadData];
}

- (void)didRequestCancelConvertPrizeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_getAddressInfoSuccessed
{
    [SVProgressHUD dismiss];
    __weak typeof(self)weakSelf = self;
    AddressView *addressView = [[AddressView alloc]initWithFrame:self.view.bounds];
    
    NSMutableDictionary * minfo = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getStudentAddressInfo]];
    [minfo setObject:[minfo objectForKey:@"recivePhone"] forKey:kreceivePhoneNumber];
    [addressView refreshWithAddressInfo:minfo];
    self.addressView = addressView;
    [self.addressView resignAllTf];
    addressView.AddressSelectBlock = ^(NSDictionary *addressDic) {
        
        NSLog(@"%@", weakSelf.currentSelectSendPrizeLogLogInfo);
        
        [weakSelf.addressView removeFromSuperview];
    };
    [self.view addSubview:addressView];
}

- (void)didRequestTeacher_getAddressInfoFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestTeacher_editHaveSendIntegralRemarkSuccessed
{
    [self reloadData];
}

- (void)didRequestTeacher_editHaveSendIntegralRemarkFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
