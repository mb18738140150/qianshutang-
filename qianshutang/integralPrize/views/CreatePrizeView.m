//
//  CreatePrizeView.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CreatePrizeView.h"


@interface CreatePrizeView()

@property (nonatomic, strong)UIView * tipView;

@property (nonatomic, strong)UIButton * storeBtn;
@property (nonatomic, strong)UIButton * sureBtn;




@property (nonatomic, strong)GSPickerView * pickerView;

@end
@implementation CreatePrizeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    __weak typeof(self)weakSelf = self;
    self.backgroundColor = [UIColor clearColor];
    UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:backView];
    
    self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.55, kScreenHeight * 0.9)];
    self.tipView.center = self.center;
    self.tipView.backgroundColor = [UIColor whiteColor];
    self.tipView.layer.cornerRadius = 8;
    self.tipView.layer.masksToBounds = YES;
    [self addSubview:self.tipView];
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tipView.hd_width, self.tipView.hd_height * 0.125)];
    tipLB.text = @"创建兑奖记录";
    tipLB.backgroundColor = kMainColor;
    tipLB.textColor = [UIColor whiteColor];
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.tipView addSubview:tipLB];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.083 - 15, 0, self.tipView.hd_width * 0.083, tipLB.hd_height - 10);
    [closeBtn setImage:[UIImage imageNamed:@"close_chat_btn_green"] forState:UIControlStateNormal];
    [self.tipView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectMemberView = [[CreatePrizeSelectView alloc]initWithFrame:CGRectMake(0, tipLB.hd_height, self.tipView.hd_width, self.tipView.hd_height * 0.21)];
    self.selectMemberView.titleLB.text = @"兑奖人:";
    self.selectMemberView.contentTF.placeholder = @"选择兑奖人";
    self.selectMemberView.selectBlock = ^{
        if (weakSelf.selectStudentBlock) {
            weakSelf.selectStudentBlock();
        }
    };
    [self.tipView addSubview:self.selectMemberView];
    
    
    self.selectPrizeView = [[CreatePrizeSelectView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectMemberView.frame), self.tipView.hd_width, self.tipView.hd_height * 0.21)];
    self.selectPrizeView.titleLB.text = @"奖品:";
    self.selectPrizeView.contentTF.placeholder = @"选择奖品";
    self.selectPrizeView.selectBlock = ^{
        if (weakSelf.selectPrizeBlock) {
            weakSelf.selectPrizeBlock();
        }
    };
    [self.tipView addSubview:self.selectPrizeView];
    
    self.selectTimeView = [[CreatePrizeSelectView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectPrizeView.frame), self.tipView.hd_width, self.tipView.hd_height * 0.21)];
    self.selectTimeView.titleLB.text = @"发货时间:";
    self.selectTimeView.contentTF.placeholder = @"今天";
    self.selectTimeView.selectBlock = ^{
        [weakSelf addStartDayTimeAcion];
    };
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * str = [formatter stringFromDate:[NSDate date]];
    self.createPrizeSendTime = str;
    
    [self.tipView addSubview:self.selectTimeView];
    
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(self.tipView.hd_width - self.tipView.hd_width * 0.116 - self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.84, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.114);
    self.sureBtn.backgroundColor = kMainColor;
    [self.sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.sureBtn];
    
    self.storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.storeBtn.frame = CGRectMake(self.tipView.hd_width * 0.116, self.tipView.hd_height * 0.84, self.tipView.hd_width * 0.265, self.tipView.hd_height * 0.114);
    self.storeBtn.backgroundColor = kMainColor;
    [self.storeBtn setTitle:@"立即发货" forState:UIControlStateNormal];
    [self.storeBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.storeBtn.layer.cornerRadius = 5;
    self.storeBtn.layer.masksToBounds = YES;
    [self.tipView addSubview:self.storeBtn];
    
    [self.sureBtn addTarget:self action:@selector(complateAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.storeBtn addTarget:self action:@selector(storeAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetSelectArrayWith:(NSArray *)array
{
    self.selectStudentArray = array;
    NSString * title = @"";
    self.selectStudentIdsStr = @"";
    for (int i = 0; i < array.count; i++) {
        NSDictionary * infoDic = [array objectAtIndex:i];
        if (i == 0) {
            title = [infoDic objectForKey:kUserName];
            self.selectStudentIdsStr = [NSString stringWithFormat:@"%@", [infoDic objectForKey:kUserId]];
        }else
        {
            title = [title stringByAppendingString:[NSString stringWithFormat:@",%@", [infoDic objectForKey:kUserName]]];
            self.selectStudentIdsStr = [self.selectStudentIdsStr stringByAppendingString:[NSString stringWithFormat:@",%@", [infoDic objectForKey:kUserId]]];
        }
    }
    if ([title isEqualToString:@""]) {
        self.selectMemberView.contentLB.hidden = YES;
        self.selectMemberView.contentLB.text = title;
    }else{
        self.selectMemberView.contentLB.hidden = NO;
        self.selectMemberView.contentLB.text = title;
    }
}

- (void)resetSelectPrizeInfoWith:(NSDictionary *)infoDic
{
    self.createPeize_prizeInfo = infoDic;
    self.selectPrizeView.contentTF.text = [infoDic objectForKey:kPrizeName];
}

- (void)complateAction
{
    if ([self isCanSend]) {
        if (self.complateBlock) {
            self.complateBlock(YES);
        }
    }
}

- (void)cancelAction
{
    if (self.cancelBlock) {
        self.cancelBlock(YES);
    }
}

- (void)storeAction
{
    if ([self isCanSend]) {
        if (self.storeBlock) {
            self.storeBlock(YES);
        }
    }
}

- (BOOL)isCanSend
{
    if (self.selectStudentIdsStr.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先选择兑奖人"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    if (![self.createPeize_prizeInfo objectForKey:kPrizeId]) {
        [SVProgressHUD showInfoWithStatus:@"请先选择奖品"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return NO;
    }
    return YES;
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.bounds];
    }
    return _pickerView;
}

- (void)addStartDayTimeAcion
{
    __weak typeof(self)weakSelf = self;
    [self.pickerView appearWithTitle:@"选择日期(北京时间)" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:nil sureAction:^(NSInteger path, NSString *pathStr) {
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        
        NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
        formatter1.dateFormat = @"yyyy年MM月dd日";
        
        NSDate * date = [formatter1 dateFromString:pathStr];
        NSString * currentDateStr = [formatter stringFromDate:date];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.selectTimeView.contentTF.text = [self judgeDate:currentDateStr];
            weakSelf.createPrizeSendTime = currentDateStr;
            if (weakSelf.selectTimeBlock) {
                weakSelf.selectTimeBlock(currentDateStr);
            }
            
        });
        
        [weakSelf.pickerView removeFromSuperview];
        
    } cancleAction:^{
        
    }];
}

- (NSString *)judgeDate:(NSString *)dateStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString * str = [formatter stringFromDate:[NSDate date]];
    if ([str isEqualToString:dateStr]) {
        return @"今天";
    }else
    {
        return dateStr;
    }
}

- (NSString *)getWeekDay:(NSDate *)date
{
    NSArray *weekdays = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return weekdays[[comps weekday] - 1];
}


@end
