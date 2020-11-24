//
//  SelectDayView.m
//  qianshutang
//
//  Created by aaa on 2018/8/31.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "SelectDayView.h"
#import "SelectDayCollectionViewCell.h"
#define kSelectDayCellID    @"SelectDayCollectionViewCell"


@interface SelectDayView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIButton * previousBtn;
@property (nonatomic, strong)UIButton * nextBtn;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSArray *weekdays;
@property (nonatomic, strong)NSDateFormatter * formatter;

@property (nonatomic, assign)int currentPage;

@property (nonatomic, strong)NSIndexPath * indexPath;

@property (nonatomic, strong)NSMutableArray * currentWeekCourseDataArray;

@end

@implementation SelectDayView

- (NSMutableArray *)currentWeekCourseDataArray
{
    if (!_currentWeekCourseDataArray) {
        _currentWeekCourseDataArray = [NSMutableArray array];
    }
    return _currentWeekCourseDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadData];
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn.frame = CGRectMake(0, self.hd_height / 2 - 10, 15, 20);
    [self.previousBtn setImage:[UIImage imageNamed:@"arrows_left"] forState:UIControlStateNormal];
    [self addSubview:self.previousBtn];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(self.hd_width - 20, self.hd_height / 2 - 10, 15, 20);
    [self.nextBtn setImage:[UIImage imageNamed:@"arrows_right"] forState:UIControlStateNormal];
    [self addSubview:self.nextBtn];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(self.hd_height, self.hd_height);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.previousBtn.frame) + 25, 0, self.hd_width - self.previousBtn.hd_width * 2 - 40, self.hd_height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[SelectDayCollectionViewCell class] forCellWithReuseIdentifier:kSelectDayCellID];
    [self addSubview:self.collectionView];
    
    self.currentPage = 0;
    
    [self.previousBtn addTarget:self action:@selector(previousAction) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - collectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectDayCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSelectDayCellID forIndexPath:indexPath];
    
    [cell resetWith:self.dataArray[indexPath.row]];
   
    // judge is Have course
    if (self.currentWeekCourseDataArray.count > indexPath.row) {
        NSDate * currentDate = [self.dataArray[indexPath.row] objectForKey:@"date"];
        for (NSDictionary * infoDic in self.currentWeekCourseDataArray) {
            NSString * dateStr = [infoDic objectForKey:@"day"];
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyy/MM/dd";
            
            NSString * currentDateStr = [formatter stringFromDate:currentDate];
            if ([dateStr isEqualToString:currentDateStr]) {
                if ([[infoDic objectForKey:@"isHaveCourse"] intValue] != 0) {
                    [cell isHaveCourse:YES];
                }else
                {
                    [cell isHaveCourse:NO];
                }
            }
        }
    }
    
    if ([self.indexPath isEqual:indexPath]) {
        [cell selectReset];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * infoDic = [self.dataArray objectAtIndex:indexPath.row];
    self.indexPath = indexPath;
    [self.collectionView reloadData];
    if (self.SelectDayBlock) {
        self.SelectDayBlock([infoDic objectForKey:@"date"]);
    }
}


- (void)resetTiday
{
    NSInteger currentWeekDay = [self getWeekDay:[NSDate date]];
    self.indexPath = [NSIndexPath indexPathForRow:currentWeekDay inSection:0];
    [self loadDataWithDate:[NSDate date]];
    
    if (self.SelectDayBlock) {
        self.SelectDayBlock([self.dataArray[currentWeekDay] objectForKey:@"date"]);
    }
}
// 刷新本周
- (void)refreshCurrentWeekCourse
{
    self.currentWeekCourseDataArray = [[[UserManager sharedManager] getCurrentWeekCourseList] mutableCopy];
    [self.collectionView reloadData];
}

- (void)loadData
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    self.formatter = formatter;
    formatter.dateFormat = @"yyyy/MM/dd";
    
    NSArray *weekdays = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    self.weekdays = weekdays;
    
    NSInteger currentWeekDay = [self getWeekDay:[NSDate date]];
    self.indexPath = [NSIndexPath indexPathForRow:currentWeekDay inSection:0];
    
    [self loadDataWithDate:[NSDate date]];
}


- (void)loadDataWithDate:(NSDate *)currentDate
{
    NSMutableArray * dateArray = [NSMutableArray array];
    NSInteger currentWeekDay = [self getWeekDay:currentDate];
    
    for (int i = 0; i < 7; i++) {
        NSDateComponents * components = [[NSDateComponents alloc]init];
        components.day = i - currentWeekDay;
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
        NSString * dateStr = [_formatter stringFromDate:nextDate];
        NSInteger weekDay = [self getWeekDay:nextDate];
        NSString * weekDayStr = [_weekdays objectAtIndex:weekDay];
        [dateArray addObject:@{@"weekDay":weekDayStr, @"dateStr":dateStr,@"date":nextDate}];
    }
    
    self.dataArray = dateArray;
    [self.collectionView reloadData];
}

- (void)previousAction
{
    self.currentPage--;
    NSDate *currentDate = [NSDate date];
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.day = self.currentPage * 7;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
    [self loadDataWithDate:nextDate];
    
    [self nWeekBlock:nextDate and:NO];
}


- (void)nextAction
{
    self.currentPage++;
    NSDate *currentDate = [NSDate date];
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.day = self.currentPage * 7;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
    [self loadDataWithDate:nextDate];
    
    [self nWeekBlock:nextDate and:YES];
}

- (void)nWeekBlock:(NSDate *)currentDate and:(BOOL)isNext
{
    NSInteger currentWeekDay = [self getWeekDay:currentDate];
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.day = 0 - currentWeekDay;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * nextDate = [calendar dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
    if (isNext) {
        if (self.nextWeekBlock) {
            self.nextWeekBlock(nextDate, currentDate);
        }
    }else
    {
        if (self.previousWeekBlock) {
            self.previousWeekBlock(nextDate, currentDate);
        }
    }
}

- (NSInteger )getWeekDay:(NSDate *)date
{
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return [comps weekday] - 1;
}

@end
