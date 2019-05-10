//
//  DCMeViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2018/10/26.
//  Copyright © 2018 Tomous. All rights reserved.
//

#import "DCMeViewController.h"
#import "DCMeCell.h"
#import "DCMeFooterView.h"
#import "DCSettingViewController.h"
@interface DCMeViewController ()

@end

@implementation DCMeViewController

-(instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupNav];
    // Do any additional setup after loading the view.
   
}
- (void)setupTable {
    self.tableView.backgroundColor = DCCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = DCMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(DCMargin - 35, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[DCMeFooterView alloc]init];
}

- (void)setupNav {
    
    self.navigationItem.title = @"我的";
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *seetingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(seetingClick)];
    self.navigationItem.rightBarButtonItems = @[seetingItem, moonItem];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    DCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DCMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    return cell;
}
-(void)moonClick
{
    DCLogFunc;
}
-(void)seetingClick
{
    DCLogFunc;
    DCSettingViewController *setVC = [[DCSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
