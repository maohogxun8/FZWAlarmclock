//
//  FWZLocationNotification.h
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/22.
//  Copyright © 2017年 IOS2. All rights reserved.
//

@import Foundation;
@import UserNotifications;

@class TimerFormaterModel;
@interface FWZLocationNotification : NSObject



/**
 *  初始化
 */
+ (instancetype)shareLocationNotification;

/**
 *  添加通知定时
 *
 *  @param title       通知标题
 *  @param subtitle    通知副标题
 *  @param body        通知主题
 *  @param badgenumber 角标
 *  @param soundname   通知提示音
 *  @param timerModels 定时数组
 */
- (void)registerNotificationConfigWithModels:(NSString*)title
                                  subTitle:(NSString*)subtitle
                               bodyContent:(NSString*)body
                               badgeNumber:(NSInteger)badgenumber
                                soundNamed:(NSString*)soundname
                               TimerModels:(NSMutableArray<TimerFormaterModel *> *)timerModels;
/**
 *  删除通知定时
 *
 *  @param requertIdentifier 标示符 <weekday:hour:minu>
 */
- (void)deleteNotificationWithNotificationRequertIdentifier:(NSArray<NSString*>*)requertIdentifier;
@end


@interface TimerFormaterModel : NSObject

@property (nonatomic,copy)NSString *weekDay;
@property (nonatomic,copy)NSString *hource;
@property (nonatomic,copy)NSString *minu;
@property (nonatomic,copy)NSString *identifier;

@end
