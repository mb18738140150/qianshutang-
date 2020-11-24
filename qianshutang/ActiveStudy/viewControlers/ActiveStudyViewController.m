//
//  ActiveStudyViewController.m
//  qianshutang
//
//  Created by aaa on 2018/8/13.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ActiveStudyViewController.h"
#import "CreatProductionShowViewController.h"
#import "PublicTeachingMaterialViewController.h"
#import "MyClassroomViewController.h"

@interface ActiveStudyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIImageView * backImageView;
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ActiveStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"自主学习";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationView.hd_height, kScreenWidth, kScreenHeight - self.navigationView.hd_height)];
    self.backImageView.image = [UIImage imageNamed:@"course_bg"];
    [self.view addSubview:self.backImageView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenWidth / 8, kScreenHeight * 0.25, kScreenWidth / 4 * 3, kScreenHeight * 0.55) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView removeAllSubviews];
    UIImageView * imageView = [[UIImageView alloc]init];
    if (indexPath.row == 0) {
        imageView.frame = CGRectMake(15, 10, cell.hd_width - 20, cell.hd_height);
    }else if (indexPath.row == self.dataArray.count - 1)
    {
        imageView.frame = CGRectMake(5, 10, cell.hd_width - 20, cell.hd_height);
    }else
    {
        imageView.frame = CGRectMake(10, 10, cell.hd_width - 20, cell.hd_height);
    }
    imageView.image = (UIImage *)[self.dataArray objectAtIndex:indexPath.item];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        CreatProductionShowViewController * vc = [[CreatProductionShowViewController alloc]init];
        [self presentViewController:vc animated:NO completion:nil];
    }else if(indexPath.row == 3)
    {
        PublicTeachingMaterialViewController * vc = [[PublicTeachingMaterialViewController alloc]init];
        vc.materialType = MaterialType_public;
        [self presentViewController:vc animated:NO completion:nil];
    }else if (indexPath.row == 0)
    {
        PublicTeachingMaterialViewController * vc = [[PublicTeachingMaterialViewController alloc]init];
        vc.materialType = MaterialType_read;
        [self presentViewController:vc animated:NO completion:nil];
    }else
    {
        MyClassroomViewController * vc = [[MyClassroomViewController alloc]init];
        vc.classroomType = MyClassroomType_Metarial;
        [self presentViewController:vc animated:NO completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 4 - 0.5, kScreenHeight * 0.47);
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:[UIImage imageNamed:@"read_btn_phone"]];
//    [self.dataArray addObject:[UIImage imageNamed:@"material_btn_phone"]];
    [self.dataArray addObject:[UIImage imageNamed:@"teaching_material_btn_phone"]];
    [self.dataArray addObject:[UIImage imageNamed:@"create_btn_phone"]];
    
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
