//
//  HLLRefreshHelper.h
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/21.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNoDataType.h"
#import "UIScrollView+HLLScrollView.h"
@class HLLEmptyDataSetHelper;


typedef void(^LoadNewData)( void(^ _Nullable completion)(void));
typedef void(^LoadMoreData)( void(^ _Nullable completion)(BOOL isLastPage));

NS_ASSUME_NONNULL_BEGIN

@interface HLLRefreshHelper : NSObject

@property (nonatomic, strong) HLLEmptyDataSetHelper *emptyDataSetHelper;
@property (nonatomic, strong) UIScrollView *targetView;

/**
 下拉刷新block
 */
@property (copy, nonatomic) LoadNewData loadNewDataBlock;

/**
 上拉加载更多block
 */
@property (copy, nonatomic) LoadMoreData loadMoreDataBlock;
/**
 数据获取之后赋值, 如果数据为空,显示emptyDataSet, 如果有数据不显示
 */
@property (nonatomic, assign) BOOL isEmpty;

/**
 是否开启下拉刷新
 */
@property (nonatomic, assign) BOOL shouldPullRefresh;

/**
 是否开启上拉加载更多
 */
@property (nonatomic, assign) BOOL shouldPullLoadMore;
//@property (nonatomic, assign) BOOL shouldDisplay;


/**
 无数据的类型, 根据类型选择不同的图片
 */
@property (nonatomic, assign) HLLNodataType noDataType;

/**
 设置背景颜色
 */
@property (nonatomic, strong, nullable) UIColor *emptyBackgroundColor;

/**
 无数据的图片提示是否隐藏
 */
@property (nonatomic, assign) BOOL isNoDataImageHidden;
- (void)beginRefreshing;
+ (instancetype)refreshTarget:(UIScrollView *)targetView emptyDataHelper:(HLLEmptyDataSetHelper *)emptyDataSetHelper;
@end

NS_ASSUME_NONNULL_END
