//
//  StoryBoardTableViewController.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "StoryBoardDynamicTableViewController.h"

#import "TestTableViewCell.h"
#import "DataHelper.h"

@interface StoryBoardDynamicTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation StoryBoardDynamicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObjectsFromArray:[DataHelper simpleData]];
    NSString *reuseIdentifier = _isReuse ? @"cellId" : nil;
    if (_isReuse) {
        [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *reuseIdentifier = _isReuse ? @"cellId" : nil;
    TestTableViewCell *cell;
    if (reuseIdentifier) {
        cell  = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    }
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


@end
