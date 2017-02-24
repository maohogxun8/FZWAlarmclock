//
//  SetTimerUI.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/23.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "SetTimerUI.h"

@interface SetTimerUI()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIButton *optionBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak, nonatomic) IBOutlet UIView *waringTypeView;
@property (weak, nonatomic) IBOutlet UISwitch *notifiSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (nonatomic,strong) NSMutableArray *pickArray;
@property (nonatomic,strong) NSMutableArray *collickViewArray;

@property (nonatomic,copy) NSString *selectHour;
@property (nonatomic,copy) NSString *selectMinu;
@property (weak, nonatomic) IBOutlet UIView *weekTypeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *warningTypeHight;
@property (nonatomic,strong)NSMutableArray *selectWeakArray;

@end

@implementation SetTimerUI

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initPickData];
    [self initCollickData];
    
}

- (void)initPickData{
    self.selectWeakArray = [NSMutableArray array];
    self.pickArray = [NSMutableArray array];
    self.selectHour = @"00";
    self.selectMinu = @"00";
    NSMutableArray *hourceArr = [NSMutableArray array];
    NSMutableArray *minuArr = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [hourceArr addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [hourceArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    for (int j = 0;  j < 60; j++) {
        if (j < 10) {
            [minuArr addObject:[NSString stringWithFormat:@"0%d",j]];
        }else{
            [minuArr addObject:[NSString stringWithFormat:@"%d",j]];
        }
    }
    [self.pickArray addObject:hourceArr];
    [self.pickArray addObject:minuArr];
}

- (void)initCollickData{
    self.collickViewArray = [NSMutableArray arrayWithArray:@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]];
    self.selectWeakArray = [NSMutableArray arrayWithArray:self.collickViewArray];
    for (int i = 0; i<self.collickViewArray.count; i++) {
        UIButton *bton = [[UIButton alloc]initWithFrame:CGRectMake(20+(FZWWIDTH-40)/7*i, 0, (FZWWIDTH-40)/7-1, 30)];
        bton.tag = 3000+i;
        bton.layer.borderWidth = 1;
        bton.layer.borderColor = [UIColor grayColor].CGColor;
        bton.selected = YES;
//        bton.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0f green:arc4random()%254/255.0f  blue:arc4random()%254/255.0f  alpha:1.0];
        [bton setTitle:self.collickViewArray[i] forState:UIControlStateNormal];
        [bton addTarget:self action:@selector(selectWeakActionBton:) forControlEvents:UIControlEventTouchUpInside];
        [bton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [bton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.weekTypeView addSubview:bton];
    }

}

- (void)selectWeakActionBton:(UIButton *)bton{
    bton.selected = !bton.selected;
    if (bton.selected) {
        if (![self.selectWeakArray containsObject:self.collickViewArray[bton.tag - 3000]]) {
            [self.selectWeakArray addObject: self.collickViewArray[bton.tag - 3000]];
        }
    }else{
        if ([self.selectWeakArray containsObject:self.collickViewArray[bton.tag - 3000]]) {
            [self.selectWeakArray removeObject:self.collickViewArray[bton.tag - 3000]];
        }
    }
    NSLog(@"%@",self.selectWeakArray);
}

- (IBAction)changeNotifiAction:(UISwitch *)sender {
}

- (IBAction)changeSoundAction:(id)sender {
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.pickArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *arr = self.pickArray[component];
    return arr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.frame.size.width/2;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickArray[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.selectHour = self.pickArray[component][row];
            break;
        case 1:
            self.selectMinu = self.pickArray[component][row];
            break;
        default:
            break;
    }
}

- (IBAction)optionClick:(UIButton *)sender {
    
    if (sender.selected) {
        self.warningTypeHight.constant = 65;
    }else{
        self.warningTypeHight.constant = 0;
    }
    sender.selected = !sender.selected;
    self.waringTypeView.hidden = sender.selected;

}

- (IBAction)saveBtnClick:(UIButton *)sender {
    TimerCellModel *modle = [[TimerCellModel alloc]init];
    modle.isOpen = YES;
    modle.title = [NSString stringWithFormat:@"%@:%@",self.selectHour,self.selectMinu];
    modle.weekDayArray = [NSArray arrayWithArray:self.selectWeakArray];
    modle.isSound = self.soundSwitch.isOn;
    modle.isNotify = self.notifiSwitch.isOn;
    if (self.timerSaveBlock) {
        self.timerSaveBlock(modle);
    }
    
}

@end
