//
//  TableViewProxy.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "TableViewProxy.h"

#import "TestTableViewCell.h"

@implementation TableViewProxy

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *reuseIdentifier = _isReuse ? @"cellId" : nil;
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
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
