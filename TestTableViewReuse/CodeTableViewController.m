//
//  CodeTableViewController.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "CodeTableViewController.h"

#import "TableViewProxy.h"
#import "DataHelper.h"

@interface CodeTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TableViewProxy *proxy;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.proxy = [[TableViewProxy alloc] init];
    _proxy.dataArray = _dataArray;
    _proxy.isReuse = _isReuse;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.delegate = _proxy;
    _tableView.dataSource = _proxy;
    [self.view addSubview:_tableView];
    
    [_dataArray addObjectsFromArray:[DataHelper simpleData]];
    [_tableView reloadData];
}

@end
