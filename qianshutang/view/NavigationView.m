//
//  NavigationView.m
//  qianshutang
//
//  Created by aaa on 2018/7/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "NavigationView.h"

@interface NavigationView()

@property (nonatomic, strong)UIButton * iconImageView;

@property (nonatomic, strong)UIView * leftView;
@property (nonatomic, strong)UIButton * searchBtn;
@property (nonatomic, strong)UIButton * complateBtn;
@property (nonatomic, strong)UIButton * selectAllBtn;

@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic, strong)UIButton * deleteBtn;
@property (nonatomic, strong)UIButton * cleanBtn;

@property (nonatomic, strong)UIButton * saveBtn;

@property (nonatomic, strong)UIButton * playBtn;

@property (nonatomic, strong)UIView * latestView;
@property (nonatomic, strong)UIButton * latestBtn;
@property (nonatomic, strong)UIImageView * latestProductTypeImage;
@property (nonatomic, strong)UILabel * titleLB;

@property (nonatomic, strong)UIButton * quitBtn;
@property (nonatomic, strong)UIButton * shareAppBtn;
@property (nonatomic, strong)UIButton * explainBtn;
@property (nonatomic, strong)UIButton * addBtn;

@property (nonatomic, strong)UIView * operationView;
@property (nonatomic, strong)UIButton * operationBtn;
@property (nonatomic, strong)UIImageView * operationTypeImage;
@property (nonatomic, strong)UILabel * operationTitleLB;
@property (nonatomic, strong)UIButton * haveReadBtn;
@property (nonatomic, strong)UIButton * createBtn;
@property (nonatomic, strong)UIButton * commentBtn;

@property (nonatomic, strong)UIButton * arrangeBtn;
@property (nonatomic, strong)UIButton * todayBtn;

@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame withNavigationType:(NavigationType)type
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI:type];
    }
    
    return self;
    
}

- (void)prepareUI:(NavigationType)type
{
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.2, kScreenHeight * 0.15)];
    leftView.backgroundColor = UIColorFromRGB(0x56ab89);
    self.leftView = leftView;
    [self addSubview:self.leftView];
    
    self.iconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageView.frame = CGRectMake(15, 5, kScreenHeight * 0.15 - 10, kScreenHeight * 0.15 - 10);
    [self.iconImageView setImage:[UIImage imageNamed:@"back_btn_white"] forState:UIControlStateNormal];
    [leftView addSubview:self.iconImageView];
    [self.iconImageView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight * 0.15)];
    rightView.backgroundColor = [UIColor whiteColor];
    self.rightView = rightView;
    [self addSubview:self.rightView];
    
    switch (type) {
        case NavigationType_search:
            {
                [self prepareSelectView];
                self.selectAllBtn.hidden = YES;
                self.complateBtn.hidden = YES;
                
            }
            break;
        case NavigationType_select:
        {
            [self prepareSelectView];
        }
            break;
        case NavigationType_deleteAneShare:
        {
            [self prepareDeleteAndShareView];
        }
            break;
        case NavigationType_save:
        {
            [self prepareSaveView];
        }
            break;
        case NavigationType_shareAndPlay:
        {
            [self prepareshareAndPlay];
        }
            break;
        case NavigationType_deleteAndLatestProduct:
        {
            [self prepareDeleteAndLatestProduct];
        }
            break;
        case NavigationType_shareAndQuit:
        {
            [self prepareShareAndQuit];
        }
            break;
        case NavigationType_playBack:
        {
            [self preparePlayBack];
        }
            break;
        case NavigationType_searchAndCollect:
        {
            [self prepareSearchAndCollect];
        }
            break;
        default:
            break;
    }
    
}

- (void)prepareSearchAndCollect
{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.shareBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = kMainColor;
    self.shareBtn.layer.cornerRadius = self.shareBtn.hd_height / 2;
    self.shareBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = kMainColor;
    self.searchBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.searchBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.searchBtn];
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareShareAndQuit
{
    self.shareAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareAppBtn.frame = CGRectMake(kScreenWidth * 0.8 - (self.rightView.hd_height - 10) * 3.4 - 30, 5, (self.rightView.hd_height - 10) * 2.4, self.rightView.hd_height - 10);
    self.shareAppBtn.backgroundColor = kMainColor;
    [self.shareAppBtn setTitle:@"分享APP" forState:UIControlStateNormal];
    [self.shareAppBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareAppBtn.layer.cornerRadius = 5;
    self.shareAppBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.shareAppBtn];
    [self.shareAppBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.quitBtn.backgroundColor = kMainColor;
    self.quitBtn.layer.cornerRadius = self.quitBtn.hd_height / 2;
    self.quitBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.quitBtn];
    [self.quitBtn addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self prepareDeleteAndShareView];
    
    
    self.createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.createBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.createBtn setTitle:@"创建" forState:UIControlStateNormal];
    [self.createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.createBtn.backgroundColor = kMainColor;
    self.createBtn.layer.cornerRadius = self.createBtn.hd_height / 2;
    self.createBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.createBtn];
    [self.createBtn addTarget:self action:@selector(creatAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.explainBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.explainBtn setTitle:@"说明" forState:UIControlStateNormal];
    [self.explainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.explainBtn.backgroundColor = kMainColor;
    self.explainBtn.layer.cornerRadius = self.explainBtn.hd_height / 2;
    self.explainBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.explainBtn];
    [self.explainBtn addTarget:self action:@selector(explainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.backgroundColor = kMainColor;
    self.addBtn.layer.cornerRadius = self.addBtn.hd_height / 2;
    self.addBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.latestView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.12, 5, kScreenWidth * 0.12, self.rightView.hd_height - 10)];
    self.latestView.backgroundColor = kMainColor;
    self.latestView.layer.cornerRadius = 5;
    self.latestView.layer.masksToBounds = YES;
    [self.rightView addSubview:self.latestView];
    
    NSString * str = @"自定义";
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat totalWidth = textSize.width + 10 + 15;
    
    UILabel * titlaLB = [[UILabel alloc]initWithFrame:CGRectMake((self.latestView.hd_width - totalWidth) / 2, self.latestView.hd_height / 2 - 10, textSize.width, 20)];
    titlaLB.text = @"总榜";
    titlaLB.textAlignment = NSTextAlignmentRight;
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
    
    
    self.operationView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.12, 5, kScreenWidth * 0.12, self.rightView.hd_height - 10)];
    self.operationView.backgroundColor = kMainColor;
    self.operationView.layer.cornerRadius = 5;
    self.operationView.layer.masksToBounds = YES;
    [self.rightView addSubview:self.operationView];
    
    NSString * operationStr = @"管理";
    CGSize otextSize = [operationStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat ototalWidth = otextSize.width + 10 + 15;
    
    UILabel * otitlaLB = [[UILabel alloc]initWithFrame:CGRectMake((self.operationView.hd_width - ototalWidth) / 2, self.operationView.hd_height / 2 - 10, otextSize.width, 20)];
    otitlaLB.text = operationStr;
    otitlaLB.textColor = [UIColor whiteColor];
    self.operationTitleLB = otitlaLB;
    [self.operationView addSubview:self.operationTitleLB];
    
    self.operationTypeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(otitlaLB.frame) + 9, self.operationView.hd_height / 2 - 5, 15, 10)];
    self.operationTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
    [self.operationView addSubview:self.operationTypeImage];
    
    self.operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.operationBtn.frame = self.operationView.bounds;
    self.operationBtn.backgroundColor = [UIColor clearColor];
    self.operationBtn.layer.cornerRadius = 5;
    self.operationBtn.layer.masksToBounds = YES;
    [self.operationView addSubview:self.operationBtn];
    [self.operationBtn addTarget:self action:@selector(operationtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10 - kScreenWidth * 0.17, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = kMainColor;
    self.searchBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.searchBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.searchBtn];
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cleanBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10 - kScreenWidth * 0.17, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.cleanBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self.cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cleanBtn.backgroundColor = kMainColor;
    self.cleanBtn.layer.cornerRadius = self.cleanBtn.hd_height / 2;
    self.cleanBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.cleanBtn];
    [self.cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.haveReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.haveReadBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, self.rightView.hd_height - 10);
    self.haveReadBtn.backgroundColor = kMainColor;
    [self.haveReadBtn setTitle:@"设为已读" forState:UIControlStateNormal];
    [self.haveReadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.haveReadBtn.layer.cornerRadius = 5;
    self.haveReadBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.haveReadBtn];
    [self.haveReadBtn addTarget:self action:@selector(latestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.commentBtn setTitle:@"点评" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commentBtn.backgroundColor = kMainColor;
    self.commentBtn.layer.cornerRadius = self.commentBtn.hd_height / 2;
    self.commentBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.commentBtn];
    [self.commentBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.arrangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.arrangeBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.arrangeBtn setTitle:@"布置" forState:UIControlStateNormal];
    [self.arrangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.arrangeBtn.backgroundColor = kMainColor;
    self.arrangeBtn.layer.cornerRadius = self.commentBtn.hd_height / 2;
    self.arrangeBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.arrangeBtn];
    [self.arrangeBtn addTarget:self action:@selector(arrangeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [self.todayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.todayBtn.backgroundColor = kMainColor;
    self.todayBtn.layer.cornerRadius = self.commentBtn.hd_height / 2;
    self.todayBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.todayBtn];
    [self.todayBtn addTarget:self action:@selector(todayAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentBtn.hidden = YES;
    self.shareBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
    self.explainBtn.hidden = YES;
    self.latestView.hidden = YES;
    self.operationView.hidden = YES;
    self.searchBtn.hidden = YES;
    self.haveReadBtn.hidden = YES;
    self.createBtn.hidden = YES;
    self.addBtn.hidden = YES;
    self.arrangeBtn.hidden = YES;
    self.todayBtn.hidden = YES;
    self.cleanBtn.hidden = YES;
}



- (void)refreshWith:(userCenterItemType)userCenterItemType
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.usercenterItemType = userCenterItemType;
        self.commentBtn.hidden = YES;
        self.shareAppBtn.hidden = YES;
        self.quitBtn.hidden = YES;
        self.shareBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.explainBtn.hidden = YES;
        self.latestView.hidden = YES;
        self.operationView.hidden = YES;
        self.searchBtn.hidden = YES;
        self.haveReadBtn.hidden = YES;
        self.createBtn.hidden = YES;
        self.addBtn.hidden = YES;
        self.arrangeBtn.hidden = YES;
        self.todayBtn.hidden = YES;
        self.cleanBtn.hidden = YES;
        
        switch (userCenterItemType) {
            case userCenterItemType_quit:
            {
                self.shareAppBtn.hidden = NO;
                self.quitBtn.hidden = NO;
            }
                break;
            case userCenterItemType_shareAndDelete:
            {
                self.shareBtn.hidden = NO;
                self.deleteBtn.hidden = NO;
                self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.deleteBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_explainAndShare:
            {
                self.shareBtn.hidden = NO;
                self.explainBtn.hidden = NO;
                self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.explainBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_latest:
            {
                self.latestView.hidden = NO;
            }
                break;
            case userCenterItemType_addAndDelete:
            {
                self.addBtn.hidden = NO;
                self.deleteBtn.hidden = NO;
                self.deleteBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.addBtn.frame = CGRectMake(self.deleteBtn.hd_x - 15 - self.deleteBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_searchAndOperation:
            {
                self.searchBtn.hidden = NO;
                self.operationView.hidden = NO;
                self.searchBtn.frame = CGRectMake(kScreenWidth * 0.8 - 30 - self.rightView.hd_height + 10 - kScreenWidth * 0.12, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_delete:
            {
                if ([self.deleteBtn.titleLabel.text isEqualToString:@"取消"]) {
                    self.cleanBtn.hidden = NO;
                }
                    
                self.deleteBtn.hidden = NO;
                self.deleteBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.cleanBtn.frame = CGRectMake(self.deleteBtn.hd_x - 15 - self.deleteBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_haveRead:
            {
                self.haveReadBtn.hidden = NO;
            }
                break;
            case userCenterItemType_create:
            {
                self.createBtn.hidden = NO;
            }
                break;
            case userCenterItemType_comment:
            {
                self.commentBtn.hidden = NO;
            }
                break;
            case userCenterItemType_search:
            {
                self.searchBtn.hidden = NO;
                self.searchBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_creatAndSearch:
            {
                self.searchBtn.hidden = NO;
                self.createBtn.hidden = NO;
                self.searchBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.createBtn.frame = CGRectMake(self.searchBtn.hd_x - 15 - self.searchBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            case userCenterItemType_ArrangeAndCommentAndToday:
            {
                self.todayBtn.hidden = NO;
                self.commentBtn.hidden = NO;
                self.arrangeBtn.hidden = NO;
                self.commentBtn.frame = CGRectMake(self.todayBtn.hd_x - 15 - self.searchBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
                self.arrangeBtn.frame = CGRectMake(self.commentBtn.hd_x - 15 - self.searchBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
            }
                break;
            default:
                break;
        }
    });
    
}

- (void)refreshLatestViewWith:(NSString *)title
{
    self.titleLB.text = title;
}

- (void)backAction
{
    if (self.DismissBlock) {
        self.DismissBlock();
    }
}

- (void)preparePlayBack
{
    self.haveReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.haveReadBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, self.rightView.hd_height - 10);
    self.haveReadBtn.backgroundColor = kMainColor;
    [self.haveReadBtn setTitle:@"观看回放" forState:UIControlStateNormal];
    [self.haveReadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.haveReadBtn.layer.cornerRadius = self.haveReadBtn.hd_height / 2;
    self.haveReadBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.haveReadBtn];
    [self.haveReadBtn addTarget:self action:@selector(playBackAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareSelectView
{
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = kMainColor;
    self.searchBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.searchBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.searchBtn];
    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.complateBtn.frame = CGRectMake(self.searchBtn.hd_x - 15 - self.searchBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.complateBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.complateBtn.backgroundColor = kMainColor;
    self.complateBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.complateBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.complateBtn];
    [self.complateBtn addTarget:self action:@selector(complateAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(self.complateBtn.hd_x - 15 - self.complateBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectAllBtn.backgroundColor = kMainColor;
    self.selectAllBtn.layer.cornerRadius = self.searchBtn.hd_height / 2;
    self.selectAllBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.selectAllBtn];
    [self.selectAllBtn addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)prepareDeleteAndShareView
{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = kMainColor;
    self.shareBtn.layer.cornerRadius = self.shareBtn.hd_height / 2;
    self.shareBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = kMainColor;
    self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(DeleteAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)prepareSaveView
{
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveBtn.backgroundColor = kMainColor;
    self.saveBtn.layer.cornerRadius = self.saveBtn.hd_height / 2;
    self.saveBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.saveBtn];
    [self.saveBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareshareAndPlay
{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.backgroundColor = kMainColor;
    self.shareBtn.layer.cornerRadius = self.shareBtn.hd_height / 2;
    self.shareBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.shareBtn];
    [self.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtn.frame = CGRectMake(self.shareBtn.hd_x - 15 - self.shareBtn.hd_width * 1.4, 5, self.shareBtn.hd_width * 1.4, self.rightView.hd_height - 10);
//    [self.playBtn setTitle:@"作品" forState:UIControlStateNormal];
//    [self.playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"student_opus_n"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"student_opus_p"] forState:UIControlStateSelected];
    self.playBtn.backgroundColor = kMainColor;
    self.playBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.playBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)prepareDeleteAndLatestProduct
{
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor = kMainColor;
    self.deleteBtn.layer.cornerRadius = self.deleteBtn.hd_height / 2;
    self.deleteBtn.layer.masksToBounds = YES;
    [self.rightView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(DeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.latestView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, self.rightView.hd_height - 10)];
    self.latestView.backgroundColor = kMainColor;
    self.latestView.layer.cornerRadius = 5;
    self.latestView.layer.masksToBounds = YES;
    [self.rightView addSubview:self.latestView];
    
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
    
    
    self.titleLB.userInteractionEnabled = YES;
    self.latestProductTypeImage.userInteractionEnabled = YES;
    self.latestView.hidden = NO;
}

- (void)refreshTitleWith:(NSString *)text
{
    self.titleLB.text = text;
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

- (void)operationtAction:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self refreshLatestView_Nomal];
        if (self.cancelOperationBlock) {
            self.cancelOperationBlock(YES);
        }
        return;
    }
    
    button.selected = !button.selected;
    
    if (button.selected) {
        self.operationTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white_up"];
        if (self.OperationBlock) {
            self.OperationBlock(YES,self.operationView.frame);
        }
    }else
    {
        self.operationTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
        if (self.OperationBlock) {
            self.OperationBlock(NO,self.operationView.frame);
        }
    }
}


- (void)refreshLatestView_Delete
{
    self.searchBtn.hidden = YES;
    self.operationBtn.backgroundColor = kMainColor;
    [self.operationBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)refreshLatestView_Share
{
    [self.searchBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.operationBtn.backgroundColor = kMainColor;
    [self.operationBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)refreshLatestView_Nomal
{
    self.searchBtn.hidden = NO;
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    self.operationBtn.backgroundColor = [UIColor clearColor];
    [self.operationBtn setTitle:@" " forState:UIControlStateNormal];
    [self.operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


- (void)playBackAction:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (self.latestProductBlock) {
        self.latestProductBlock(YES,self.haveReadBtn.frame);
    }
}

- (void)showLatestBtn
{
    self.latestView.hidden = NO;
    self.latestView.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.17, 5, kScreenWidth * 0.17, self.rightView.hd_height - 10);
    NSString * str = @"最新作品";
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat totalWidth = textSize.width + 10 + 15;
    self.titleLB.text = str;
    self.titleLB.frame = CGRectMake((self.latestView.hd_width - totalWidth) / 2, self.latestView.hd_height / 2 - 10, textSize.width, 20);
    self.latestProductTypeImage.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 9, self.latestView.hd_height / 2 - 5, 15, 10);
    self.latestBtn.frame = self.latestView.bounds;
}

- (void)hideLatestBtn
{
    self.latestView.hidden = YES;
}

- (void)showDeleteAndLatestBtn
{
    self.deleteBtn.hidden = NO;
    self.latestView.hidden = NO;
    self.latestView.frame = CGRectMake(kScreenWidth * 0.8 - 16 - kScreenWidth * 0.12, 5, kScreenWidth * 0.12, self.rightView.hd_height - 10);
    self.deleteBtn.frame = CGRectMake(self.latestView.hd_x - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);
    
    NSString * str = @"最新";
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    CGFloat totalWidth = textSize.width + 10 + 15;
    self.titleLB.text = str;
    self.titleLB.frame = CGRectMake((self.latestView.hd_width - totalWidth) / 2, self.latestView.hd_height / 2 - 10, textSize.width, 20);
    self.latestProductTypeImage.frame = CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 9, self.latestView.hd_height / 2 - 5, 15, 10);
    self.latestBtn.frame = self.latestView.bounds;
    
}
- (void)hideDeleteBtn
{
    self.deleteBtn.hidden = YES;
}

- (void)hideSearchBtn
{
    self.searchBtn.hidden = YES;
}
- (void)hideCollectBtn
{
    self.shareBtn.hidden = YES;
}
- (void)showCollectBtn
{
    self.shareBtn.hidden = NO;
}

- (void)hidePlayBackBtn
{
    self.haveReadBtn.hidden = YES;
}

- (void)hideSelectAllBtn
{
    self.selectAllBtn.hidden = YES;
}

- (void)hideComplateBtn
{
    self.complateBtn.hidden = YES;
}

- (void)commentAction
{
    if (self.commentBlock) {
        self.commentBlock(@{});
    }
}

- (void)arrangeAction
{
    if (self.arrangeBlock) {
        self.arrangeBlock(@{});
    }
}

- (void)todayAction
{
    if (self.todayBlock) {
        self.todayBlock(@{});
    }
}

- (void)refreshLatestView
{
    self.latestBtn.selected = !self.latestBtn.selected;
    self.latestProductTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
}

- (void)refreshOperationView
{
    self.operationBtn.selected = !self.operationBtn.selected;
    self.operationTypeImage.image = [UIImage imageNamed:@"listen_play_icon_white"];
}

#pragma mark - 重置搜索状态
- (void)refreshSearchBtnWith:(BOOL)isSearch
{
    if (isSearch) {
        [self.searchBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    else
    {
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    }
}
- (void)refreshDeleteBtnWith:(BOOL)isDelete
{
    if (isDelete) {
        [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    else
    {
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    }
}
- (void)searchAction
{
    if ([self.searchBtn.titleLabel.text isEqualToString:@"确定"]) {
        if (self.sureShareListBlock) {
            self.sureShareListBlock(YES);
        }
        return;
    }
    if ([self.searchBtn.titleLabel.text isEqualToString:@"取消"]) {
        if (self.searchBlock) {
            self.searchBlock(NO);
        }
        return;
    }
    if (self.searchBlock) {
        self.searchBlock(YES);
    }
}

- (void)collectAction
{
    if (self.collectCourseBlock) {
        self.collectCourseBlock();
    }
}

- (void)complateAction
{
    if (self.complateBlock) {
        self.complateBlock();
    }
}

- (void)selectAllAction
{
    if (self.SelectAllBlock) {
        self.SelectAllBlock();
    }
}


- (void)shareAction:(UIButton *)button
{
    if (self.usercenterItemType == userCenterItemType_shareAndDelete) {
        button.selected = !button.selected;
        if (button.selected) {
            if (self.deleteBtn.selected) {
                self.deleteBtn.selected = NO;
                [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
                if (self.deleteBlock) {
                    self.deleteBlock(NO);
                }
            }
            [self.shareBtn setTitle:@"取消" forState:UIControlStateNormal];
            if (self.shareBlock) {
                self.shareBlock(YES);
            }
        }else
        {
            [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
            if (self.shareBlock) {
                self.shareBlock(NO);
            }
        }
        return;
    }
    
    
    if ([button isEqual:self.shareBtn] || [button isEqual:self.shareAppBtn]) {
        if (self.shareBlock) {
            self.shareBlock(YES);
        }
    }else if ([button isEqual:self.saveBtn])
    {
        if (self.saveBlock) {
            self.saveBlock();
        }
    }
}

- (void)DeleteAction:(UIButton *)button
{
    self.deleteBtn.selected = !self.deleteBtn.selected;
    if (self.deleteBtn.selected) {
        if (self.usercenterItemType == userCenterItemType_delete) {
            self.cleanBtn.hidden = NO;
        }
        if (self.usercenterItemType == userCenterItemType_shareAndDelete) {
            if (self.shareBtn.selected) {
                self.shareBtn.selected = NO;
                [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
                if (self.shareBlock) {
                    self.shareBlock(NO);
                }
            }
        }
        
        [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
        if (self.deleteBlock) {
            self.deleteBlock(YES);
        }
    }else
    {
        if (self.usercenterItemType == userCenterItemType_delete) {
            self.cleanBtn.hidden = YES;
        }
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        if (self.deleteBlock) {
            self.deleteBlock(NO);
        }
    }
    
}

- (void)cleanAction
{
    if (self.cleanBlock) {
        self.cleanBlock(YES);
    }
}

- (void)explainAction:(UIButton *)button
{
    if (self.explainBlock) {
        self.explainBlock();
    }
}

- (void)addAction:(UIButton *)button
{
    if (self.addBlock) {
        self.addBlock(@{});
    }
}

- (void)cancelDelete
{
    self.deleteBtn.selected = NO;
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
}

- (void)creatAction
{
    if (self.createBlock) {
        self.createBlock();
    }
}

- (void)playAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.playBlock) {
        self.playBlock();
    }
}

- (void)showSearch
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectAllBtn.hidden = YES;
        self.complateBtn.hidden = YES;
        self.searchBtn.hidden = NO;
    });
}

- (void)showSelectAllAndComplate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectAllBtn.hidden = NO;
        self.complateBtn.hidden = NO;
        self.complateBtn.frame = CGRectMake(kScreenWidth * 0.8 - 16 - self.rightView.hd_height + 10, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);;
        self.selectAllBtn.frame = CGRectMake(self.searchBtn.hd_x - 15 - self.searchBtn.hd_width, 5, self.rightView.hd_height - 10, self.rightView.hd_height - 10);;
        
        self.searchBtn.hidden = YES;
    });
}
- (void)resetBackView
{
    self.leftView.backgroundColor = [UIColor whiteColor];
    [self.iconImageView setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
}

- (void)quitAction
{
    if (self.quitBlock) {
        self.quitBlock();
    }
}

@end
