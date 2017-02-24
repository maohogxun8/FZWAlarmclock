//
//  NotifiFormForegroundAleart.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/24.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "NotifiFormForegroundAleart.h"
@import AudioToolbox;

@interface NotifiFormForegroundAleart()
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UILabel *subtitlelable;
@property (weak, nonatomic) IBOutlet UILabel *bodyLable;
@property (nonatomic,assign) SystemSoundID soundID;

@end

@implementation NotifiFormForegroundAleart

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, -84, FZWWIDTH, 84);
}

- (void)showAleartNotificationConfigWithModels:(NSString*)title
                                    subTitle:(NSString*)subtitle
                                 bodyContent:(NSString*)body
                                 badgeNumber:(NSInteger)badgenumber
                                  soundNamed:(NSString*)soundname{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.titlelable.text = title;
    self.subtitlelable.text = @"";
    self.bodyLable.text = body;
    NSLog(@"%@",soundname);
    NSString *pathc = [[NSBundle mainBundle] pathForResource:soundname ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:pathc];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &_soundID);
    AudioServicesPlayAlertSound(self.soundID);
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 20, FZWWIDTH, 84);
    }];
    [self performSelector:@selector(hiden) withObject:nil afterDelay:10];
}

- (void)hiden{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(0, -84, FZWWIDTH, 84);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
          }
    }];
}

@end
