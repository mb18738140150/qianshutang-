//
//  ClassroomAttendanceListTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/11/1.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "ClassroomAttendanceListTableViewCell.h"
#import "ClassroomAttendanceListView.h"

@interface ClassroomAttendanceListTableViewCell()

@property (nonatomic, strong)ClassroomAttendanceListView * classroomAttendanceListView;

@end

@implementation ClassroomAttendanceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) resetWithInfo:(NSDictionary *)infoDic andPage:(int)page
{
    [self.contentView removeAllSubviews];
    self.classroomAttendanceListView = [[ClassroomAttendanceListView alloc]initWithFrame:self.bounds];
    
    [self.classroomAttendanceListView refreshUIWith:infoDic andDataArray:[infoDic objectForKey:@"unitList"] andPage:page];
    [self.contentView addSubview:self.classroomAttendanceListView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
