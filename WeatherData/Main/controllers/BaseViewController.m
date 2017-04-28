//
//  BaseViewController.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/29.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    _currentPage = 0;
    //
    _getDataType = XXYGetDataNormalRefresh;
    //
    _isLoading = NO;
}
/**
 *  请求数据
 */
- (void)GetDataFromsever{}
#pragma mark - 刷新和加载 -
- (void)changeStatesText:(MJRefreshNormalHeader *)header{
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"即将进入刷新状态" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"刷新完毕" forState:MJRefreshStateNoMoreData];
    //更改状态颜色
    header.stateLabel.textColor = [UIColor brownColor];
    //更改显示时间颜色
    header.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
}
/**
 *  下拉刷新
 */
- (void)getDataHeaderRefresh{
    _getDataType = XXYGetDataHeaderRefresh;
    [self GetDataFromsever];
}
/*
 *  上拉加载
 */
- (void)getDataFooterRefresh{
    _getDataType = XXYGetDataFooterRefresh;
    [self GetDataFromsever];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
