//
//  SetTimerUI.h
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/23.
//  Copyright © 2017年 IOS2. All rights reserved.
//

@import UIKit;
#import "TimerListTableViewCell.h"

typedef void(^SaveTimerBlock)(TimerCellModel *model);
@interface SetTimerUI : UIView

@property (nonatomic,copy)SaveTimerBlock timerSaveBlock;

@end
