//
//  UIScrollView+HLLScrollView.h
//  HLLEmptyData
//
//  Created by  bochb on 2019/6/24.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "HLLNoDataType.h"

@class HLLRefreshHelper;
@class HLLEmptyDataSetHelper;

#import "HLLRefreshHelper.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoadNewData)(void(^completion)(void));
typedef void(^LoadMoreData)(void(^completion)(BOOL isLastPage));

@interface UIScrollView (HLLScrollView)<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

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
@end

NS_ASSUME_NONNULL_END
