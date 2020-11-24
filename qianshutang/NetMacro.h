//
//  NetMacro.h
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#ifndef NetMacro_h
#define NetMacro_h

// 会计教练 // http://qst.tonyang.top
#define kRootUrl @"http://qst.tonyang.top/handle/getdata.ashx"
#define kDomainName  @"http://qst.tonyang.top"

#define kMD5String @"qianshutang"

#define kUploadRootUrl @"http://qst.kjjl100.com/handle/multiplefile.ashx"
//#define kUploadRootUrl @"http://f.kjb360.cn/UploadImg.ashx"

#define kNetError @"请检查网络连接"

#pragma mark - net paramaters
#define kCommand @"command"

#define kCommandRegist                  @"1000"
#define kCommandVerifyCode              @"1"
#define kCommandBindPhone               @"2"
#define kCommandLogin                   @"3"
#define kCommandVersionInfo             @"4"
#define kCommandMyClassroom             @"5"

#define kCommandMyIntegral              @"6"
#define kCommandMyIntegralRecord        @"7"
#define kCommandPrizeList               @"8"
#define kCommandConvertPrize            @"9"
#define kCommandConvertPrizeRecord      @"10"
#define kCommandCancelConvertPrize      @"11"
#define kCommandComplateConvertPrize    @"12"

#define kCommandSchoolNotification      @"13"
//#define kCommandTaskNotification        @"14"
#define kCommandFriendRequest           @"15"
#define kCommandAgreeFriendRequest      @"16"
#define kCommandRejectFriendRequest     @"17"
//#define kCommandOtherMessageNotification   @"18"

#define kCommandChangeIconImage         @"19"
#define kCommandChangeNickName          @"20"
#define kCommandResetPwd                @"21"
#define kCommandBindPhoneNumber         @"22"
#define kCommandChangeGender            @"23"
#define kCommandChangeBirthday          @"24"
#define kCommandChangeReceiveAddress    @"25"
#define kCommandNotificationNoDisturb   @"26"
#define kCommandLogout                  @"27"

#define kCommandMyProduct               @"28"
#define kCommandDeleteMyProduct         @"29"
#define kCommandShareMyProduct          @"30"
#define kCommandMyHeadTaskList          @"31"
#define kCommandMyEveryDayTaskDetailList        @"32" // 作业详情列表
#define kCommandMyEveryDayTask          @"33" // 每日作业
#define kCommandMyCourseList            @"35"
#define kCommandMyAttendanceList        @"36"
#define kCommandMyCourseCost            @"37"
#define kCommandBuyCourseRecord         @"38"
#define kCommandMyAchievementList       @"39"
#define kCommandMyStudyTimeLengthList   @"40"
#define kCommandMyStudyTimeLengthDetailList     @"41"
#define kCommandPunchCardList           @"42"

#define kCommandMyFriend                @"43"
#define kCommandMyFriendAchievementList @"44"
#define kCommandAddFriend               @"45"
#define kCommandDeleteFriend            @"46"
#define kCommandMyFriendInformation     @"47"
#define kCommandMyFriendProductList     @"48"

#define kCommandMyGroupList             @"50"

#define kCommandMyCollectionTextBook    @"51"
#define kCommandSearchMyCollectionTextBook      @"52"
#define kCommandDeleteMyCollectionTextBook      @"53"
#define kCommandMyBookmarkList          @"54"
#define kCommandDeleteMyBookmark        @"55"
#define kCommandClearnMyBookmarkList    @"56"
#define kCommandMyHeadQuestionList      @"57"
#define kCommandMyQuestionList          @"58"
#define kCommandMyQuestionDetail        @"59"
#define kCommandSetHaveReadQuestion     @"81"

#define kCommandClassMemberAchievementList      @"60"
#define kCommandClassTaskList           @"61"
#define kCommandClassMemberComplateTaskInfo     @"62"
#define kCommandClassTextbook           @"63"
#define kCommandClassCourseWare         @"64"
#define kCommandClassCourse             @"65"

#define kCommandProductShowList         @"66"
#define kCommandDeleteProductShowMyProduct      @"67"

#define kCommandReadList                @"70"
#define kCommandSearchReadList          @"71"
#define kCommandCollectTextBook         @"72"
#define kCommandTextBookContentList     @"73"
#define kCommandTextContent             @"74"

#define kCommandUploadWholeRecordProduct        @"75"
#define kCommandUploadPagingRecordProduct       @"76"
#define kCommandReadText                        @"78"
#define kCommandSubmitMoerduoAndReadTask        @"79"
#define kCommandSubmitCreateProduct             @"80"

#define kCommandClassMember             @"82"
#define kCommandClassTaskHaveComplate   @"83"

#define kCommandCreateTaskProblemContent        @"84"

#define kCommandMyCourse_BigCourseList  @"85"
#define kCommandCurrentWeekCourseList   @"86"
#define kCommandAgainUploadWholeRecordProduct   @"88"
#define kCommandMyRecordProductDetail   @"89"
#define kCommandMyFriendProductDetail   @"91"
#define kCommandClassMemberInformation  @"92"
#define kCommandBindJPush               @"100"

#define kTeacher_MyCourse               @"101"
#define kTeacher_sectionList            @"102"
#define kTeacher_sectionAttendance      @"103"
#define kTeacher_totalAttendance        @"104"
#define kTeacher_attendanceForm         @"105"
#define kTeacher_addCourseSection       @"106"
#define kTeacher_deleteCourseSection    @"107"
#define kTeacher_editCourseSection      @"108"
#define kTeacher_getTaskMould           @"109"
#define kTeacher_createSuiTangTask      @"110"
#define kTeacher_createXiLieTask        @"111"
#define kTeacher_createMetarial         @"112"
#define kTeacher_arrangeTask            @"113"
#define kTeacher_shareTaskMouldToschool @"114"
#define kTeacher_haveArrangeTask        @"115"
#define kTeacher_commentTaskList        @"116"
#define kTeacher_commentTask            @"117"
#define kTeacher_todayTaskComplateList  @"118"
#define kTeacher_studentHistoryTask     @"119"
#define kTeacher_addClassroomTextBook   @"120"
#define kTeacher_deleteClassroomTextBook        @"121"
#define kTeacher_sectionCallRoll        @"122"// 小节点名
#define kTeacher_classroomSign          @"123"
#define kTeacher_checkTask              @"124"
#define kTeacher_changeModulName        @"125"
#define kTeacher_changeModulRemark      @"126"
#define kTeacher_changeHaveArrangeModulName     @"127"
#define kTeacher_getSuitangDetail       @"128"
#define kTeacher_getXilieDetail         @"129"

#define kTeacher_getEditXilieModulDetail        @"130"
#define kTeacher_addSuitangModulType            @"131"
#define kTeacher_addXilieModulType              @"132"
#define kTeacher_deleteModul            @"133"


#define kTeacher_memberIntegralList     @"136"
#define kTeacher_haveSendIntegral       @"137"
#define kTeacher_createConvertPrizeRecord       @"138"
#define kTeacher_sendGoods              @"139"
#define kTeacher_changeSuitangMudulTextbook     @"140"
#define kTeacher_changeSuitangMudulrepeatCount  @"141"
#define kTeacher_getAddressInfo         @"142"
#define kTeacher_cancelConvertPrize     @"143"// 跟接口 11 重复

#define kTeacher_getTodayClassroomTask  @"144"
#define kTeacher_classroomAttendanceList        @"145"
#define kIsHaveNewMessage               @"146"
#define kTeacher_CommentModul           @"147"
#define kTeacher_addTextToCommentModul  @"148"
#define kTeacher_deleteCommentModul     @"149"
#define kTeacher_editHaveSendIntegralRemark      @"150"
#define kTeacher_deleteTaskModul        @"151"
#define kTeacher_collectSchoolTaskModul @"152"
#define kTeacher_deleteCollectTaskModul          @"153"
#define kTeacher_editStudentInfo_remark          @"154"
#define kTeacher_deleteHaveArrangeTask           @"155"
#define kTeacher_PriseAndflower         @"156"




#define kGetmainPageCategory            @"147"


#define kBindRegCode                    @"44"
#define kCommandcompleteUserInfo        @"41"
#define kCommandForgetPassword          @"39"
#define kCommandVerifyAccount           @"40"





#endif /* NetMacro_h */
