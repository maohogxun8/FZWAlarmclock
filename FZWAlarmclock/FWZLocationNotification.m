//
//  FWZLocationNotification.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/22.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "FWZLocationNotification.h"

@interface FWZLocationNotification()

@property (nonatomic,assign)BOOL isRegisterSuccessed;

@end

@implementation FWZLocationNotification

+ (instancetype)shareLocationNotification{
    static FWZLocationNotification *location = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!location) {
            location = [[FWZLocationNotification alloc]init];
        }
    });
    return location;
}

- (void)registerNotificationConfigWithModels:(NSString *)title
                                    subTitle:(NSString *)subtitle
                                 bodyContent:(NSString *)body
                                 badgeNumber:(NSInteger)badgenumber
                                  soundNamed:(NSString *)soundname
                                 TimerModels:(NSMutableArray<TimerFormaterModel *> *)timerModels{
    
    if (!timerModels.count) {
        return;
    }
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllPendingNotificationRequests];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"request authorization successed!");
            [self createNotificationContentWithTitle:nil subTitle:nil bodyContent:nil badgeNumber:0 soundNamed:nil TimerModels:timerModels];
        }
    }];
   
}

- (BOOL)getIsRegisterSuccessed{
    return self.isRegisterSuccessed;
}

/**
 *  新建通知内容对象
 */
- (void)createNotificationContentWithTitle:(NSString*)title subTitle:(NSString*)subtitle bodyContent:(NSString*)body badgeNumber:(NSInteger)badgenumber soundNamed:(NSString*)soundname TimerModels:(NSMutableArray<TimerFormaterModel *> *)timerModels{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title =title?title:@"iOS10通知";
    content.subtitle =subtitle?subtitle:@"新通知学习笔记";
    content.body =body?body:@"新通知变化很大，之前本地通知和远程推送是两个类，现在合成一个了。这是一条测试通知，";
    content.badge = badgenumber>0?[NSNumber numberWithInteger:badgenumber]:nil;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:soundname?soundname:@"two.m4a"];
    content.sound = sound;
    for (TimerFormaterModel *model in timerModels) {
        [self addToNotificationCenterWithNotificationRequest:[self createUNNotificationRequestWithNotificationContent:content NotificationTrigger: [self createTriggersWithDateArray:model] requertIdentifier:model.identifier]];
    }
}

/**
 *  创建请求对象
 *
 *  @param content           通知内容
 *  @param Trigger           触发时间
 *  @param requertIdentifier 通知identifier
 *
 *  @return 请求对象
 */
- (UNNotificationRequest*)createUNNotificationRequestWithNotificationContent:(UNMutableNotificationContent*)content
                                                         NotificationTrigger:(UNNotificationTrigger*)Trigger
                                                           requertIdentifier:(NSString*)requertIdentifier {
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:Trigger];
    return request;
}

/**
 *  添加请求到通知中心
 *
 *  @param request 请求对象
 */
- (void)addToNotificationCenterWithNotificationRequest:(UNNotificationRequest*)request{
    //第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
        
    }];
}

/**
 *  从通知中心删除请求
 *
 *  @param requertIdentifier 通知identifier
 */
- (void)deleteNotificationWithNotificationRequertIdentifier:(NSArray<NSString*>*)requertIdentifier{
    [[UNUserNotificationCenter currentNotificationCenter]removePendingNotificationRequestsWithIdentifiers:requertIdentifier];
}

- (UNNotificationTrigger*)createTriggersWithDateArray:(TimerFormaterModel *)model{
        NSDateComponents *components = [[NSDateComponents alloc] init];
        if (model.weekDay) {
            components.weekday = [model.weekDay integerValue];
        }
        if (model.hource) {
            components.hour = [model.hource integerValue];
        }
        if (model.minu) {
            components.minute = [model.minu integerValue]; // components 日期
        }
        UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    return calendarTrigger;
}

@end

@implementation TimerFormaterModel

- (NSString *)identifier{
    if (!_identifier) {
        _identifier = [NSString stringWithFormat:@"%@:%@:%@",self.weekDay,self.hource,self.minu];
    }
    return _identifier;
}

- (NSString *)weekDay{
    if (!_weekDay) {
        if (7 <= self.identifier.length) {
            _weekDay = [self.identifier substringWithRange:NSMakeRange(0, 1)];
        }
    }
    return _weekDay;
}

- (NSString *)hource{
    if (!_hource) {
        if (7 <= self.identifier.length) {
            _hource = [self.identifier substringWithRange:NSMakeRange(2, 2)];
        }
    }
    return _hource;

}

- (NSString *)minu{
    if (!_minu) {
        if (7 <= self.identifier.length) {
            _minu = [self.identifier substringWithRange:NSMakeRange(5, 2)];
        }
    }
    return _minu;
}

@end
