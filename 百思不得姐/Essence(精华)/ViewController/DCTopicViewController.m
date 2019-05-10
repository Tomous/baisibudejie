//
//  DCTopicViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/5/8.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCTopicViewController.h"
#import "DCTopic.h"
#import "DCTopicCell.h"
@interface DCTopicViewController ()
/** 所有的帖子数据 */
@property (nonatomic,strong) NSMutableArray<DCTopic *> *topics;

/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

/** 任务管理者 */
@property (nonatomic, strong) DCHTTPSessionManager *manager;
@end

@implementation DCTopicViewController
- (DCTopicType)type {
    return 0;
}
#pragma mark - 懒加载
-(DCHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [DCHTTPSessionManager manager];
    }
    return _manager;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)setupRefresh {
    self.tableView.mj_header = [DCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [DCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据加载
- (void)loadNewTopics {
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    [self.manager GET:DCCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典数组 -> 模型数组
        self.topics = [DCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DCLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreTopics
{
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    // 发送请求
    [self.manager GET:DCCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray<DCTopic *> *moreTopics = [DCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DCLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCTopicCell *cell = [DCTopicCell cellWithTableView:tableView forRowAtIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topics[indexPath.row].cellHeight;
}
@end
