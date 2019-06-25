//
//  HLLEmptyDataSetHelper.m
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/20.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import "HLLEmptyDataSetHelper.h"
#import "MJRefresh.h"
@implementation HLLEmptyDataSetHelper
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setEmptyBackgroundColor:(UIColor *)emptyBackgroundColor{
    _emptyBackgroundColor = emptyBackgroundColor;
}
// MARK: - dataSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    //    NSString *text = @"网络连接错误, 请检查网络设置";
    NSString *text;
    switch (_noDataType) {
        case HLLNodataTypeNoAddress://没有地址
            text = @"您还没有添加收货地址";
            break;
            
        case HLLNodataTypeNoNetworking:
            text = @"网络连接错误, 检查网络设置";
            break;
        case HLLNodataTypeNone:
            text = @"";
            break;
        case HLLNodataTypeNoLogistics:
            text = @"买家正在努力打包发货中";
            break;
        case HLLNodataTypeDefault:
            text = @"找了半天,啥都没有";
            break;
        default:
            break;
    }
    
    UIFont *font = [UIFont boldSystemFontOfSize: 12];
    UIColor *textColor = [UIColor lightGrayColor];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"刷新试试";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:text];
    [att addAttributes:@{
                         NSFontAttributeName:[UIFont boldSystemFontOfSize: 14.0],
                         NSBackgroundColorAttributeName:[UIColor blueColor]
                         } range:NSMakeRange(0, text.length)];
    return att;
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *imageName;
    switch (_noDataType) {
        case HLLNodataTypeNoAddress://没有地址
            imageName = @"wushouhuodizhi";
            break;
            
        case HLLNodataTypeNoNetworking:
            imageName = @"wangluolianjiecuowu";
            break;
        case HLLNodataTypeNone:
            imageName = @"";
            break;
        case HLLNodataTypeDefault:
            imageName = @"nodataimage";
            break;
        case HLLNodataTypeNoLogistics:
            imageName = @"meiyouwuliuxinxi";
            break;
        default:
            break;
    }
    
    return [UIImage imageNamed:imageName];
}


/**
 各个元素之间的垂直间距. 默认值: 11
 */
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    return 0;
//}

/**
 调整垂直偏移量: 默认:0
 */
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return 0;
//}




/**
 图片tint color, 默认为nil
 */
//- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView{
//
//}

/**
动画
 */
//- (CAAnimation *) imageAnimationForEmptyDataSet:(UIScrollView *) scrollView{
//
//}


//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//
//}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.noDataType == HLLNodataTypeNoNetworking) {
        NSString *imageName = [NSString stringWithFormat:@"no_network"];
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//
//}

/**
 背景颜色: 默认 clear color
 */
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyBackgroundColor ? self.emptyBackgroundColor : [UIColor clearColor];
}

/**
 完全自定义, 将会忽略如下两个方法: -offsetForEmptyDataSet , -spaceHeightForEmptyDataSet configurations.
 */
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
//
//}




// MARK: - delegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    NSLog(@"点我干嘛");
    //    [self.mj_header beginRefreshing];
    if (self.noDataButtonTapped) {
        self.noDataButtonTapped();
    }
}

//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
//    if (self.isNoDataImageHidden) {
//        return NO;
//    }
//    return !self.isRefreshing;
//}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return YES;
}


/**
 点击整个nodataemptyset的响应时间, 如果实现了button的点击事件,点击button不会响应
 */
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
//    UITapGestureRecognizer *recognizer = (UITapGestureRecognizer *)view;
//    NSLog(@"%@",recognizer.view);
//}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView{
     NSLog(@"emptyDataSetWillAppear");
}


- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView{
    NSLog(@"emptyDataSetDidAppear");
}

- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView{
    NSLog(@"emptyDataSetWillDisappear");
}

- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView{
    NSLog(@"emptyDataSetDidDisappear");
}
@end
