//
//  TestTableViewCell.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation TestTableViewCell

static int initCount = 0;
static int deallocCount = 0;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        initCount++;
        NSLog(@"initCount -- %d", initCount);
        
        // 添加大数据，用于内存区分
        self.array = [NSMutableArray array];
        for (int i = 0; i < 100000; i++) {
            [_array addObject:@(i)];
        }
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    initCount++;
    NSLog(@"awakeFromNib -- initCount -- %d", initCount);
    
}

- (void)dealloc
{
    deallocCount++;
    NSLog(@"deallocCount -- %d", deallocCount);
    if (deallocCount == initCount) {
        deallocCount = 0;
        initCount = 0;
    }
}

@end
