//
//  AppDelegate.m
//  qianshutang
//
//  Created by aaa on 2018/7/16.
//  Copyright © 2018年 mcb. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSDictionary+Unicode.h"
#import "NTESLoginViewController.h"
#import "NTESDemoConfig.h"
#import "NTESCustomAttachmentDecoder.h"
#import "NTESLoginManager.h"
#import "NTESEnterRoomViewController.h"
#import "NTESDataManager.h"
#import "NTESPageContext.h"
#import "NTESLogManager.h"
#import "NTESDemoService.h"

// wangyiyun App Key：31b1372756cba59207fcdbbe27061f46
// wangyiyun App Secret：9cfe9cf298d8

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define kWeixinAppID @"wxbac965fcfed5c36a"

#define kJiGuangAppKey @"991dec2f710401217a4c58d5"
#define kJiGuangChannel @"App Store"
#define kJiGuangApsForProduction 0

@interface AppDelegate ()<UserModule_LoginProtocol,JPUSHRegisterDelegate,UserModule_BindJPushProtocol,UNUserNotificationCenterDelegate, UserModule_BindJPushProtocol,WXApiDelegate>

@property (nonatomic, strong)NSTimer * noticeTimer;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [[DBManager sharedManager] intialDB];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:01]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
   [NSDictionary jr_swizzleMethod:@selector(description) withMethod:@selector(my_description) error:nil];
    
    [WXApi registerApp:kWeixinAppID];
    
    // 极光
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }else
    {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:kJiGuangAppKey
                          channel:kJiGuangChannel
                 apsForProduction:kJiGuangApsForProduction
            advertisingIdentifier:nil];
    
    
    
    //appkey是应用的标识，不同应用之间的数据（用户、消息、群组等）是完全隔离的。
    //如需打网易云信Demo包，请勿修改appkey，开发自己的应用时，请替换为自己的appkey.
    //并请对应更换Demo代码中的获取好友列表、个人信息等网易云信SDK未提供的接口。
    NSString *appKey = [[NTESDemoConfig sharedConfig] appKey];
    NSString *cerName= [[NTESDemoConfig sharedConfig] apnsCername];
    [[NIMSDK sharedSDK] registerWithAppID:appKey
                                  cerName:cerName];
    [NIMCustomObject registerCustomDecoder:[NTESCustomAttachmentDecoder new]];
    [[NIMKit sharedKit] setProvider:[NTESDataManager sharedInstance]];
    
    [[NTESLogManager sharedManager] start];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kAccount] && [[NSUserDefaults standardUserDefaults] objectForKey:kPassword]) {
        NSString * account = [[NSUserDefaults standardUserDefaults] objectForKey:kAccount];
        NSString * password = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
        [[UserManager sharedManager]loginWithUserName:account andPassword:password withNotifiedObject:self];
    }
    
    WXApiShareManager * sharemanager = [WXApiShareManager shareManager];
    
    
    
    return YES;
}

- (void)didUserLoginSuccessed
{
    NTESLoginData * loginData = [[NTESLoginManager sharedManager] currentNTESLoginData];
    if (loginData != nil) {
//        [self setupMainViewController];
        NSLog(@"***************登录网易云");
    }
}

- (void)didUserLoginFailed:(NSString *)failedInfo
{
    
}

- (void)setupMainViewController
{
    NTESLoginData *data = [[NTESLoginManager sharedManager] currentNTESLoginData];
    NSString *account = data.account;
    NSString *token = data.token;
    if ([account length] && [token length])
    {
        
        NSLog(@"account = %@ **** token = %@", account, token);
        
        [[[NIMSDK sharedSDK] loginManager] login:account token:token completion:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"登录成功");
            }else
            {
                NSLog(@"登录失败 error= %@", error);
            }
        }];
        [[NTESServiceManager sharedManager] start];
    }
//    [[NTESPageContext sharedInstance] setupMainViewController];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    NSString * registrationID = [JPUSHService registrationID];
    NSLog(@"registrationID = %@", registrationID);
    if (registrationID.length == 0) {
        self.noticeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollNotice) userInfo:nil repeats:YES];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
        [[UserManager sharedManager] didRequestBindJPushWithCID:registrationID withNotifiedObject:self];
    }
    
}
- (void)scrollNotice
{
    NSString * registrationID = [JPUSHService registrationID];
    if (registrationID.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
        [[UserManager sharedManager] didRequestBindJPushWithCID:registrationID withNotifiedObject:self];
        
        [self.noticeTimer invalidate];
        self.noticeTimer = nil;
    }
}

- (void)didRequestBindJPushSuccessed
{
    
}

- (void)didRequestBindJPushFailed:(NSString *)failedInfo
{
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)UIApplication:(UIApplication *)application setApplicationIconBadgeNumber:(NSInteger)number
{
    //    [JPUSHService setBadge:0];
    [application setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:");
        // {"ios":{"alert":"您的账户在别的设备上登录，您被迫下线!","badge":"1","sound":"default"}}
        
        [self oprationNotification:userInfo];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocalNitificationOfLivingStart object:@{@"key":@"直播开始了"}];
        
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:");
        [self oprationNotification:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocalNitificationOfLivingStart object:@{@"key":@"直播开始了"}];
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (void)oprationNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@", userInfo);
    if ([[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] containsString:@"被迫下线"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        
        [self loginOut];
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    NSLog(@"%@\n *** %@", content, extras);
}

#pragma mark - ChangeUserInfoDelegate
- (void)loginOut
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] logout];
    self.window.rootViewController = [[ViewController alloc] init];
}

// 支持窗口翻转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_allowRotation == YES) {
        if ([SoftManager shareSoftManager].isCamera) {
            return UIInterfaceOrientationMaskAll;
        }else
        {
            return UIInterfaceOrientationMaskLandscapeLeft;
        }
    }else
    {
        return (UIInterfaceOrientationMaskPortrait);
    }
    
}

@end
