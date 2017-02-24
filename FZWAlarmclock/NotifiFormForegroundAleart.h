//
//  NotifiFormForegroundAleart.h
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/24.
//  Copyright © 2017年 IOS2. All rights reserved.
//

@import UIKit;

@interface NotifiFormForegroundAleart : UITableViewCell


- (void)showAleartNotificationConfigWithModels:(NSString*)title
                                      subTitle:(NSString*)subtitle
                                   bodyContent:(NSString*)body
                                   badgeNumber:(NSInteger)badgenumber
                                    soundNamed:(NSString*)soundname;

- (void)hiden;

@end
