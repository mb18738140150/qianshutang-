//
//  StudentInformationViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/12.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "StudentInformationViewController.h"

#import "MainLeftTableViewCell.h"
#define kMainLeftCellID  @"mainLeftCellID"

#import "StudentProductTableViewCell.h"
#define kStudentProductCellID @"studentproductCell"
#import "CommentTaskViewController.h"

@interface StudentInformationViewController ()<UITableViewDelegate, UITableViewDataSource, MyClassroom_classMemberInformation,MyStudy_MyProduct, MyClassroom_MyRecordProductDetail, MyClassroom_MyFriendProductDetail>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * basicArray;
@property (nonatomic, strong)NSMutableArray * recordArray;
@property (nonatomic, strong)NSMutableArray * createArray;

@property (nonatomic, strong)HYSegmentedControl * productSegmentControl;

@property (nonatomic, strong)UITableView * leftTableView;
@property (nonatomic, strong)NSMutableArray * leftDataArr;
@property (nonatomic, strong)NSIndexPath * leftIndexPath;

@property (nonatomic, strong)NSDictionary * selectProductInfo;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * studentNameLB;
@property (nonatomic, strong)UIImageView * genderImageView;
@property (nonatomic, strong)UILabel * ageLB;
@property (nonatomic, strong)UILabel * starLB;
@property (nonatomic, strong)UILabel * flowerLB;
@property (nonatomic, strong)UILabel * goldLB;
@property (nonatomic, strong)UIButton * comunicateBtn;
@property (nonatomic, strong)UIButton * shareBtn;

@end

@implementation StudentInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIRGBColor(240, 240, 240);
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.view addSubview:self.navigationView];
    
    NSLog(@"%@", self.infoDic);
    
    [self loadData];
    
    [self prepareUI];
}

- (void)loadData
{
    self.leftIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.isTeacher) {
        self.leftDataArr = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"老师信息"},@{@"title":@"老师作品"}]];
    }else
    {
        self.leftDataArr = [[NSMutableArray alloc]initWithArray:@[@{@"title":@"学员信息"},@{@"title":@"学员作品"}]];
    }
    
    self.dataArray = [NSMutableArray array];
    self.basicArray = [NSMutableArray array];
    self.recordArray = [NSMutableArray array];
    self.createArray = [NSMutableArray array];
    
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClassMemberInformationWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"]} withNotifiedObject:self];
    [[UserManager sharedManager] didRequestMyProductWithWithDic:@{kmemberId:[self.infoDic objectForKey:@"userId"],@"isShare":@0} withNotifiedObject:self];
}

- (void)didRequestclassMemberInformationSuccessed
{
    [SVProgressHUD dismiss];
    [self.dataArray removeAllObjects];
    NSDictionary * infoDic = [[UserManager sharedManager] getMemberInformation];
    
    NSLog(@"infoDic = %@", infoDic);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshUIWith:infoDic];
    });
    
    [self.basicArray addObject:@{@"title":@"昵称",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"nickName"]]}];
    [self.basicArray addObject:@{@"title":@"性别",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"gender"]]}];
    [self.basicArray addObject:@{@"title":@"城市",@"content":[NSString stringWithFormat:@"%@", [infoDic objectForKey:@"city"]]}];
    self.dataArray = self.basicArray;
    [self.tableView reloadData];
}
- (void)didRequestclassMemberInformationFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestMyProductSuccessed
{
    self.recordArray = [[UserManager sharedManager] getMyRecordProductInfoDic];
    
    self.createArray = [[UserManager sharedManager] getMyCreatProductInfoDic];
    [self.tableView reloadData];
}

- (void)didRequestMyProductFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth * 0.2, kScreenHeight - self.navigationView.hd_height) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.leftTableView registerClass:[MainLeftTableViewCell class] forCellReuseIdentifier:kMainLeftCellID];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.leftTableView.backgroundColor = kMainColor;
    
    [self addTopView];
    
    if (self.isTeacher) {
        self.productSegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"讲解作品",@"创作作品"] delegate:self];
    }else
    {
        self.productSegmentControl = [[HYSegmentedControl alloc]initWithOriginX:0 OriginY:0 Titles:@[@"录音作品",@"创作作品"] delegate:self];
    }
    [self.productSegmentControl hideBottomView];
    [self.productSegmentControl hideSeparateLine];
    [self.navigationView.rightView addSubview:self.productSegmentControl];
    self.productSegmentControl.hidden = YES;
    self.productSegmentControl.SelectBlock = ^(NSInteger index, HYSegmentedControl *segmentControl) {
        if (index == 0) {
            weakSelf.dataArray = weakSelf.recordArray;
        }else
        {
            weakSelf.dataArray = weakSelf.createArray;
        }
        [weakSelf.tableView reloadData];
    };
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2 + 5, self.topView.hd_height + 15, kScreenWidth * 0.8 - 10, kScreenHeight - self.topView.hd_height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.tableView registerClass:[StudentProductTableViewCell class] forCellReuseIdentifier:kStudentProductCellID];
    [self.view addSubview:self.tableView];
}
- (void)refreshUIWith:(NSDictionary * )infoDic
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"chat_image_normal"]];
    self.studentNameLB.text = [infoDic objectForKey:kUserNickName];
    if ([[infoDic objectForKey:kgender] isEqualToString:@"男"]) {
        self.genderImageView.image = [UIImage imageNamed:@"sex_icon_boy"];
    }else
    {
        self.genderImageView.image = [UIImage imageNamed:@"sex_icon_girl"];
    }
    self.starLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"starCount"]];
    self.flowerLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"flowerCount"]];
    self.goldLB.text = [NSString stringWithFormat:@"%@", [infoDic objectForKey:@"prizeCount"]];
    
    if ([infoDic objectForKey:@"birthday"] && [[infoDic objectForKey:@"birthday"] length] > 0) {
        self.ageLB.text = [NSString stringWithFormat:@"%ld岁", [self getAgeWith:[infoDic objectForKey:@"birthday"]]];
    }else
    {
        self.ageLB.text = @"1岁";
    }
    
}

- (NSInteger)getAgeWith:(NSString *)birthdayStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate * birthDate = [formatter dateFromString:birthdayStr];
    
    NSCalendar * calendaar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;;
    NSDateComponents * cmp1 = [calendaar components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
    
    return cmp1.year;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.leftTableView isEqual:tableView]) {
        return self.leftDataArr.count;
    }else
    {
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.leftTableView isEqual:tableView]) {
        MainLeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainLeftCellID forIndexPath:indexPath];
        [cell resetWithInfoDic:self.leftDataArr[indexPath.row]];
        if ([indexPath isEqual:self.leftIndexPath]) {
            [cell selectReset];
        }
        return cell;
    }else
    {
        if (self.leftIndexPath.row == 0) {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
            [cell.contentView removeAllSubviews];
            
            
            NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
            UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(cell.hd_height / 2, 0, cell.hd_width / 2 - cell.hd_height / 2, cell.hd_height)];
            titleLB.text = [infoDic objectForKey:@"title"];
            titleLB.textColor = UIColorFromRGB(0x4e4e4e);
            [cell.contentView addSubview:titleLB];
            
            
            UILabel * contentLB = [[UILabel alloc]initWithFrame:CGRectMake(cell.hd_width / 2, 0, cell.hd_width / 2 - cell.hd_height * 0.8, cell.hd_height)];
            contentLB.textAlignment = NSTextAlignmentRight;
            contentLB.text = [infoDic objectForKey:@"content"];
            contentLB.textColor = UIColorFromRGB(0x4e4e4e);
            [cell.contentView addSubview:contentLB];
            
            UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.hd_height - 2, cell.hd_width, 2)];
            bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
            [cell.contentView addSubview:bottomView];
            return cell;
        }else
        {
            StudentProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kStudentProductCellID forIndexPath:indexPath];
            
            [cell resetWithInfoDic:self.dataArray[indexPath.row]];
            
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableView]) {
        
        if ([self.leftIndexPath isEqual:indexPath]) {
            return;
        }
        
        self.leftIndexPath = indexPath;
        if (indexPath.row == 0) {
            self.productSegmentControl.hidden = YES;
            self.topView.hidden = NO;
            self.tableView.frame = CGRectMake(kScreenWidth * 0.2 + 5, CGRectGetMaxY(self.topView.frame) + 15, kScreenWidth * 0.8 - 10, kScreenHeight  - self.topView.hd_height - 20);
            self.dataArray = self.basicArray;
        }else
        {
            self.productSegmentControl.hidden = NO;
            self.topView.hidden = YES;
            self.tableView.frame = CGRectMake(kScreenWidth * 0.2 + 5, CGRectGetMaxY(self.navigationView.frame) + 5, kScreenWidth * 0.8 - 10, kScreenHeight * 0.85 - 10);
            if (self.productSegmentControl.selectIndex == 0) {
                self.dataArray = self.recordArray;
            }else
            {
                self.dataArray = self.createArray;
            }
        }
        [self.tableView reloadData];
        [self.leftTableView reloadData];
    }else
    {
        NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
        self.selectProductInfo = infoDic;
        if (self.leftIndexPath.row == 1) {
            if (self.productSegmentControl.selectIndex == 1) {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyFriendProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }else
            {
                [SVProgressHUD show];
                [[UserManager sharedManager] didRequestMyRecordProductDetailWithWithDic:@{kProductId:[infoDic objectForKey:kProductId]} withNotifiedObject:self];
            }
        }
    }
}

#pragma mark - productDetail
- (void)didRequestMyRecordProductDetailSuccessed
{
    __weak typeof(self)weakSelf = self;
    [SVProgressHUD dismiss];
    NSLog(@"%@",[[UserManager sharedManager] getmyRecordProductDetailInfoDic]);
    
    if (self.isNotFromCommentTaskVC) {
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
        [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
        
        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
        vc.infoDic = infoDic;
        vc.model = [ProductionModel getRecordProductModelWith:[[UserManager sharedManager] getmyRecordProductDetailInfoDic]];
        vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        if (self.isTeacher) {
            if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
                vc.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
            }else
            {
                vc.commentTaskType = CommentTaskType_studentLookTeacherProduct;
            }
        }else if ([[self.infoDic objectForKey:kUserId] intValue] != [[UserManager sharedManager] getUserId])
        {
            vc.commentTaskType = CommentTaskType_studentLookStudent;
        }else
        {
            vc.commentTaskType = CommentTaskType_studentLookSelf;
        }
        vc.productType = ProductType_record;
        
        [self presentViewController:vc animated:NO completion:nil];
        
    }else
    {
        if (self.selectProductBlock) {
            self.selectProductBlock(ProductType_record);
        };
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    return;
    
}

- (void)didRequestMyRecordProductDetailFailed:(NSString *)failedInfo
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
    
    if (self.isNotFromCommentTaskVC) {
        
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
        [infoDic setObject:[self.selectProductInfo objectForKey:kuserWorkId] forKey:kuserWorkId];
        
        CommentTaskViewController * vc = [[CommentTaskViewController alloc]init];
        vc.infoDic = infoDic;
        vc.model = [ProductionModel getProductModelWith:[[UserManager sharedManager] getmyFriendProductDetailInfoDic]];
        vc.model.userWorkId = [[infoDic objectForKey:kuserWorkId] intValue];
        if (self.isTeacher) {
            if ([[UserManager sharedManager] getUserType] == UserType_teacher) {
                vc.commentTaskType = CommentTaskType_teacherLookTeacherOrStar;
            }else
            {
                vc.commentTaskType = CommentTaskType_studentLookTeacherProduct;
            }
        }else if ([[self.infoDic objectForKey:kUserId] intValue] != [[UserManager sharedManager] getUserId])
        {
            vc.commentTaskType = CommentTaskType_studentLookStudent;
        }else
        {
            vc.commentTaskType = CommentTaskType_studentLookSelf;
        }
        vc.productType = ProductType_create;
  
        [self presentViewController:vc animated:NO completion:nil];
        
    }else
    {
        if (self.selectProductBlock) {
            self.selectProductBlock(ProductType_create);
        };
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
    return;
    
    
}

- (void)didRequestMyFriendProductDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.tableView isEqual:tableView]) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.hd_width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel * titleLB = [self headLB:CGRectMake(0, 0, view.hd_width / 2, view.hd_height) andTitle:@"作品"];
        [view addSubview:titleLB];
        
        UILabel * nameLB = [self headLB:CGRectMake(CGRectGetMaxX(titleLB.frame), 0, view.hd_width / 3, view.hd_height) andTitle:@"时间"];
        [view addSubview:nameLB];
        
        UILabel * timeLB = [self headLB:CGRectMake(CGRectGetMaxX(nameLB.frame), 0, view.hd_width / 6, view.hd_height) andTitle:@"点评"];
        [view addSubview:timeLB];
        
        UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, view.hd_height - 2, view.hd_width, 2)];
        bottomView.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [view addSubview:bottomView];
        
        if (self.leftIndexPath.row == 0) {
            return nil;
        }
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        if (self.leftIndexPath.row == 0) {
            return 0;
        }
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.leftTableView]) {
        return kScreenHeight / 8;
    }
    return kScreenHeight * 0.14;
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
- (void)addTopView
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight * 0.24)];
    self.topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topView];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.topView.hd_height * 0.09, self.topView.hd_height * 0.12, self.topView.hd_height * 0.88, self.topView.hd_height * 0.88)];
    self.iconImageView.layer.cornerRadius = 10;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 5;
    self.iconImageView.image = [UIImage imageNamed:@"chat_image_normal"];
    [self.topView addSubview:self.iconImageView];
    
    self.studentNameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + self.topView.hd_height * 0.15, self.topView.hd_height * 0.12, self.topView.hd_height * 1.1, self.topView.hd_height * 0.16)];
    self.studentNameLB.text = @"千书堂测试";
    self.studentNameLB.textColor = UIColorFromRGB(0x515151);
    [self.topView addSubview:self.studentNameLB];
    
    self.genderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.studentNameLB.frame) + 5, self.studentNameLB.hd_y, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    self.genderImageView.layer.cornerRadius = self.genderImageView.hd_height / 2;
    self.genderImageView.layer.masksToBounds = YES;
    self.genderImageView.image = [UIImage imageNamed:@"protect_eye_bg"];
    
    self.ageLB = [[UILabel alloc]initWithFrame:CGRectMake(self.genderImageView.hd_centerX, self.genderImageView.hd_y, self.topView.hd_height * 0.5, self.topView.hd_height * 0.16)];
    self.ageLB.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.ageLB.text = @"1岁";
    self.ageLB.textAlignment = NSTextAlignmentRight;
    self.ageLB.textColor = UIColorFromRGB(0x515151);
    [self.topView addSubview:self.ageLB];
    
    [self.topView addSubview:self.genderImageView];
    
    UIImageView * starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.studentNameLB.hd_x, CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    starImageView.image = [UIImage imageNamed:@"star"];
    [self.topView addSubview:starImageView];
    
    self.starLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starImageView.frame) + 5, starImageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.starLB.textColor = UIColorFromRGB(0x0b0b0b);
    self.starLB.text = @"12";
    [self.topView addSubview:self.starLB];
    
    UIImageView * flowermageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starLB.frame), CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    flowermageView.image = [UIImage imageNamed:@"flower"];
    [self.topView addSubview:flowermageView];
    
    self.flowerLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(flowermageView.frame) + 5, flowermageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.flowerLB.textColor = UIColorFromRGB(0x0b0b0b);
    self.flowerLB.text = @"11";
    [self.topView addSubview:self.flowerLB];
    
    UIImageView * goldImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.flowerLB.frame), CGRectGetMaxY(self.studentNameLB.frame) + self.topView.hd_height * 0.1, self.topView.hd_height * 0.16, self.topView.hd_height * 0.16)];
    goldImageView.image = [UIImage imageNamed:@"medal_btn"];
    [self.topView addSubview:goldImageView];
    
    self.goldLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goldImageView.frame) + 5, goldImageView.hd_y, self.topView.hd_height, self.topView.hd_height * 0.16)];
    self.goldLB.text = @"10";
    self.goldLB.textColor = UIColorFromRGB(0x0b0b0b);
    [self.topView addSubview:self.goldLB];
    
    
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
