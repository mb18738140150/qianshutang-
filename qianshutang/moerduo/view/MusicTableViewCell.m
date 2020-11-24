//
//  MusicTableViewCell.m
//  qianshutang
//
//  Created by aaa on 2018/7/22.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell

- (NSMutableArray *)timeLengthArray
{
    if (!_timeLengthArray) {
        _timeLengthArray = [NSMutableArray array];
    }
    return _timeLengthArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)resetWith:(NSDictionary *)infoDic
{
    self.infoDic = infoDic;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView removeAllSubviews];
    [self.timeLengthArray removeAllObjects];
    
    self.numberLB = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
    self.numberLB.textAlignment = NSTextAlignmentCenter;
    self.numberLB.textColor = UIColorFromRGB(0x4a494c);
    self.numberLB.font = kMainFont;
    [self.contentView addSubview:self.numberLB];
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.numberLB.frame) + 5, 0, self.hd_width - 120, 40)];
    self.titleLB.textColor = UIColorFromRGB(0x4a494c);
    self.titleLB.font = kMainFont;
    self.titleLB.text = [infoDic objectForKey:@"title"];
    [self.contentView addSubview:self.titleLB];
    
    self.totalTimeLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLB.frame) + 5, 0, 70, 40)];
    self.totalTimeLB.textColor = UIColorFromRGB(0x999999);
    self.totalTimeLB.font = kMainFont;
    self.totalTimeLB.text = [infoDic objectForKey:@"time"];
    [self.contentView addSubview:self.totalTimeLB];
 
    self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 15, 15)];
    self.selectImageView.image = [UIImage imageNamed:@"listen_play_icon"];
    [self.contentView addSubview:self.selectImageView];
    self.selectImageView.hidden = YES;
    
    self.deleteImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.totalTimeLB.hd_x + 5, 5, 30, 30)];
    self.deleteImageView.image = [UIImage imageNamed:@"listen_cross"];
    [self.contentView addSubview:self.deleteImageView];
    self.deleteImageView.hidden = YES;
    self.deleteImageView.userInteractionEnabled = YES;
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, self.hd_width, 1)];
    seperateView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.contentView addSubview:seperateView];
    
    UITapGestureRecognizer * deleteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAction)];
    [self.deleteImageView addGestureRecognizer:deleteTap];
    CGFloat timeLength = 0.0;
    
    NSArray * audioArray = [infoDic objectForKey:@"audioInfos"];
    if (self.isTask) {
        audioArray = [infoDic objectForKey:@"partMp3List"];
        for (int i = 0; i < audioArray.count; i++) {
            NSDictionary * audioInfo = [audioArray objectAtIndex:i];
            
            NSString * urlStr = [audioInfo objectForKey:@"mp3Url"];
            if ([urlStr containsString:kDomainName]) {
            }else
            {
                urlStr = [NSString stringWithFormat:@"%@%@",kDomainName, [audioInfo objectForKey:@"mp3Url"]];
            }
            
            NSURL * urlResult=[NSURL URLWithString:urlStr];
            
            AVURLAsset*audioAsset = [AVURLAsset URLAssetWithURL:urlResult options:nil];
            
            CMTime audioDuration = audioAsset.duration;
            
            float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
            [self.timeLengthArray addObject:@(audioDurationSeconds)];
            
            timeLength += audioDurationSeconds;
            
        }
    }else
    {
        for (int i = 0; i < audioArray.count; i++) {
            NSDictionary * audioInfo = [audioArray objectAtIndex:i];
            NSString*docDirPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString*filePath=[NSString stringWithFormat:@"%@/%@.mp3",docDirPath, [audioInfo objectForKey:kAudioId]];
            
            NSURL * urlResult=[NSURL fileURLWithPath:filePath];
            
            AVURLAsset*audioAsset = [AVURLAsset URLAssetWithURL:urlResult options:nil];
            
            CMTime audioDuration = audioAsset.duration;
            
            float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
            [self.timeLengthArray addObject:@(audioDurationSeconds)];
            
            timeLength += audioDurationSeconds;
            
        }
    }
   
   
    self.totalTimeLength = timeLength;
    int min = (int)timeLength / 60;
    int sec = (int)timeLength % 60;
    
    NSString * minStr = @"";
    NSString * secStr = @"";
    if (min > 9) {
        minStr = [NSString stringWithFormat:@"%d", min];
    }else
    {
        minStr = [NSString stringWithFormat:@"0%d", min];
    }
    if (sec > 9) {
        secStr = [NSString stringWithFormat:@"%d", sec];
    }else
    {
        secStr = [NSString stringWithFormat:@"0%d", sec];
    }
    self.totalTimeLB.text = [NSString stringWithFormat:@"%@:%@", minStr, secStr];
}

- (void)selectReset:(BOOL)isPlaying
{
    self.numberLB.hidden = YES;
    self.selectImageView.hidden = NO;
    self.titleLB.textColor = kMainColor;
    self.totalTimeLB.textColor = kMainColor;
    if (isPlaying) {
        self.selectImageView.image = [UIImage imageNamed:@"listen_suspend_icon"];
    }else
    {
        self.selectImageView.image = [UIImage imageNamed:@"listen_play_icon"];
    }
}

- (void)deleteReset
{
    self.deleteImageView.hidden = NO;
    self.totalTimeLB.hidden = YES;
}

- (void)deleteAction
{
    if (self.deleteMusicBlock) {
        self.deleteMusicBlock(self.infoDic);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
