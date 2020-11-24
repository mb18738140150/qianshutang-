//
//  CommonMacro.h
//  Accountant
//
//  Created by aaa on 2017/3/1.
//  Copyright © 2017年 tianming. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


#define isObjectNotNil(a) (a != nil)

#define kErrorMsg       @"errorMsg"

#define kPassword       @"password"
#define kAccount        @"account"

#define kDepartId                       @"departId"//校区id
#define kUserId                         @"userId"
#define kUserName                       @"userName"
#define kUserNickName                   @"nickName"
#define kUserHeaderImageUrl             @"icon"
#define kUserTelephone                  @"telephone"
#define kvalidityTime                   @"validityTime"
#define kgender                         @"gender"
#define kbirthday           @"birthday"
#define kCity               @"city"
#define kreceiveAddress     @"receiveAddress"
#define kreceivePhoneNumber @"receivePhoneNumber"
#define kreceiveName        @"receiveName"
#define kDeliveryState      @"deliveryState"
#define knotificationNoDisturb  @"notificationNoDisturb"

#define kScore              @"score"
#define kStarCount          @"starCount"
#define kFlowerCount        @"flowerCount"
#define kPrizeCount         @"prizeCount"
#define kmedalCount         @"medalCount"

#define kflowerNum          @"flowerNum"
#define kmedalNum           @"medalNum"
#define kstarNum            @"starNum"

#define kTime               @"time"
#define kRemark             @"remark"
#define kState              @"state"
#define kCost               @"cost"
#define kId                 @"id"
#define kContent            @"content"
#define kDayTime            @"dayTime"


#define kClassroomIcon             @"classroomIcon"
#define kClassroomName             @"classroomName"
#define kClassroomId               @"classroomId"

#define kMyIntegral                 @"myIntegral"
#define kMyConvertIntegral          @"convertIntegral"
#define kIntegralRulerImageStr      @"integralRulerImageStr"

#define kChangeIntegral             @"changeIntegral"
#define kChangeIntegralType         @"changeType"
#define kIntegralWay                @"way"

#define kLogId                      @"logId"//申请记录id
#define kPrizeId                    @"prizeId"
#define kPrizeName                  @"prizeName"
#define kPrizeIntegral              @"prizeIntegral"
#define kPrizeIntro                 @"prizeIntro"
#define kPrizeImageUrl              @"imageUrl"

#define kFriendId                   @"friendId"
#define kFriendName                 @"friendName"
#define kFriendIconImageUrl         @"friendIconImageUrl"
#define kAdditionInformation        @"additionInformation"

//#define kTaskTipTime        @"taskTipTime"
//#define kTaskTipContent     @"taskTipContent"
//#define kTaskTipId          @"taskTipId"
//
//#define kOtherMessageTime       @"otherMessageTime"
//#define kOtherMessageContent    @"otherMessageContent"
//#define kOtherMessageId         @"otherMessageId"

#define kProductId          @"productId"// 作品id
#define kProductIconUrl     @"productIconUrl"
#define kProductIcon        @"productIcon"
#define kProductName        @"productName"
#define kProductTime        @"productTime"
#define kIsHaveComment      @"isHaveComment"
#define kIsHaveRead         @"isHaveRead"
#define kPrductType         @"prductType"
#define kuserWorkId         @"userWorkId"// 作品作业id

#define kWorkLogId         @"workLogId"// 大作业
#define kWorkLogName       @"workLogName"
#define kWorkLogTime       @"workLogTime"
#define kWorkLogObj        @"workLogObj"


#define klogName            @"logName" // 作业记录id
#define kdoState            @"doState"// 作业状态
#define kIsOverdue          @"IsOverdue"// 是否过期
#define kcompleteDay        @"completeDay"

#define kpartId             @"partId"// 课文id
#define kpartName           @"partName"// 课文名称
#define kpartImg            @"partImg"// 课文封面
#define kpartCompleateNum   @"partCompleateNum"// 课文完成
#define kpartRemainNum      @"partRemainNum"// 课文剩余

#define kmadeId             @"madeId"// 创作作业id
#define kmadeName           @"madeName"// 创作作业名称
#define kmadeImg            @"madeImg"// 创作作业图片

#define kTaskId             @"taskId" // 暂时没用
#define kTaskName           @"taskName"
#define kTaskImageUrl       @"taskImageUrl"
#define kTaskType           @"taskType"

#define kCourseId           @"courseId"// 课程id
#define kCourseName         @"courseName"
#define kCourseType         @"courseType"
#define kTeacherName        @"teacherName"
#define kTotalSection       @"totalSection"
#define kComplateSection    @"complateSection"
#define kchapterId          @"chapterId"// 排课ID
#define kbeginendTime       @"beginendTime"


#define kattendanceCount    @"attendanceCount"// 出勤次数
#define kleaveCount         @"leaveCount"// 请假次数
#define kabsenteeism        @"absenteeism"// 旷课次数
#define kcostCount          @"costCount"// 课耗数量

#define kunitId             @"unitId"// 课节、单元id
#define kunitTitle          @"unitTitle"
#define kunitIntro          @"unitIntro"
#define kunitTime           @"unitTime"
#define kunitTeacher        @"unitTeacher"
#define kUnitName           @"unitName"

#define kitemName           @"itemName"// 课件名称
#define kitemId             @"itemId"// 课件id
#define kitemType           @"itemType"// 课件类型 1：课本 2：PPT 3：音频 4：视频
#define kitemImageUrl       @"itemImageUrl"// 课件图像链接

#define krecordUrl          @"recordUrl"

#define kVideoId            @"videoId"
#define kVideoUrl           @"videoUrl"
#define kVideoName          @"videoName"

#define kfileType           @"fileType"
#define kfileSrc            @"fileSrc"
#define kpageIndex          @"pageIndex"
#define kImgSrc             @"imgSrc"
#define kMP3Src             @"mp3Src"
#define kMP4Src             @"mp4Src"
#define kfileContent        @"fileContent"
#define kfileSort           @"fileSort"// 排序分组
#define ktextColor          @"textColor"
#define ktextTop            @"textTop"
#define ktextLeft           @"textLeft"
#define kgroupIcon          @"groupIcon"

#define kLeaveClassHour     @"leaveClassHour"
#define kClassHour          @"classHour"
#define kOrderId            @"orderId"


#define kReadLength         @"readLength"
#define kRecordLength       @"recordLength"
#define kHearLength         @"hearLength"
#define kStudyLengthId      @"studyLengthId"

#define kTimeLength         @"timeLength"
#define kReadTime           @"readTime"

#define kcategoryId         @"categoryId"// 课本分类
#define kcategoryName       @"categoryName"



#define kTextBookName       @"textBookName"
#define kTextBookImageUrl   @"textBookImageUrl"
#define kTextBookId         @"textBookId"


#define kTextName           @"textName"
#define kTextId             @"textId"
#define kTextImageUrl       @"textImageUrl"
#define kAudioPath         @"audioPath"

#define kAudioName          @"audioName"
#define kAudioId            @"audioId"

#define kHeadQuestionId     @"headQuestionId"
#define kHeadQuestionName   @"headQuestionName"
#define kNewHeadQuestionCount   @"newQuestionCount"
#define kHeadQuestionImageUrl   @"headQuestionImageUrl"
#define kQuestionId             @"questionId"
#define kQuestionName       @"questionName"
#define kQuestionImageUrl   @"questionImageUrl"
#define kBookmarkId         @"bookmarkId"

#define kselType            @"selType"
#define kmemberType         @"memberType"

#define kmp3FilePath        @"mp3FilePath"
#define kmp3FilePathLine        @"mp3FilePathLine"

#define kcolorStr           @"colorStr"
#define kBlack              @"black"
#define kWhite              @"white"
#define kRed                @"red"
#define kYellow             @"yellow"
#define kGreen              @"Green"
#define kBlue               @"blue"
#define kPurple             @"purple"
#define kPink               @"pink"


#define ktextReviewId       @"textReviewId"
#define ktextReview         @"textReview"
#define kisTextRead         @"isTextRead"
#define kmp3ReviewId        @"mp3ReviewId"
#define kmp3Review          @"mp3Review"
#define kisMp3Read          @"isMp3Read"

#define kmemberId           @"memberId"

#define kshareType          @"shareType"

#define kLoginName          @"kLoginName"
#define kLoginPwd           @"LoginPwd"

#define kbeginTime          @"beginTime"
#define kminite             @"minite"

#define ktempId             @"tempId"
#define ktempType           @"tempType"
#define kworkId             @"workId"
#define ktypeList              @"typeList"
#define ktypeId             @"typeId"
#define krepeatNum          @"repeatNum"
#define kbeginInfoId        @"beginInfoId"
#define kendInfoId          @"endInfoId"
#define kdayNum             @"dayNum"
#define kbookId             @"bookId"
#define kcoverImg           @"coverImg"
#define ktxtDescribe        @"txtDescribe"
#define kmp3Describe        @"mp3Describe"
#define kimagemp4Describe   @"imagemp4Describe"
#define kmaterImg           @"materImg"
#define kworkTempId         @"workTempId"
#define kendTime            @"endTime"
#define kgradeId            @"gradeId"

#define ktxtReview          @"txtReview"
#define kscore              @"score"
#define kmp3Review          @"mp3Review"
#define kintro              @"intro"

#define kworkTempId         @"workTempId"
#define kworkTempType       @"workTempType"

#define krepeatNum          @"repeatNum"
#define kendInfoId          @"endInfoId"
#define krepeatNum          @"repeatNum"
#define kbeginInfoId        @"beginInfoId"
#define kinfoId             @"infoId"











#define kDownloadTaskId                 @"downloadTaskId"

#define kNoteVideoNoteId                @"videoNoteId"
#define kNoteVideoNoteContent           @"videoNoteContent"

#define kAppUpdateInfoUrl               @"appUpdateInfoUrl"
#define kAppUpdateInfoVersion           @"appUpdateInfoVersion"
#define kAppUpdateInfoContent           @"appUpdateInfoContent"
#define kAppUpdateInfoIsForce           @"appUpdateInfoIsForce"

#define kDBErrorType_Mywrong            @"myWrong"
#define kDBErrorType_Easywrong          @"easyWrong"
#define kDBErrorType_Collect            @"colection"
#endif /* CommonMacro_h */

