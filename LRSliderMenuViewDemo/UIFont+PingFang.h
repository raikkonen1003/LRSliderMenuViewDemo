//
//  UIFont+PingFang.h
//  LRSliderMenuViewDemo
//
//  Created by liliansi on 2018/6/15.
//  Copyright © 2018年 liliansi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (PingFang)

/**
 Ios 9及以上系统版本使用苹方字体，否则使用系统默认字体
 
 @param size 字体大小
 @return UIFont对象
 */
+ (UIFont *)cy_PingFangSC_MediumFontOfSize:(CGFloat)size;
+ (UIFont *)cy_PingFangSC_LightFontOfSize:(CGFloat)size;
+ (UIFont *)cy_PingFangSC_RegularFontOfSize:(CGFloat)size;
+ (UIFont *)cy_PingFangSC_SemiboldFontOfSize:(CGFloat)size;

@end
