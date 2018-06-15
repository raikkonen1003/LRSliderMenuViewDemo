//
//  UIFont+PingFang.m
//  LRSliderMenuViewDemo
//
//  Created by liliansi on 2018/6/15.
//  Copyright © 2018年 liliansi. All rights reserved.
//

#import "UIFont+PingFang.h"

@implementation UIFont (PingFang)

+ (UIFont *)cy_PingFangSC_MediumFontOfSize:(CGFloat)size {
    if (@available(iOS 9.0, *)) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    }else {
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *)cy_PingFangSC_LightFontOfSize:(CGFloat)size {
    if (@available(iOS 9.0, *)) {
        return [UIFont fontWithName:@"PingFangSC-Light" size:size];
    }else {
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *)cy_PingFangSC_RegularFontOfSize:(CGFloat)size {
    if (@available(iOS 9.0, *)) {
        return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    }else {
        return [UIFont systemFontOfSize:size];
    }
}

+ (UIFont *)cy_PingFangSC_SemiboldFontOfSize:(CGFloat)size {
    if (@available(iOS 9.0, *)) {
        return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    }else {
        return [UIFont systemFontOfSize:size];
    }
}

@end
