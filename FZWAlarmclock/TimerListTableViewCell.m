//
//  TimerListTableViewCell.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/23.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "TimerListTableViewCell.h"

@interface TimerListTableViewCell()
@property (weak, nonatomic) IBOutlet UISwitch *switchTimer;
@property (weak, nonatomic) IBOutlet UILabel *timerLable;
@property (weak, nonatomic) IBOutlet UILabel *timerWeekLable;
@property (weak, nonatomic) IBOutlet UILabel *waringTypeLable;

@end

@implementation TimerListTableViewCell
- (IBAction)switchStateChage:(UISwitch *)sender {
    if (self.isSwitchChangeState) {
        self.isSwitchChangeState(self,sender.isOn);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTimerListModel:(TimerCellModel *)timerListModel{
    _timerListModel = timerListModel;
    [self.switchTimer setOn:timerListModel.isOpen animated:YES];
    self.timerLable.text = timerListModel.title;
    NSString *str = @"";
    for (NSString *day in timerListModel.weekDayArray) {
        str = [str stringByAppendingString:day];
    }
    self.timerWeekLable.text = str;
    self.waringTypeLable.text = [NSString stringWithFormat:@"推送：%@, 声音:%@",timerListModel.isNotify?@"开":@"关",timerListModel.isSound?@"开":@"关"];
}

@end

@implementation TimerCellModel

- (NSMutableArray<TimerFormaterModel *>*)TimerAarrayRemovingAndMergingWithTimerArray:(NSMutableArray<TimerCellModel*> *)timerModels{
    NSMutableArray<TimerFormaterModel *> *arr = [NSMutableArray array];
    NSMutableSet *set = [NSMutableSet set];
    for (TimerCellModel *model in timerModels) {
        if (model.isOpen) {
            for (NSString*weakDay in model.weekDayArray) {
                NSString *idfin = @"";
                if ([weakDay isEqualToString:@"日"]) {
                    idfin = [NSString stringWithFormat:@"1:%@",model.title];
                }else if ([weakDay isEqualToString:@"一"]){
                    idfin = [NSString stringWithFormat:@"2:%@",model.title];
                }else if ([weakDay isEqualToString:@"二"]){
                    idfin = [NSString stringWithFormat:@"3:%@",model.title];
                }else if ([weakDay isEqualToString:@"三"]){
                    idfin = [NSString stringWithFormat:@"4:%@",model.title];
                }else if ([weakDay isEqualToString:@"四"]){
                    idfin = [NSString stringWithFormat:@"5:%@",model.title];
                }else if ([weakDay isEqualToString:@"五"]){
                    idfin = [NSString stringWithFormat:@"6:%@",model.title];
                }else if ([weakDay isEqualToString:@"六"]){
                    idfin = [NSString stringWithFormat:@"7:%@",model.title];
                }
                [set addObject:idfin];
            }
        }
    }
    
    [set enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        TimerFormaterModel *modl = [[TimerFormaterModel alloc]init];
        modl.identifier = obj;
        [arr addObject:modl];
        NSLog(@"%@",obj);
    }];
    
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        TimerFormaterModel*one = (TimerFormaterModel*)obj1;
        TimerFormaterModel*two = (TimerFormaterModel*)obj2;
        return one.identifier > two.identifier;
    }];
    return arr;
}

@end
