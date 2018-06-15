//
//  Header.h
//  LRSliderMenuViewDemo
//
//  Created by liliansi on 2018/6/15.
//  Copyright © 2018年 liliansi. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "LRSliderMenuView.h"
#import "UIFont+PingFang.h"
#import "InfoTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

// 十六进制颜色
#define COLOR_WITH_HEX(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:(a)]

// 屏幕宽高
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

//坐标比例变换
#define RESIZE(x) ((x)/375.f*CGRectGetWidth([UIScreen mainScreen].bounds))

#define is_iPHONE_X (SCREEN_HEIGHT == 812 || SCREEN_HEIGHT == 812.0)

#define NAVIGATIONBAR_HEIGHT (is_iPHONE_X ? 88.0 : 64.0)
#define TABBAR_HEIGHT        (is_iPHONE_X ? (49.0+34.0) : 49.0)
#define STATUSBAR_HEIGHT     (NAVIGATIONBAR_HEIGHT-44)
#define FINGER_HEIGHT (is_iPHONE_X ? 34 : 0)

//弱引用
#define WeakObject(type)  __weak typeof(type) weak##type = type;
// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


#endif /* Header_h */
