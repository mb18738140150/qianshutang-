//
//  MoerduoView.h
//  qianshutang
//
//  Created by aaa on 2018/7/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoerduoView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView * playBackView;
@property (nonatomic, strong)UIImageView * backImageView;

@property (nonatomic, strong)UIButton * playBtn;
@property (nonatomic, strong)UIButton * previousBtn;
@property (nonatomic, strong)UIButton * nextBtn;
@property (nonatomic, strong)UILabel * titleLB;
@property (nonatomic, strong)UILabel * unitTitleLB;
@property (nonatomic, strong)UILabel * currentTimeLB;
@property (nonatomic, strong)UILabel * totalTimeLB;
@property (nonatomic, strong)UISlider * pregressSlider;

@property (nonatomic, strong)UIButton * addBtn;
@property (nonatomic, strong)UIButton * timerBtn;
@property (nonatomic, strong)UITableView * playListtableView;

@property (nonatomic, strong)NSMutableArray * musicList;

@property (nonatomic, assign)BOOL isTask;//是否是作业

@property (nonatomic, strong)UIButton * circleTypeBtn;
@property (nonatomic, strong)UIButton * cancelBtn;
@property (nonatomic, strong)UIButton * deleteBtn;


@property (nonatomic, copy)void(^dismissBlock)();
@property (nonatomic, copy)void(^AddMusicBlock)();


@property (nonatomic, copy)void(^DoMoerduoTaskComplate)(NSDictionary * infoDic);

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame andInfo:(NSArray *)audioList;

- (void)refreshUI;


@end
