//
//  UIScrollView+HLLScrollView.m
//  HLLEmptyData
//
//  Created by  bochb on 2019/6/24.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import "UIScrollView+HLLScrollView.h"
#import <objc/runtime.h>
#import "HLLEmptyDataSetHelper.h"


@implementation UIScrollView (HLLScrollView)

@dynamic emptyDataSetHelper;
@dynamic refreshHelper;
@dynamic isEmpty;
@dynamic loadNewDataBlock;
@dynamic loadMoreDataBlock;
@dynamic shouldPullRefresh;
@dynamic shouldPullLoadMore;
@dynamic emptyBackgroundColor;
@dynamic isNoDataImageHidden;
@dynamic noDataType;

/**
 初始化
 */
- (void)hll_setUp{
        [self setUpMJRefreshAndEmptyDataSet];
}

static const char emptyDataSetHelperKey = '\0';

- (void)setEmptyDataSetHelper:(HLLEmptyDataSetHelper *)emptyDataSetHelper{
    objc_setAssociatedObject(self, &emptyDataSetHelperKey, emptyDataSetHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HLLEmptyDataSetHelper *)emptyDataSetHelper{
    return objc_getAssociatedObject(self, &emptyDataSetHelperKey);
}

static const char refreshHelperKey = '\0';
- (void)setRefreshHelper:(HLLRefreshHelper *)refreshHelper{
     objc_setAssociatedObject(self, &refreshHelperKey, refreshHelper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HLLRefreshHelper *)refreshHelper{
     return objc_getAssociatedObject(self, &refreshHelperKey);
}

// MARK: - MJReresh and emptyDataSet config
- (void)setUpMJRefreshAndEmptyDataSet{
    self.emptyDataSetHelper = [[HLLEmptyDataSetHelper alloc] init];
    __weak typeof(self) weakSelf = self;
    self.emptyDataSetHelper.noDataButtonTapped = ^{
        __strong typeof(self) self = weakSelf;
        [self.refreshHelper beginRefreshing];
    };
    self.refreshHelper = [HLLRefreshHelper refreshTarget:self emptyDataHelper:self.emptyDataSetHelper];
}

// MARK: - set
- (void)setIsEmpty:(BOOL)isEmpty{
//    objc_setAssociatedObject(self, "isEmpty", @(isEmpty), OBJC_ASSOCIATION_ASSIGN);
    self.refreshHelper.isEmpty = isEmpty;
}

- (void)setNoDataType:(HLLNodataType)noDataType{
//    objc_setAssociatedObject(self, "noDataType", @(noDataType), OBJC_ASSOCIATION_ASSIGN);
        self.refreshHelper.noDataType = noDataType;
}

- (void)setEmptyBackgroundColor:(UIColor *)emptyBackgroundColor{
//    objc_setAssociatedObject(self, "emptyBackgroundColor", emptyBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.refreshHelper.emptyBackgroundColor = emptyBackgroundColor;
}

- (void)setShouldPullRefresh:(BOOL)shouldPullRefresh {
//        objc_setAssociatedObject(self, "shouldPullRefresh", @(shouldPullRefresh), OBJC_ASSOCIATION_ASSIGN);
    self.refreshHelper.shouldPullRefresh = shouldPullRefresh;
}

- (void)setShouldPullLoadMore:(BOOL)shouldPullLoadMore{
//      objc_setAssociatedObject(self, "shouldPullLoadMore", @(shouldPullLoadMore), OBJC_ASSOCIATION_ASSIGN);
    self.refreshHelper.shouldPullLoadMore = shouldPullLoadMore;
}

- (void)setLoadNewDataBlock:(LoadNewData)loadNewDataBlock{
//      objc_setAssociatedObject(self, "loadNewDataBlock", loadNewDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.refreshHelper.loadNewDataBlock = loadNewDataBlock;
}
- (void)setLoadMoreDataBlock:(LoadMoreData)loadMoreDataBlock{
//      objc_setAssociatedObject(self, "loadMoreDataBlock", loadMoreDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.refreshHelper.loadMoreDataBlock = loadMoreDataBlock;
}
@end
