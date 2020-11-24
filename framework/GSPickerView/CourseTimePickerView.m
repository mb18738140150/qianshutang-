//
//  CourseTimePickerView.m
//  qianshutang
//
//  Created by aaa on 2018/8/27.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "CourseTimePickerView.h"

# define GSLog(fmt, ...) NSLog((@"[方法:%s____" "行:%d]\n " fmt),  __FUNCTION__, __LINE__, ##__VA_ARGS__);
/** 宽高*/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** window*/
#define kWindow [UIApplication sharedApplication].keyWindow

@interface CourseTimePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSArray *subTitles;
@property (nonatomic,strong)void(^sure)(NSInteger path,NSString *pathStr);
@property (nonatomic,strong)void(^cancle)(void);


@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic, strong)NSMutableArray * startTimeArray;
@property (nonatomic, strong)NSMutableArray * timeLengthArray;

@property (nonatomic,strong)UIPickerView *picker;
@property (nonatomic,assign)NSInteger selectedRow;

@property (nonatomic, assign)NSInteger selectStartTimeRow;
@property (nonatomic, assign)NSInteger selectTimeLengthRow;

@end


@implementation CourseTimePickerView

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 0, 60, 40);
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
- (void)cancleBtnAction{
    if (self.cancle) {
        self.cancle();
    }
    [self disAppear];
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(kScreenWidth - 70, 0, 60, 40);
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (void)sureBtnAction{
    if (self.sure) {
        NSString * startTime = self.startTimeArray[self.selectStartTimeRow];
        NSString * endTimeStr = [self endTime:startTime and:[self.timeLengthArray[self.selectTimeLengthRow] intValue]];
        
        self.sure(0, [NSString stringWithFormat:@"%@-%@-%d", startTime, endTimeStr,[self.timeLengthArray[self.selectTimeLengthRow] intValue]]);
    }
    [self disAppear];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth - 140, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 240, kScreenWidth, 240)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        [self addSubview:self.contentView];
        UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        topView.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:topView];
        
        
        [self.contentView addSubview:self.cancleBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sureBtn];
        [self.contentView addSubview:self.picker];
    }
    return self;
}

- (void)appearWithTitle:(NSString *)title subTitles:(NSArray *)subTitles selectedStr:(NSString *)selectedStr sureAction:(void(^)(NSInteger path,NSString *pathStr))sure cancleAction:(void(^)(void))cancle{
    _titleLabel.text = title;
    
    _subTitles = subTitles;
    _sure = sure;
    _cancle = cancle;
    
    [self loadData];
    
    [kWindow addSubview:self];
}
- (void)disAppear{
    [self removeFromSuperview];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth / 2;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0)
    {
        return [self.startTimeArray count];
        
    }
    else if (component == 1)
    {
        return self.timeLengthArray.count;
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _selectStartTimeRow = row;
    }
    else if (component == 1)
    {
        _selectTimeLengthRow = row;
    }
}
#pragma mark - UIPickerViewDatasource
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 150, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    
    if (component == 0)
    {
        pickerLabel.text =  [self.startTimeArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@分钟", [self.timeLengthArray objectAtIndex:row]];  // Month
    }
    
    return pickerLabel;
}


- (NSString * )endTime:(NSString *)startTimeStr and:(int )timeLength
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"aa HH:mm";
    
    NSDate * startTime = [dateFormatter dateFromString:startTimeStr];
    
    NSDateComponents * components = [[NSDateComponents alloc]init];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
        components.minute = timeLength;
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:startTime options:NSCalendarMatchStrictly];
        NSString * nextStr = [dateFormatter stringFromDate:nextDate];
    return nextStr;
}

- (void)loadData
{
    
    self.startTimeArray = [NSMutableArray array];
    self.timeLengthArray = [NSMutableArray array];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];

    dateFormatter.dateFormat = @"aa HH:mm";
    NSString * startTimeStr = @"上午 09:00";
    [self.startTimeArray addObject:startTimeStr];
    
    NSDate * startTime = [dateFormatter dateFromString:startTimeStr];
    
    
    NSDateComponents * components = [[NSDateComponents alloc]init];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    for (int i = 1; i< 145; i++) {
        components.minute = 5 * i;
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:startTime options:NSCalendarMatchStrictly];
        NSString * nextStr = [dateFormatter stringFromDate:nextDate];
        [self.startTimeArray addObject:nextStr];
    }
    
    for (int i = 1; i < 37; i++) {
        NSString * str = [NSString stringWithFormat:@"%d", i * 5];
        [self.timeLengthArray addObject:str];
    }
    
    [self.picker reloadAllComponents];
}

- (void)prepareUI
{
    
}

@end
