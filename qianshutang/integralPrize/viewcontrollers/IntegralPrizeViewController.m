//
//  IntegralPrizeViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "IntegralPrizeViewController.h"
#import "UserCenterTableView.h"
#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"
#import "IntegralRulerDetailViewController.h"
#import "PrizeCollectionViewCell.h"
#define kPrizeCollectionCellID @"PrizeCollectionViewCell"
#import "PrizeDetailViewController.h"

@interface IntegralPrizeViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, Integral_MyIntegral, Integral_MyIntegralRecord, Integral_PrizeList, Integral_ConvertPrizeRecord, Integral_ComplateConvertPrize, Integral_CancelConvertPrize, Integral_ConvertPrize>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * tableDataArray;
@property (nonatomic, strong)NSIndexPath * selectIndexPath;

@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * myIntegralLB;
@property (nonatomic, strong)UILabel * canUseLB;
@property (nonatomic, strong)UIButton * IntegralRulerBtn;


@property (nonatomic, strong)UserCenterTableView * userTableview;
@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, assign)BOOL isHaveConversion;

@property (nonatomic, strong)NSDictionary * integralInfoDic;
@property (nonatomic, strong)NSDictionary * integralRecordArray;

@end

@implementation IntegralPrizeViewController

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
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight * 0.85)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.myIntegralLB = [[UILabel alloc]initWithFrame:CGRectMake(10, leftView.hd_height * 0.065, leftView.hd_width - 20, leftView.hd_height * 0.04)];
    self.myIntegralLB.textColor = UIColorFromRGB(0x222222);
    self.myIntegralLB.font = kMainFont;
    self.myIntegralLB.attributedText = [self getAttributeFontText:@"我的积分:1"];
    [leftView addSubview:self.myIntegralLB];
    
    self.canUseLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.myIntegralLB.frame) + leftView.hd_height * 0.045, leftView.hd_width - 20, leftView.hd_width * 0.04)];
    self.canUseLB.textColor = UIColorFromRGB(0x222222);
    self.canUseLB.font = kMainFont;
    self.canUseLB.attributedText = [self getAttributeFontText:@"可兑积分:1"];
    [leftView addSubview:self.canUseLB];
    
    self.IntegralRulerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.IntegralRulerBtn.frame = CGRectMake(leftView.hd_width * 0.08, CGRectGetMaxY(self.canUseLB.frame) + leftView.hd_height * 0.037, leftView.hd_width * 0.6, leftView.hd_height * 0.06);
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height + kScreenHeight * 0.3, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
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
    [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_integralRecord];
    self.userTableview.UserCenterCellClickBlock = ^(UserCenterTableViewType type, NSDictionary *infoDic) {
        
    };
    self.userTableview.headRefreshBlock = ^{
        [weakSelf reloadTableData];
    };
    self.userTableview.cancelConvertPrizeBlock = ^(NSDictionary *infoDic) {
        [[UserManager sharedManager] didRequestCancelConvertPrizeWith:@{kLogId:[infoDic objectForKey:kLogId]} withNotifiedObject:weakSelf];
    };
}

- (void)loadData
{
    self.tableDataArray = [NSMutableArray array];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableDataArray addObject:@{@"title":@"积分记录"}];
    [self.tableDataArray addObject:@{@"title":@"可兑奖品"}];
    [self.tableDataArray addObject:@{@"title":@"兑奖记录"}];
    [self.tableDataArray addObject:@{@"title":@"已兑奖品"}];
    
    self.collectionDataArray = [NSMutableArray array];
    
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyIntegralWithNotifiedObject:self];
    
    [[UserManager sharedManager] didRequestMyIntegralRecordWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
}
- (void)reloadTableData
{
    [SVProgressHUD show];
    if (self.selectIndexPath.row == 0) {
        [[UserManager sharedManager] didRequestMyIntegralRecordWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    }else if (self.selectIndexPath.row == 1)
    {
        [[UserManager sharedManager] didRequestPrizeListWith:@{@"type":@1} withNotifiedObject:self];
    }else if (self.selectIndexPath.row == 2)
    {
        [[UserManager sharedManager] didRequestConvertPrizeRecordWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    }else if (self.selectIndexPath.row == 3)
    {
        [[UserManager sharedManager] didRequestComplateConvertPrizeWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    }
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
    if ([self.selectIndexPath isEqual: indexPath]) {
        return;
    }
    
    self.selectIndexPath = indexPath;
    self.collectionView.hidden = YES;
    self.userTableview.hidden = YES;
    switch (indexPath.row) {
        case 0:
            self.titleLB.text = @"积分记录";
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_integralRecord];
            break;
        case 1:
            self.titleLB.text = @"可兑奖品";
            self.isHaveConversion = NO;
            self.collectionView.hidden = NO;
            break;
        case 2:
            self.titleLB.text = @"兑奖记录";
            self.userTableview.hidden = NO;
            [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_prizeRecord];
            break;
        case 3:
            self.titleLB.text = @"已兑奖品";
            self.isHaveConversion = YES;
            self.collectionView.hidden = NO;
            break;
            
        default:
            break;
    }
    [self reloadTableData];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PrizeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPrizeCollectionCellID forIndexPath:indexPath];
    cell.isHaveConversion = self.isHaveConversion;
    __weak typeof(self)weakSelf = self;
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc] initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kPrizeName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:kPrizeIntegral] forKey:@"integral"];
    cell.convertPrizeBlock = ^(NSDictionary *infoDic) {
        [[UserManager sharedManager] didRequestConvertPrizeWith:@{kPrizeId:[infoDic objectForKey:kPrizeId]} withNotifiedObject:weakSelf];
    };
    [cell refreshWith:infoDic];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (!self.isHaveConversion) {
        PrizeDetailViewController * vc = [[PrizeDetailViewController alloc]init];
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
        [infoDic setObject:self.canUseLB.text forKey:@"canUserIntegral"];
        vc.infoDic = infoDic;
        
        vc.convertBlock = ^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyIntegralWithNotifiedObject:weakSelf];
            }
        };
        
        [self presentViewController:vc animated:NO completion:nil];
    }
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
    vc.imageUrlStr = [self.integralInfoDic objectForKey:kIntegralRulerImageStr];
    [self presentViewController:vc  animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - integralDelegate
- (void)didRequestMyIntegralSuccessed
{
    [SVProgressHUD dismiss];
    self.integralInfoDic = [[UserManager sharedManager] getmyIntegral];
    self.myIntegralLB.text = [NSString stringWithFormat:@"我的积分:%@", [self.integralInfoDic objectForKey:kMyIntegral]];
    self.canUseLB.text = [NSString stringWithFormat:@"可兑积分:%@", [self.integralInfoDic objectForKey:kMyConvertIntegral]];
}
- (void)didRequestMyIntegralFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - integralRecord
- (void)didRequestMyIntegralRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    self.integralRecordArray = [[UserManager sharedManager] getmyIntegralRecord];
    [self refreshUsertableView];
}

- (void)didRequestMyIntegralRecordFailed:(NSString *)failedInfo
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
    [self refreshUsertableView];
}

- (void)didRequestPrizeListFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeRecordFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeRecordSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestComplateConvertPrizeSuccessed
{
    [SVProgressHUD dismiss];
    [self.userTableview endRefresh];
    [self refreshUsertableView];
}

- (void)didRequestComplateConvertPrizeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestConvertPrizeSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"兑换成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [[UserManager sharedManager] didRequestMyIntegralWithNotifiedObject:self];
    });
}

- (void)didRequestConvertPrizeFailed:(NSString *)failedInfo
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
        [[UserManager sharedManager] didRequestMyIntegralWithNotifiedObject:self];
        [[UserManager sharedManager] didRequestConvertPrizeRecordWith:@{kmemberId:@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
    });
}

- (void)didRequestCancelConvertPrizeFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)refreshUsertableView
{
    if (self.selectIndexPath.row == 0) {
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_integralRecord];
    }else if (self.selectIndexPath.row == 1)
    {
        self.collectionDataArray = [[[UserManager sharedManager] getPrizeList] mutableCopy];
        [self.collectionView reloadData];
    }else if (self.selectIndexPath.row == 2)
    {
        [self.userTableview resetUsercenterTableViewType:UserCenterTableViewType_prizeRecord];
    }else if (self.selectIndexPath.row == 3)
    {
        self.collectionDataArray = [[[UserManager sharedManager] getComplateConvertPrizeList] mutableCopy];
        [self.collectionView reloadData];
    }
    
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
