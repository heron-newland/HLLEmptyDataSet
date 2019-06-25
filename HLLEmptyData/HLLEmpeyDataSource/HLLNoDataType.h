//
//  HLLNoDataType.h
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/21.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 没有数的原因, 根据业务自定义
 
 - HLLNodataTypeNone: 不显示图片和文字
 - HLLNodataTypeNoLogin: 没有登录
 - HLLNodataTypeNoAddress: 没有收货地址
 - HLLNodataTypeNoNetworking: 没有网络
 - HLLNodataTypeNoLogistics: 没有物流
 - HLLNodataTypeDefault: 默认图片n
 */
typedef NS_ENUM(NSInteger, HLLNodataType) {
    HLLNodataTypeNone,
    HLLNodataTypeNoLogin,
    HLLNodataTypeNoAddress,
    HLLNodataTypeNoNetworking,
    HLLNodataTypeNoLogistics,
    HLLNodataTypeDefault
};
//@interface HLLNoDataType : NSObject
//
//@end

NS_ASSUME_NONNULL_END
