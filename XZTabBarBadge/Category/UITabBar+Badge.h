//
//  UITabBar+Badge.h
//  Text
//
//  Created by cao yue on 2018/4/17.
//  Copyright © 2018年 cao yue. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 kXZCBBadgeValueSmallPoint 或者 -1  为展示我模块的小红点
 */
static NSString * const kXZCBBadgeValueSmallPoint = @"kXZCBBadgeValueSmallPoint";

@interface UITabBar (Badge)

#pragma 设置小红点数值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index;//设置指定tabar 小红点的值
#pragma 设置小红点显示或者隐藏
- (void)hideBadgeWithIndex:(NSInteger)index;//隐藏小红点 没有数值

@end
