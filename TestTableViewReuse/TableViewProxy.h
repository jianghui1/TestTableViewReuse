//
//  TableViewProxy.h
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewProxy : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) NSArray *dataArray;
@property (nonatomic, assign) BOOL isReuse;

@end

NS_ASSUME_NONNULL_END
