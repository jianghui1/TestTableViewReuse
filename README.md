##### 不管是刚开始学，还是现在网上一些资料，都讲明了 `UITableView` 重用 `cell` 的原理，以及好处。但是，有的地方没有细讲，导致了我(可能也有你)对重用造成了误解。

先说下我的误解：我之前认为 `cell` 的重用，就是对内存进行了优化，不用创建很多个 `cell`，造成内存消耗太多。

但是，最近我发现这种理解是错误的，而且是大错特错。下面先说明下结论：`cell` 重用会造成更多的内存消耗。

当然了，空口无凭，事实说话。下面根据测试用例进行具体分析。测试用例可以在[这里](https://github.com/jianghui1/TestTableViewReuse)下载。

首先，测试用例包括几种情况：
1. 代码创建 `UITableView` ，代码重用 `UITableViewCell` / 代码不重用 `UITableViewCell` 。
2. `xib` 创建 `UITableViewController`，代码重用 `UITableViewCell` / 代码不重用 `UITableViewCell` 。
3. `storyboard` 创建 `UITableViewController`，`UITableView` 的 `content` 为 `Static Cells` / `Dynamic Prototypes` ，代码重用 `UITableViewCell` / `storyboard` 重用 `UITableViewCell` / 代码不重用 `UITableViewCell` 。

然后，我在 `cell` 内部作了一些操作：
1. 创建一个静态变量 `initCount` ，用于表示 `cell` 创建的个数。
2. 创建一个静态变量 `deallocCount` , 用于表示 `cell` 释放的个数。
3. 在 `dealloc` 方法中，清空 `initCount` `deallocCount`，以免影响下次的数据。

最后，就看测试数据了。

先看下每种情况下 `cell` 创建个数，销毁个数。
1. 使用代码的情况下：
    
    * 重用时，创建 17 个，销毁 17 个。
    * 不重用时，当前存在的最大个数为 17 个。以后伴随着滑动，cell 会继续创建，当然也会继续释放，维持着最大为 17 个的状态。

2. 使用 `xib` 的情况下：

    跟第一种情况一样。其实这种情况，只有 `UITableView` 创建的方式不一样，其他一样。所以情况一样也是正常的。
    
3. 使用 `storyboard` 的情况下：

    `UITableView` 的 `content` 为 `Dynamic Prototypes`时：
    
    * 重用时，不管是代码注册重用，还是 `storyboard` 设置标识重用，都是创建 16 个，销毁 16 个。
    * 不重用时，当前存在的最大个数为 16 个。以后伴随着滑动，cell 会继续创建，当然也会继续释放，维持着最大为 16 个的状态。
    
    `UITableView` 的 `content` 为 `Static Cells`时：
    
    跟 `Dynamic Prototypes` 情况下是一样的。
    
通过这些数据，基本上就知道了，即使 `cell` 不重用，也不会造成内存消耗太多。虽然每次都会创建新的 `cell` ，但是不需要的 `cell` 也会被销毁。而且如上所说，不重用时，最大的个数与重用情况下一样，所以不重用时的内存消耗最大情况下跟重用一样，而且，当 `cell` 重用的时候，必定需要额外的操作存储这些数据，所以，`cell` 不重用时的内存是小于 `cell` 重用状态下的。

即便是这样，可能还是没有说服力，下面具体看看使用代码情况下重用与不重用的两张图。
![图1](https://github.com/jianghui1/TestTableViewReuse/blob/master/1.PNG?raw=true)
![图2](https://github.com/jianghui1/TestTableViewReuse/blob/master/2.PNG?raw=true)
注意，这里由于 `cell` 比较简单，所以我在 `cell` 初始化时，添加了一些数据，便于内存方面更加容易区分。

    
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
    
可以看到，重用时，内存为 24.6 M ；不重用时，内存为 24.0 M 。其他情况下，不再说明，有兴趣下载项目自己测试一下。

当然，这里只是考虑内存方面，其他方面，`cell` 重用的优势还是非常有效的。比如 `cpu` `fps`。在重用情况下，`cpu` 的使用还是比较低的，`fps` 也不会掉帧的。

其实，从缓存的角度讲，缓存的存在就是使用存储换时间，提高效率的。这里 `cell` 的重用很明显也是一种缓存。`cell` 的重用，主要还是为了使列表滑动更加顺畅，因为控件的创建消耗的时间还是比较大的。

但是，如果 `cell` 种类很多，而且不重复，那么使用 `cell` 重用就没有多大意义了。当然，如果这个页面有很多干货，很多人会滑来滑去，还是有必要使用 `cell` 重用的，这样，第二次开始滑动的流畅度就会明显提高了。

##### 上面只是说了重用与不重用的区别，下面顺便说下不同情况下，重用 `cell` 的区别。

1. 不同方式创建 `UITableView` 情况下：

* `xib` 与 代码 没什么区别
* `storyboard` 下 `dynamic/static` 两种情况不影响 `cell` 重用，`static` 情况下，可以实现 `tableview` 的数据源方法，也可以不实现。如果没有实现，`cell` 的个数由 `storyboard` 中设定的值决定；如果实现了，`cell` 个数由数据源决定的。

2. 创建重用 `cell` 的区别。

* 代码、`xib` 一样，`initWithStyle` / `registerClass` 两种方式
* `stroyboard` 中，`registerClass` / `storyboard` 中 `cell` 加标识两种方式。

3. 获取重用cell的区别。

* 代码、`xib`一样，都是代码，如果使用 `initWithStyle` 创建 , 必须通过 `dequeueReusableCellWithIdentifier:` 方法获取 `cell`。 如果使用 `registerClass` ，可以使用 `dequeueReusableCellWithIdentifier:` 或者 `dequeueReusableCellWithIdentifier:forIndexPath:` 两种方式获取 `cell`。
* `storyboard` 中，不管是代码注册 `cell` ，还是 `storyboard` 中加 `cell` 标识，都要使用 `dequeueReusableCellWithIdentifier:forIndexPath:`获取 `cell`。

4. `cell` 的初始化。

    当重用 `cell` 并且在 `storyboard` 中通过添加标识重用 `cell` 时，`cell` 创建时会调用 `awakeFromNib` 方法，其他情况下会调用 `initWithStyle:reuseIdentifier:` 方法。注意，这里的 `cell` 不存在对应的 `xib` 文件。
    
以上，就是最近对 `UITableView` 重用的新理解。其他没有涉及的情况，有兴趣可以自己动手试试，也可以向我的[测试用例](https://github.com/jianghui1/TestTableViewReuse)提交代码。

