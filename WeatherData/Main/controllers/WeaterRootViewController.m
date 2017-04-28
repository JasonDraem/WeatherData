//
//  WeaterRootViewController.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "WeaterRootViewController.h"
#import "UIColor+XXYExtension.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "XXYRequestManager.h"
#import "XXYRequestManager+CityListProxy.h"
#import "CityModel.h"
/** 导航栏高度 */
#define kNavigationBarHeight        64

@interface WeaterRootViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    MBProgressHUD *_hud;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *titleArr;
@end

@implementation WeaterRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    //[self GetDataFromsever];
    //[self.view addSubview:self.tableview];
    //[self beginRefreshData];
    [self.tableview.mj_header beginRefreshing];
}

- (void)GetDataFromsever{
    weakify(self)
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    
    if (0 == self.dataSource.count) {
        [self showMBProgress:@"loading......"];
    }
    NSString *sessionId = @"00004016b3e14bbea40c1aa1a14c2273a35352";
    [XXYRequestManager getCityListWithSessionId:sessionId backReasult:^(NSArray * reusltArr, NSError *error) {
        strongify(self)
        _isLoading = NO;
        if (XXYGetDataHeaderRefresh == _getDataType) {
            [self.tableview.mj_header endRefreshing];
        }
        
        if (XXYGetDataHeaderRefresh == _getDataType) {
            [self.dataSource removeAllObjects];
            [self.titleArr removeAllObjects];
        }
        for (ReusltModel *resultModel in reusltArr) {
                [strong_self.dataSource addObject:resultModel.city_list];
            
            if (![strong_self.titleArr containsObject:resultModel.begin_key]) {
                [strong_self.titleArr addObject:resultModel.begin_key];
            }
            }
            [strong_self.tableview reloadData];
        
        _getDataType = XXYGetDataNormalRefresh;
        [strong_self dismissMBProgress];
    }];
}

/**
 *  懒加载tableview
 *
 *  @return <#return value description#>
 */
- (UITableView*)tableview{
    weakify(self)
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, XXYScreenW, XXYScreenH - kNavigationBarHeight) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        //
        //设置索引文字颜色
        //0x646464
        _tableview.sectionIndexColor = [UIColor colorWithHexString:@"0x646464"];
        //设置索引背景颜色
        _tableview.sectionIndexBackgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_tableview];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak_self getDataHeaderRefresh];
        }];
        self.tableview.mj_header = header;
        //更改默认刷新提示语
        [self changeStatesText:header];
    }
    return _tableview;
}
/**
 *  tableView refresh
 */
- (void)beginRefreshData{
    weakify(self)
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self getDataHeaderRefresh];
    }];
    self.tableview.mj_header = header;
    //更改默认刷新提示语
    [self changeStatesText:header];
    //开始刷新
    [self.tableview.mj_header beginRefreshing];
}
/**
 *  懒加载datasource
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
/**
 *  标题数组
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc] init];
    }
    return _titleArr;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    CityListModel *model = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.city_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityListModel *model = self.dataSource[indexPath.section][indexPath.row];
    
    [SVProgressHUD showSuccessWithStatus:model.city_name maskType:SVProgressHUDMaskTypeClear];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
}
/**
 *  组标题labelHeight
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *grouTitle = [[UILabel alloc] init];
    grouTitle.backgroundColor = [UIColor clearColor];
    grouTitle.userInteractionEnabled = NO;
    grouTitle.text = self.titleArr[section];
    return grouTitle;
}
/**
 *  右侧字母排序列表
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArr;
}

- (void)showMBProgress:(NSString *)text{
//    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _hud.label.text = text;
//    _hud.backgroundColor = [UIColor grayColor];
    
    
    [SVProgressHUD showWithStatus:text];
    
}

- (void)dismissMBProgress{
//    [_hud hideAnimated:YES afterDelay:2.0f];
//    _hud = nil;
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
