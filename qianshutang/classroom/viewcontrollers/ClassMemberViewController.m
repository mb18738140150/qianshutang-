//
//  ClassMemberViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/15.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassMemberViewController.h"
#import "TeachingMaterailCollectionViewCell.h"
#define kTeachingMaterailCellID @"TeachingMaterailCellID"
#import "StudentInformationViewController.h"
#import "Teacher_StudentInformationViewController.h"

@interface ClassMemberViewController ()< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyClassroom_classMember>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * collectionDataArray;

@property (nonatomic, strong)UIImageView * iconImageBtn;
@property (nonatomic, strong)UILabel * nameLB;

@property (nonatomic, assign)BOOL isSearch;

@end

@implementation ClassMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self prepareUI];
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_shareAndQuit];
    [self.navigationView refreshWith:userCenterItemType_search];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    self.navigationView.searchBlock = ^(BOOL isSearch) {
        if (isSearch) {
            [weakSelf searchMember];
        }else
        {
            weakSelf.isSearch = NO;
            [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
            [[UserManager sharedManager] didRequestClassMemberWithWithDic:@{kClassroomId:[weakSelf.infoDic objectForKey:kClassroomId], kUserName:@""} withNotifiedObject:weakSelf];
        }
    };
    
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.text = @"班级成员";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];

    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height)];
    leftView.backgroundColor = kMainColor;
    [self.view addSubview:leftView];
    
    self.iconImageBtn = [[UIImageView alloc] init];
    self.iconImageBtn.frame = CGRectMake(kScreenWidth * 0.036, self.navigationView.hd_height + kScreenWidth * 0.0115, kScreenWidth * 0.124, kScreenWidth * 0.124);
    [self.iconImageBtn sd_setImageWithURL:[NSURL URLWithString:[self.infoDic objectForKey:kClassroomIcon]] placeholderImage:[UIImage imageNamed:@"logo1"]];
    self.iconImageBtn.layer.cornerRadius = 10;
    self.iconImageBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.iconImageBtn];

    
    self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageBtn.frame) + 10, kScreenWidth * 0.2, 20)];
    self.nameLB.textColor = [UIColor whiteColor];
    self.nameLB.text = [self.infoDic objectForKey:kClassroomName];
    self.nameLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLB];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 8, self.navigationView.hd_height + 10, (int )(kScreenWidth * 0.8 - 16), kScreenHeight* 0.85 - 10)];
    [self.view addSubview:self.backView];
    self.backView.backgroundColor = UIRGBColor(240, 240, 240);
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.backView.bounds collectionViewLayout:layout];
    [self.backView addSubview:self.collectionView];
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
    
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.collectionDataArray[indexPath.row]];
    [infoDic setObject:[infoDic objectForKey:kUserName] forKey:@"title"];
    [infoDic setObject:[infoDic objectForKey:@"userIconUrl"] forKey:@"imagrUrl"];
    
    if ([[infoDic objectForKey:@"isTeacher"] intValue] == 1) {
        cell.isTeacher = YES;
    }else
    {
        cell.isTeacher = NO;
    }
    [cell resetWithInfoDic:infoDic];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.backView.hd_width / 4 - 0.5, self.backView.hd_width / 4  + 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *infoDic = [self.collectionDataArray objectAtIndex:indexPath.row];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [mInfo setObject:[self.infoDic objectForKey:kClassroomId] forKey:kClassroomId];
    [mInfo setObject:[self.infoDic objectForKey:kClassroomName] forKey:kClassroomName];
    
    if ([[UserManager sharedManager] getUserType] == UserType_teacher && [[infoDic objectForKey:@"isTeacher"] intValue] == 0) {
        
        Teacher_StudentInformationViewController * vc = [[Teacher_StudentInformationViewController alloc]init];
        vc.isNotFromCommentTaskVC = YES;
        vc.infoDic = mInfo;
        if ([[infoDic objectForKey:@"isTeacher"] intValue] == 1) {
            vc.isTeacher = YES;
        }
        [self presentViewController:vc  animated:NO completion:nil];
        
    }else
    {
        StudentInformationViewController * vc = [[StudentInformationViewController alloc]init];
        vc.isNotFromCommentTaskVC = YES;
        vc.infoDic = mInfo;
        if ([[infoDic objectForKey:@"isTeacher"] intValue] == 1) {
            vc.isTeacher = YES;
        }
        [self presentViewController:vc  animated:NO completion:nil];
        
    }
    
}


- (void)loadData
{
    self.collectionDataArray = [NSMutableArray array];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId], kUserName:@""} withNotifiedObject:self];
}

- (void)searchMember
{
    __weak typeof(self)weakSelf = self;
    ToolTipView * toolView = [[ToolTipView alloc]initWithFrame:self.view.bounds andType:ToolTipTye_tf andTitle:@"" andPlaceHold:@"请输入用户昵称或手机号进行搜索" withAnimation:NO];
    __weak typeof(toolView)weakToolView = toolView;
    [self.view addSubview:toolView];
    toolView.TextBlock = ^(NSString *text) {
        if (text.length == 0) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return ;
        }
        [SVProgressHUD show];
        weakSelf.isSearch = YES;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        [[UserManager sharedManager] didRequestClassMemberWithWithDic:@{kClassroomId:[self.infoDic objectForKey:kClassroomId], kUserName:text} withNotifiedObject:self];
        [weakToolView removeFromSuperview];
    };
    toolView.DismissBlock = ^{
        weakSelf.isSearch = NO;
        [weakSelf.navigationView refreshSearchBtnWith:weakSelf.isSearch];
        [weakToolView removeFromSuperview];
    };
}

- (void)didRequestclassMemberSuccessed
{
    [SVProgressHUD dismiss];
    self.collectionDataArray = [[[UserManager sharedManager] getMyClassmemberList] mutableCopy];
    
    [self.collectionView reloadData];
}

- (void)didRequestclassMemberFailed:(NSString *)failedInfo
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
