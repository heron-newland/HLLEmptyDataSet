//
//  HLLEmptyDataSetHelper.h
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/20.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "HLLNoDataType.h"
NS_ASSUME_NONNULL_BEGIN


typedef  void(^ButtonTapped)(void);

@interface HLLEmptyDataSetHelper : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>



@property (nonatomic, weak)  id<DZNEmptyDataSetSource> dataSource;
@property (nonatomic, weak) id<DZNEmptyDataSetDelegate> delegate;

/**
 设置背景颜色
 */
@property (nonatomic, strong, nullable) UIColor *emptyBackgroundColor;
/**
 无数据的类型, 根据类型选择不同的图片
 */
@property (nonatomic, assign) HLLNodataType noDataType;

/**
 无数据的图片提示是否隐藏
 */
@property (nonatomic, assign) BOOL isNoDataImageHidden;


@property (nonatomic, copy, nullable) ButtonTapped noDataButtonTapped;
//@property (nonatomic, assign) BOOL isRefreshing;

@end

NS_ASSUME_NONNULL_END
