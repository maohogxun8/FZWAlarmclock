//
//  ViewController.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/22.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "ViewController.h"
#import "SetTimerUI.h"
#import "FWZLocationNotification.h"
#import "TimerListTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listTabView;
@property (strong, nonatomic) NSMutableArray *listDataArray;
@property (strong, nonatomic) FWZLocationNotification *location;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SetTimerUI *settimteview = [[NSBundle mainBundle]loadNibNamed:@"SetTimerUI" owner:nil options:nil].firstObject;
    settimteview.frame = CGRectMake(0, 10, FZWWIDTH, 300);
    self.listDataArray = [NSMutableArray array];
    self.location = [FWZLocationNotification shareLocationNotification];
    WeakSelf;
    settimteview.timerSaveBlock = ^(TimerCellModel *model){
        [weakSelf.listDataArray addObject:model];
        [weakSelf.listTabView reloadData];
        [weakSelf.location registerNotificationConfigWithModels:nil subTitle:nil bodyContent:nil badgeNumber:0 soundNamed:nil TimerModels:[model TimerAarrayRemovingAndMergingWithTimerArray:weakSelf.listDataArray]];
    };
    [self.listTabView registerNib:[UINib nibWithNibName:@"TimerListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TimerListTableViewCell"];
    [self.view addSubview:settimteview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    TimerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerListTableViewCell" forIndexPath:indexPath];
    cell.timerListModel = self.listDataArray[indexPath.row];
    cell.isSwitchChangeState = ^(UITableViewCell *cell,BOOL isSwitchState){
        NSIndexPath *ind = [tableView indexPathForCell:cell];
        TimerCellModel *modle = self.listDataArray[ind.row];
        modle.isOpen = isSwitchState;
        [weakSelf.location registerNotificationConfigWithModels:nil subTitle:nil bodyContent:nil badgeNumber:0 soundNamed:nil TimerModels:[modle TimerAarrayRemovingAndMergingWithTimerArray:weakSelf.listDataArray]];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.location registerNotificationConfigWithModels:nil subTitle:nil bodyContent:nil badgeNumber:0 soundNamed:nil TimerModels:[self.listDataArray.firstObject TimerAarrayRemovingAndMergingWithTimerArray:self.listDataArray]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
