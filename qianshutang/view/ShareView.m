//
//  ShareView.m
//  qianshutang
//
//  Created by aaa on 2018/9/8.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ShareView.h"
#import "BasicClassroomCollectionViewCell.h"
#define kBasicCellID @"BasicClassroomCollectionViewCellID"

@interface ShareView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame andShareType:(ShareType)type
{
    if (self = [super initWithFrame:frame]) {
        self.shareType = type;
        [self loadData];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backView = backView;
    [self addSubview:self.backView];
    
    UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resinAction)];
    [backView addGestureRecognizer:tap];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.55, kScreenWidth, kScreenHeight * 0.45)];
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.tipView.hd_width / 6, self.tipView.hd_width / 6);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tipView.hd_height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BasicClassroomCollectionViewCell class] forCellWithReuseIdentifier:kBasicCellID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.tipView addSubview:self.collectionView];
    
}


#pragma mark - collection delegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BasicClassroomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBasicCellID forIndexPath:indexPath];
    NSMutableDictionary * infoDic = [[NSMutableDictionary alloc]initWithDictionary:self.dataArr[indexPath.row]];
    
    [cell resetWith:infoDic];
    __weak typeof(self)weakSelf = self;
    cell.classroomClickBlock = ^(NSDictionary *infoDic) {
        NSLog(@"%@", infoDic);
        if (weakSelf.shareBlock) {
            weakSelf.shareBlock(infoDic);
        }
        [weakSelf removeFromSuperview];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.dataArr objectAtIndex:indexPath.row];
    if (self.shareBlock) {
        self.shareBlock(infoDic);
    }
     [self removeFromSuperview];
}

- (void)loadData
{
    self.dataArr = [NSMutableArray array];
    
    NSDictionary *weixinFriendDic = @{@"imageStr":@"share_wechat",@"title":@"微信好友",@"type":@(ShareObjectType_weixinFriend)};
    NSDictionary *FriendCircleDic = @{@"imageStr":@"share_wechatmoments",@"title":@"微信朋友圈",@"type":@(ShareObjectType_friendCircle)};
    NSDictionary *weixinCollectDic = @{@"imageStr":@"share_wechatfavorite",@"title":@"微信收藏",@"type":@(ShareObjectType_WeixinCollect)};
    NSDictionary *productShowDic = @{@"imageStr":@"share_works",@"title":@"作品秀",@"type":@(ShareObjectType_ProductShow)};
    NSDictionary *myFriendDic = @{@"imageStr":@"head_portrait",@"title":@"好友",@"type":@(ShareObjectType_MyFriend)};
    NSDictionary *classroomDic = @{@"imageStr":@"share_class",@"title":@"班级",@"type":@(ShareObjectType_classroom)};
    NSDictionary *tongbuDic = @{@"imageStr":@"share_class",@"title":@"同步到原文",@"type":@(ShareObjectType_tongbuyuanwen)};
    
    switch (self.shareType) {
        case ShareType_weixin:
            {
                [self.dataArr addObject:weixinFriendDic];
                [self.dataArr addObject:FriendCircleDic];
                [self.dataArr addObject:weixinCollectDic];
            }
            break;
        case ShareType_productShowAndWeixin:
        {
            [self.dataArr addObject:productShowDic];
            [self.dataArr addObject:weixinFriendDic];
            [self.dataArr addObject:FriendCircleDic];
            [self.dataArr addObject:weixinCollectDic];
        }
            break;
        case ShareType_friend:
        {
            [self.dataArr addObject:myFriendDic];
        }
            break;
        case ShareType_classroom_productShowAndWeixin:
        {
            [self.dataArr addObject:classroomDic];
            [self.dataArr addObject:productShowDic];
            [self.dataArr addObject:weixinFriendDic];
            [self.dataArr addObject:FriendCircleDic];
            [self.dataArr addObject:weixinCollectDic];
        }
            break;
        case ShareType__tongbuyuanwen_classroom_productShowAndWeixin:
        {
            [self.dataArr addObject:tongbuDic];
            [self.dataArr addObject:classroomDic];
            [self.dataArr addObject:productShowDic];
            [self.dataArr addObject:weixinFriendDic];
            [self.dataArr addObject:FriendCircleDic];
            [self.dataArr addObject:weixinCollectDic];
        }
            break;
        case ShareType_classroomAndFriend:
        {
            [self.dataArr addObject:classroomDic];
            [self.dataArr addObject:myFriendDic];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)resinAction
{
    [self removeFromSuperview];
}

@end
