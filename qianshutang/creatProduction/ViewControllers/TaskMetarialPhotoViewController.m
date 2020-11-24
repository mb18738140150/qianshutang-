//
//  TaskMetarialPhotoViewController.m
//  qianshutang
//
//  Created by aaa on 2018/11/29.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "TaskMetarialPhotoViewController.h"

#define kImageTag 10000

@interface TaskMetarialPhotoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)NavigationView * navigationView;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)NSMutableArray * selectArray;

@end

@implementation TaskMetarialPhotoViewController

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    
    self.dataArray = [[[UserManager sharedManager] getTaskProbemContentInfo] objectForKey:@"materialList"];
    
    self.navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.15) withNavigationType:NavigationType_none];
    self.navigationView.DismissBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self.navigationView resetBackView];
    [self.view addSubview:self.navigationView];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(kScreenWidth * 0.8 - 10 - self.navigationView.rightView.hd_height, 5, self.navigationView.rightView.hd_height - 10, self.navigationView.rightView.hd_height - 10);
    [self.complateBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = self.complateBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.navigationView.rightView addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth * 0.3 - 100, 0, 200, self.navigationView.hd_height)];
    self.titleLB.textColor = kMainColor;
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = @"作业素材";
    self.titleLB.font = [UIFont systemFontOfSize:22];
    [self.navigationView.rightView addSubview:self.titleLB];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth / 3, kScreenHeight * 0.85 / 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.15, kScreenWidth, kScreenHeight * 0.85) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView removeAllSubviews];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.hd_width, cell.hd_height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = image;
    }];
    imageView.tag = kImageTag;
    [cell.contentView addSubview:imageView];
    
    UIImageView * selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.hd_width - 30, 10, 25, 25)];
    selectImageView.image = [UIImage imageNamed:@"ls_add_ok"];
    [cell.contentView addSubview:selectImageView];
    selectImageView.hidden = YES;
    
    for (NSDictionary * infoDic in self.selectArray) {
        if ([[infoDic objectForKey:@"imageUrl"] isEqualToString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]) {
            selectImageView.hidden = NO;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView * imageView = [cell.contentView viewWithTag:kImageTag];
    
    if (self.selectArray.count == 0) {
        NSDictionary * infoDic = @{@"imageUrl":[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"],@"imageData":imageView.image};
        [self.selectArray addObject:infoDic];
        [self.collectionView reloadData];
        return;
    }
    
    int index = 100;
    for (int i = 0; i < self.selectArray.count; i++) {
        NSDictionary * infoDic = self.selectArray[i];
        if ([[infoDic objectForKey:@"imageUrl"] isEqualToString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]]) {
            index = i;
            break;
        }
    }
    if (index != 100) {
        // 已选中的再次选中取消
        [self.selectArray removeObjectAtIndex:index];
    }else
    {
        NSDictionary * infoDic = @{@"imageUrl":[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"imageUrl"],@"imageData":imageView.image};
        [self.selectArray addObject:infoDic];
    }
    [self.collectionView reloadData];
}

- (void)complateAction
{
    if (self.TaskMetarialSelectComplateBlock) {
        self.TaskMetarialSelectComplateBlock(self.selectArray);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
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
