//
//  StoryBoardTableViewController.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "StoryBoardDynamicTableViewController1.h"

#import "TestTableViewCell.h"
#import "DataHelper.h"

@interface StoryBoardDynamicTableViewController1 ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation StoryBoardDynamicTableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObjectsFromArray:[DataHelper simpleData]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *reuseIdentifier = @"cellId";
    TestTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] stringValue];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


@end
