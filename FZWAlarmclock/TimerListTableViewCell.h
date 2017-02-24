//
//  TimerListTableViewCell.h
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/23.
//  Copyright © 2017年 IOS2. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "FWZLocationNotification.h"

@class TimerCellModel;
typedef void(^SwitchChangeState)(UITableViewCell *cell,BOOL isState);
@interface TimerListTableViewCell : UITableViewCell
@property (nonatomic,strong)TimerCellModel *timerListModel;
@property (nonatomic,copy)SwitchChangeState isSwitchChangeState;

@end

@interface TimerCellModel : NSObject
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSArray *weekDayArray;
@property (nonatomic,assign)BOOL isNotify;
@property (nonatomic,assign)BOOL isSound;

/**
 *  模型转换
 *
 *  @param timerModels 定时列表模型数组
 *
 *  @return 通知专用模型数组
 */
- (NSMutableArray<TimerFormaterModel *>*)TimerAarrayRemovingAndMergingWithTimerArray:(NSMutableArray<TimerCellModel*> *)timerModels;

@end
