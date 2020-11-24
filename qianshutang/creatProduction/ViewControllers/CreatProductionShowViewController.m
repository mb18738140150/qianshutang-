//
//  CreatProductionShowViewController.m
//  qianshutang
//
//  Created by aaa on 2018/7/26.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreatProductionShowViewController.h"
#import "CreatProductionCollectionViewCell.h"
#define kCreatProductionCellID @"createProductionCell"
#import "CreateProductionViewController.h"
#import "CommentTaskViewController.h"

typedef enum : NSUInteger {
    SelectType_nomal,
    SelectType_share,
    SelectType_delete,
} SelectType;

@interface CreatProductionShowViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyStudy_MyProduct,MyClassroom_MyFriendProductDetail,MyStudy_DeleteMyProduct,MyStudy_ShareMyProduct,WXApiShareManagerDelegate>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, assign)SelectType selectType;

@property (nonatomic, strong)NSDictionary * selectProductInfo;
@property (nonatomic, assign)ShareObjectType shareType;
@end

@implementation CreatProductionShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectType = SelectType_nomal;
    [self loadData];
    [self prepareUI];
    [[WXApiShareManager shareManager] setDelegate:self];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_deleteAneShare];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    self.navigationView.shareBlock = ^(BOOL isShare) {
        [weakSelf.navigationView refreshDeleteBtnWith:NO];
        if (weakSelf.selectType == SelectType_share) {
            weakSelf.selectType = SelectType_nomal;
        }else
        {
            weakSelf.selectType = SelectType_share;
        }
        [weakSelf.collectionView reloadData];
    };
    self.navigationView.deleteBlock = ^(BOOL isDelete){
        if (weakSelf.selectType == SelectType_delete) {
            weakSelf.selectType = SelectType_nomal;
        }else
        {
            weakSelf.selectType = SelectType_delete;
        }
        [weakSelf.collectionView reloadData];
    };
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"创作作品";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(kScreenWidth * 0.2 - 0.5, kScreenWidth * 0.2 + 30);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), kScreenWidth, kScreenHeight * 0.85) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = UIRGBColor(239, 239, 239);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CreatProductionCollectionViewCell class] forCellWithReuseIdentifier:kCreatProductionCellID];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:self];
}

#pragma mark - myProductRequestDelegate
- (void)didRequestMyProductSuccessed
{
    [SVProgressHUD dismiss];
    self.dataArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
    [self.collectionView reloadData];
}

- (void)didRequestMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - collectionView delegate&dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CreatProductionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCreatProductionCellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [cell resetAddView];
    }else
    {
        NSDictionary * infoDic = self.dataArray[indexPath.item - 1];
        [cell resetWithInfoDic:self.dataArray[indexPath.item - 1]];
        if (self.selectType == SelectType_delete) {
            [cell resetDeleteView];
        }else if (self.selectType == SelectType_share )
        {
            [cell resetShareView];
        }
    }
    __weak typeof(self)weakSelf = self;
    cell.delateBlock = ^(NSDictionary *infoDic) {
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestDeleteMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId],@"productType":@(2)} withNotifiedObject:weakSelf];
    };
    cell.shareBlock = ^(NSDictionary *infoDic) {
        [weakSelf shareAction];
    };
    
    return cell;
}

- (void)didRequestDeleteMyProductSuccessed
{
    [self loadData];
}

- (void)didRequestDeleteMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    if (indexPath.row == 0) {
        CreateProductionViewController * creatVC = [[CreateProductionViewController alloc]init];
        creatVC.createProductionType = CreatProductionType_new;
        
        [self presentViewController:creatVC animated:NO completion:nil];
    }else
    {
        NSDictionary * infoDic = self.dataArray[indexPath.item - 1];
        self.selectProductInfo = self.dataArray[indexPath.item - 1];
        if (self.selectType == SelectType_delete) {
            [SVProgressHUD show];
            [[UserManager sharedManager] didRequestDeleteMyProductWithWithDic:@{kProductId:[infoDic objectForKey:kProductId],@"productType":@(2)} withNotifiedObject:self];
            return;
        }
        if (self.selectType == SelectType_share) {
            [self shareAction];
            return;
        }
        
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId]} withNotifiedObject:self];
    }
}

- (void)shareAction
{
    __weak typeof(self)weakSelf = self;
    ShareView * shareView = [[ShareView alloc]initWithFrame:self.view.bounds andShareType:ShareType_productShowAndWeixin];
    [self.view addSubview:shareView];
    shareView.shareBlock = ^(NSDictionary *infoDic) {
        switch ([[infoDic objectForKey:@"type"] integerValue]) {
            case ShareObjectType_ProductShow:
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[weakSelf.selectProductInfo objectForKey:kProductId],kshareType:@(1)} withNotifiedObject:weakSelf];
            }
                break;
            case ShareObjectType_weixinFriend:
            {
                // 分享给微信好友
                self.shareType = ShareObjectType_weixinFriend;
                [[WXApiShareManager shareManager] shareToSessionWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_friendCircle:
            {
                // 分享给微信朋友圈
                self.shareType = ShareObjectType_friendCircle;
                [[WXApiShareManager shareManager] shareToTimelineWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
            case ShareObjectType_WeixinCollect:
            {
                // 分享给微信收藏
                self.shareType = ShareObjectType_WeixinCollect;
                [[WXApiShareManager shareManager] shareToFavoriteWithcotent:@{@"title":@"qianshutang",@"description":@"hello",@"image":@"logo1",@"html":[[UserManager sharedManager]getShareUrl]} andDelegate:self];
            }
                break;
                
            default:
                break;
        }
    };
    
}

#pragma mark - wexin share success delegate
- (void)shareSuccess
{
    int type = 1;
    switch (self.shareType) {
        case ShareObjectType_weixinFriend:
            type = 2;
            break;
        case ShareObjectType_friendCircle:
            type = 3;
            break;
        case ShareObjectType_WeixinCollect:
            type = 4;
            break;
            
        default:
            break;
    }
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestShareMyProductWithWithDic:@{kProductId:[self.selectProductInfo objectForKey:kProductId],kshareType:@(type)} withNotifiedObject:self];
}


#pragma mark - share
- (void)didRequestShareMyProductSuccessed
{
    FlowerView * starView = [[FlowerView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:starView];
    
    [SVProgressHUD dismiss];
}

- (void)didRequestShareMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyFriendProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyFriendProductDetailInfoDic]);
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
    
    CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
    vc.infoDic = infoDic;
    vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
    vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
    vc.commentTaskType = CommentTaskType_studentLookSelf;
    vc.productType = ProductType_create;
    
    vc.modifuProductBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:@([[UserManager sharedManager] getUserId]),@"isShare":@0} withNotifiedObject:weakSelf];
        }
    };
    
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
