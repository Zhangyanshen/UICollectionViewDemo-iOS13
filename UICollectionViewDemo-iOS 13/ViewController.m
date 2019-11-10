//
//  ViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/9.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[
        @{@"sectionTitle": @"基本使用", @"classes": @[
            @{@"title": @"简单的列表", @"class": @"SimpleListViewController"},
            @{@"title": @"一个group多个item", @"class": @"MultiCellViewController"},
            @{@"title": @"截然不同的section", @"class": @"DistinctSectionsViewController"},
        ]},
        @{@"sectionTitle": @"Supplementary view(补充视图)", @"classes": @[
            @{@"title": @"badge", @"class": @"BadgeViewController"},
            @{@"title": @"header footer", @"class": @"HeaderFooterViewController"}
        ]},
        @{@"sectionTitle": @"Decoration view(装饰视图)", @"classes": @[
            @{@"title": @"decoration background", @"class": @"DecorateViewController"},
        ]},
    ];
    [self setupUI];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return [sectionDic[@"classes"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    cell.textLabel.text = sectionDic[@"classes"][indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *sectionDic = self.dataArray[section];
    return sectionDic[@"sectionTitle"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *sectionDic = self.dataArray[indexPath.section];
    NSDictionary *dic = sectionDic[@"classes"][indexPath.row];
    Class cls = NSClassFromString(dic[@"class"]);
    id obj = [[cls alloc] init];
    [obj setTitle:dic[@"title"]];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark - Setters/Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - Private methods

- (void)setupUI {
    self.title = @"iOS 13 UICollectionView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
