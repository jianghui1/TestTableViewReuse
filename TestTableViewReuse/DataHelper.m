//
//  DataHelper.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "DataHelper.h"

@implementation DataHelper

+ (NSArray *)simpleData
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [tempArray addObject:@(i)];
    }
    return tempArray;
}

@end
