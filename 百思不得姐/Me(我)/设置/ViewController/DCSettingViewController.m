//
//  DCSettingViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/20.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCSettingViewController.h"
#import "DCClearTableViewCell.h"
@interface DCSettingViewController ()

@end

@implementation DCSettingViewController

static NSString * const DCClearCacheCellId = @"DCClearCacheCell";
static NSString * const DCSettingCellId = @"DCSettingCell";
-(instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DCCommonBgColor;
    self.navigationItem.title = @"设置";
    
    /**
     两种方法获取文件大小
     */
    [self getCacheSize1];
//    [self getCacheSize];
    DCLog(@"%@",NSHomeDirectory());
    [self.tableView registerClass:[DCClearTableViewCell class] forCellReuseIdentifier:DCClearCacheCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DCSettingCellId];
}
- (void)getCacheSize1
{
    // 总大小
    unsigned long long size = 0;
    
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"default"];
    //    XMGLog(@"%@", dirpath);
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
    // Enumerator : 遍历器\迭代器
    NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dirpath];
    for (NSString *subpath in enumerator) {
        // 全路径
        NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
        // 累加文件大小
        size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
    }
    
    DCLog(@"1:%llu", size);
}
//- (void)getCacheSize {
//    // 总大小
//    unsigned long long size = 0;
//
//    // 获得缓存文件夹路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"default"];
//
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
//    NSArray *subpaths = [mgr subpathsAtPath:dirpath];
//    for (NSString *subpath in subpaths) {
//        // 全路径
//        NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
//        // 累加文件大小
//        size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//    }
//    DCLog(@"1:%llu", size);
//}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:DCClearCacheCellId];
    }
    
    // 其他cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DCSettingCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
