//
//  HLLRefreshHelper.m
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/21.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import "HLLRefreshHelper.h"
#import "MJRefresh.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "HLLNoDataType.h"
#import "HLLEmptyDataSetHelper.h"

@interface HLLRefreshHelper()

@end
@implementation HLLRefreshHelper


//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        self.emptyBackgroundColor = nil;
//        [self setupRefresh];
//    }
//    return self;
//}

+ (instancetype)refreshTarget:(UIScrollView *)targetView emptyDataHelper:(HLLEmptyDataSetHelper *)emptyDataSetHelper{
    HLLRefreshHelper *helper = [[HLLRefreshHelper alloc] init];
        helper.emptyDataSetHelper = emptyDataSetHelper;
        helper.targetView = targetView;
    helper.emptyBackgroundColor = nil;
    [helper setupRefresh];
    return helper;
}


// MARK: - set
- (void)setIsEmpty:(BOOL)isEmpty{
    //如果一条数据没有,隐藏加载更多
    self.targetView.mj_footer.hidden = isEmpty;
    if (isEmpty) {
        [self setUpEmptyDataSet];
    }else{
        self.targetView.emptyDataSetSource = nil;
        self.targetView.emptyDataSetDelegate = nil;
    }
    [self.targetView reloadEmptyDataSet];
}

- (void)setNoDataType:(HLLNodataType)noDataType{
    self.emptyDataSetHelper.noDataType = noDataType;
}

- (void)setEmptyBackgroundColor:(UIColor *)emptyBackgroundColor{
    self.emptyDataSetHelper.emptyBackgroundColor = emptyBackgroundColor;
}

- (void)setShouldPullRefresh:(BOOL)shouldPullRefresh {
    if (shouldPullRefresh) {
        [self setupRefresh];
    } else {
        self.targetView.mj_header = nil;
    }
}

- (void)setShouldPullLoadMore:(BOOL)shouldPullLoadMore{
    if (shouldPullLoadMore) {
        [self setupLoadMore];
    }else{
        self.targetView.mj_footer = nil;
    }
}
//- (void)setLoadNewDataBlock:(LoadNewData)loadNewDataBlock{
//    self.loadNewDataBlock = loadNewDataBlock;
//}
//- (void)setLoadMoreDataBlock:(LoadMoreData)loadMoreDataBlock{
//    self.loadMoreDataBlock = loadMoreDataBlock;
//}

// MARK: - config
- (void)setUpEmptyDataSet {
    
    if (self.targetView.emptyDataSetSource == nil) {
        self.targetView.emptyDataSetSource = self.emptyDataSetHelper;
    }
    if (self.targetView.emptyDataSetDelegate == nil) {
        self.targetView.emptyDataSetDelegate = self.emptyDataSetHelper;
    }
    
}

- (void)setupRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.targetView.mj_header = header;
}

- (void)setupLoadMore{
    //自动加载更多
//    MJRefreshAutoStateFooter
//    MJRefreshBackNormalFooter
//    MJRefreshAutoNormalFooter
//    MJRefreshAutoFooter

    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.targetView.mj_footer = footer;
}
// MARK: - data
- (void)loadNewData {
    
    if (self.loadNewDataBlock) {
        __weak typeof(self) weakSelf = self;
        self.loadNewDataBlock(^{
            __strong typeof(self) self = weakSelf;
            [self.targetView.mj_header endRefreshing];
            [self.targetView.mj_footer resetNoMoreData];
        });
    }
}

- (void)loadMoreData {
    if (self.loadMoreDataBlock) {
        __weak typeof(self) weakSelf = self;
        self.loadMoreDataBlock(^(BOOL isLastPage) {
            __strong typeof(self) self = weakSelf;
            if (isLastPage) {
                [self.targetView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.targetView.mj_footer endRefreshing];
            }
        });
        
    }
}

// MARK: - method
- (void)beginRefreshing{
    [self.targetView.mj_header beginRefreshing];
}
@end
