//
//  CheckAndCommentTaskView.m
//  qianshutang
//
//  Created by aaa on 2018/8/24.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CheckAndCommentTaskView.h"
#import "CheckAndCommentTaskNumberTableViewCell.h"
#define kNumberCellID @"CheckAndCommentTaskNumberTableViewCell"
#import "CheckAndCommentTaskDetailTableViewCell.h"
#define kDetailCellID @"CheckAndCommentTaskDetailTableViewCell"

typedef enum : NSUInteger {
    CheckAndCommentTaskType_video,
    CheckAndCommentTaskType_moerduo,
    CheckAndCommentTaskType_read,
    CheckAndCommentTaskType_record,
    CheckAndCommentTaskType_create
} CheckAndCommentTaskType;

@interface CheckAndCommentTaskView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)UITableView * leftTableView;
@property (nonatomic, strong)NSMutableArray * studentDataArray;

@property (nonatomic, strong)UIScrollView * scrollVIew;
@property (nonatomic, strong)UITableView * rightTableView;
@property (nonatomic, strong)NSMutableArray * taskDetailDataArray;

@property (nonatomic,strong)NSMutableArray * videoArray;
@property (nonatomic, strong)NSMutableArray * createArray;
@property (nonatomic, strong)NSMutableArray * recordArray;
@property (nonatomic, strong)NSMutableArray * moerduoArray;
@property (nonatomic, strong)NSMutableArray * readArray;


@property (nonatomic, strong)UILabel * numberLB;
@property (nonatomic, strong)UILabel * nameLB;
@property (nonatomic, strong)UILabel * progressLB;

@property (nonatomic, strong)UILabel * videoLB;
@property (nonatomic, strong)UILabel * moerduoLB;
@property (nonatomic, strong)UILabel * readLB;
@property (nonatomic, strong)UILabel * recordLB;
@property (nonatomic, strong)UILabel * createLB;

@end


@implementation CheckAndCommentTaskView

- (NSMutableArray *)taskDetailDataArray
{
    if (!_taskDetailDataArray) {
        _taskDetailDataArray = [NSMutableArray array];
    }
    return _taskDetailDataArray;
}

- (NSMutableArray *)studentDataArray
{
    if (!_studentDataArray) {
        _studentDataArray = [NSMutableArray array];
    }
    return _studentDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.numberLB = [self getTitleLBWith:@"" andRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.nameLB = [self getTitleLBWith:@"" andRect:CGRectMake(CGRectGetMaxX(self.numberLB.frame) + 1, 0, kScreenWidth, kScreenHeight)];
    
    [self addSubview:self.numberLB];
    [self addSubview:self.nameLB];
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.numberLB.hd_height, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.leftTableView registerClass:[CheckAndCommentTaskNumberTableViewCell class] forCellReuseIdentifier:kNumberCellID];
    [self addSubview:self.leftTableView];
    
    self.scrollVIew = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 0, kScreenWidth, kScreenHeight)];
    [self addSubview:self.scrollVIew];
    
    self.progressLB = [self getTitleLBWith:@"" andRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    for (int i = 0; i < self.taskDetailDataArray.count; i++) {
        NSDictionary * taskInfoDic = [self.taskDetailDataArray objectAtIndex:i];
        UILabel * lb = [self getTitleLBWith:[taskInfoDic objectForKey:@""] andRect:CGRectMake(kScreenWidth * i + self.progressLB.hd_width, 0, kScreenWidth, kScreenHeight)];
        
    }
    
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.videoLB.hd_height, self.progressLB.hd_width + self.taskDetailDataArray.count * kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [self.rightTableView registerClass:[CheckAndCommentTaskDetailTableViewCell class] forCellReuseIdentifier:kDetailCellID];
    [self.scrollVIew addSubview:self.rightTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.leftTableView]) {
        return self.studentDataArray.count;
    }else
    {
        return self.taskDetailDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.leftTableView isEqual:tableView]) {
        CheckAndCommentTaskNumberTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNumberCellID forIndexPath:indexPath];
        
        return cell;
    }else
    {
        CheckAndCommentTaskDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kDetailCellID forIndexPath:indexPath];
        
        return cell;
    }
}


- (UILabel *)getTitleLBWith:(NSString *)title andRect:(CGRect)rect
{
    UILabel * lb = [[UILabel alloc]initWithFrame:rect];
    lb.backgroundColor = UIColorFromRGB(0xeeeeee);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = UIColorFromRGB(0x222222);
    
    return lb;
}

@end
