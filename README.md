# HLLEmptyDataSet

下拉刷新和空数据提示结合,并自动管理库

下拉刷新使我们经常使用的框架, 其中`MJRefresh`也是我们比较常用的. 但是列表展示很多情况会出现没有数据的尴尬, 比如服务器返回数据为空, 网络状态不好请求超时等,我们平时处理空数据的时候用的最多的框架就是`DZNEmptyDataSet`.笔者探索将这两个框架结合在一起,并通过给UIScrollView添加分类的方式,给常用的列表控件 `UITableView, UICollectionview, UIScrollView`,添加了下拉刷新和自动处理空数据的功能.

![示例图](https://github.com/heron-newland/HLLEmptyDataSet/blob/master/nodata.png)


### 依赖框架

1. DZNEmptyDataSet

2. MJRefresh

### 使用方式
[访问项目地址](https://github.com/heron-newland/HLLEmptyDataSet/tree/master),将项目下载到本地, 然后将 `HLLEmpeyDataSource` 文件夹拖入到自己的项目中, 在使用的地方导入头文件 `#import "UIScrollView+HLLScrollView.h"`.

具体使用方式可以参考Demo, Demo中分别对`UITableView, UICollectionview, UIScrollView`的使用方式进行了演示;

下面就UITableView的使用方式进行说明, 其他列表控件的使用方式基本相同:

1. 初始化tableview, 可以使用代码也可以使用SB或者XIB;
2. 调用`[_tableView hll_setUp]` 进行初始化;
3. 根据实际需求配置,比如是否开启下拉刷新, 是否开启上拉加载更多等等, 代码如下:
		
		//开启上拉加载更多
		_tableView.shouldPullLoadMore = true;
		//开启下拉刷星
	    _tableView.shouldPullRefresh = true;
	    //isEmpty属性决定了列表为空时是否显示空列表提示,初始时可以赋值为true,显示没有数据(根据实际情况配置)
	    _tableView.isEmpty = true;
	    //没有数据的原因, 这是一个枚举,使用时开发者可以根据实际情况自定义
	    _tableView.noDataType = HLLNodataTypeNoNetworking;
	    //空数据视图的背景颜色
	    _tableView.emptyBackgroundColor = UIColor.lightGrayColor;
	    //下拉加载更多的回调
	    _tableView.loadNewDataBlock = ^(void (^ _Nonnull completion)(void)) {
	        sleep(1);
	        //告诉框架已经完成数据请求,框架会自动关闭刷新
	        completion();
	        //此句很重要, 如果数据为空那么赋值为true, 如果数据不为空赋值为false;
	        weakSelf.tableView.isEmpty = false;
	        weakSelf.data = @[@"one",@"one",@"one",@"one",@"one"];
	        [weakSelf.tableView reloadData];
	    };
	    //上拉加载更多的回调
	    _tableView.loadMoreDataBlock = ^(void (^ _Nonnull completion)(BOOL)) {
	        sleep(1);
	        //此句很重要, 如果数据为空那么赋值为true, 如果数据不为空赋值为false;
	        weakSelf.tableView.isEmpty = false;
	        weakSelf.data = @[@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one"];
	        //告诉框架加载更多已经完成,参数传递一个bool值, 告诉框架是否为最后一页
	        completion(weakSelf.data.count == 13);
	        [weakSelf.tableView reloadData];
	    };
	    
	    
### 主要属性介绍

	/**
	 数据获取之后赋值, 如果数据为空,显示emptyDataSet, 如果有数据不显示
	 */
	 @property (nonatomic, assign) BOOL isEmpty;
	
	/**
	 下拉刷新block
	 */
	@property (copy, nonatomic) LoadNewData loadNewDataBlock;
	
	/**
	 上拉加载更多block
	 */
	@property (copy, nonatomic) LoadMoreData loadMoreDataBlock;
	
	/**
	 是否开启下拉刷新
	 */
	@property (nonatomic, assign) BOOL shouldPullRefresh;
	
	/**
	 是否开启上拉加载更多
	 */
	@property (nonatomic, assign) BOOL shouldPullLoadMore;
	
	/**
	 无数据的类型, 根据类型选择不同的图片
	 */
	@property (nonatomic, assign) HLLNodataType noDataType;
	
	/**
	 设置背景颜色
	 */
	@property (nonatomic, strong) UIColor *emptyBackgroundColor;
	
	/**
	 无数据的图片提示是否隐藏
	 */
	@property (nonatomic, assign) BOOL isNoDataImageHidden;
	
	
	
	@property (nonatomic, strong) HLLEmptyDataSetHelper *emptyDataSetHelper;
	
	@property (nonatomic, strong) HLLRefreshHelper *refreshHelper;
	
	/**
	 初始化
	 */
	- (void)hll_setUp;