//
//  UITabBar+Badge.m
//  Text
//
//  Created by cao yue on 2018/4/17.
//  Copyright © 2018年 cao yue. All rights reserved.
//


#define kXZCBSmallPointSize CGSizeMake(7.0, 7.0)
#define kXZCBCircleSize CGSizeMake(15.0, 15.0)
#define kXZCBRoundSize CGSizeMake(21.0, 15.0)
#define  kOffsetBadge  888
#define  kDistanceWith  5

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)

//设置指定tabar 小红点的值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index {
    NSInteger tabbarItemNums = self.items.count;
    //越界或者数据异常直接返回
    if (index + 1 > tabbarItemNums || index < 0 || tabbarItemNums == 0) {return;}
    //移除之前的小红点
    [self hideBadgeWithIndex:index];
    badgeValue = [self formatBadgeValue:badgeValue];
    //新建小红点
    UILabel *badgeLabel = [self viewWithTag:kOffsetBadge+index];
    if([badgeLabel isKindOfClass:[UILabel class]]){
        badgeLabel.text = [self badgeStringFromBadgeValue:badgeValue];
    }
    else{
        badgeLabel = [self createCustomBadgeLabel];
        badgeLabel.tag = kOffsetBadge+index;
        badgeLabel.text = [self badgeStringFromBadgeValue:badgeValue];
        [self addSubview:badgeLabel];
    }
    [self updateConstraintsBadgeValue:badgeValue tabBarItemIndex:index iTemsCount:tabbarItemNums];
}

- (void)hideBadgeWithIndex:(NSInteger)index {
    UILabel *view =(UILabel *) [self viewWithTag:kOffsetBadge+index];
    if (!view) {return;}
    [view removeFromSuperview];
}

#pragma mark - private method

- (NSString *)formatBadgeValue:(NSString *)badgeValue {
    if ([badgeValue isEqualToString:kXZCBBadgeValueSmallPoint]) {
        badgeValue = @"-1";
    } else if ([badgeValue integerValue] > 99) {
        badgeValue = @"99";
    }
    return badgeValue;
}

- (NSString *)badgeStringFromBadgeValue:(NSString *)badgeValue {
    NSString *string = nil;
    if (badgeValue) {
        if ([badgeValue isEqualToString:@"-1"] || [badgeValue isEqualToString:kXZCBBadgeValueSmallPoint]) {
            string = @"";
        } else {
            string = badgeValue;
        }
    } else {
        string = @"";
    }
    return string;
}

- (void)updateConstraintsBadgeValue:(NSString *)value tabBarItemIndex:(NSInteger)index iTemsCount:(NSInteger)count {
    UILabel *badgeLabel = (UILabel *)[self viewWithTag:kOffsetBadge+index];
    if (![badgeLabel isKindOfClass:[UILabel class]]) return;
    
    CGSize size = CGSizeZero;
    CGFloat top = 2.0;
    if (value.integerValue > 9) {
        size = kXZCBRoundSize;
    } else if (value.integerValue > 0) {
        size = kXZCBCircleSize;
    } else if (value.integerValue == -1) {
        size = kXZCBSmallPointSize;
    }
    badgeLabel.layer.cornerRadius = size.height / 2.0;
    //tabbar通常最多展示5个，但也支持大于5个，大于5时可根据情况处理
    CGFloat itemWith = CGRectGetWidth(self.bounds)/MIN(count, 5);
    badgeLabel.frame = (CGRect){index*itemWith+itemWith/2+kDistanceWith,top,size.width,size.height};
}

- (UILabel *)createCustomBadgeLabel {
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.clipsToBounds = YES;
    customLabel.textColor = [UIColor whiteColor];
    customLabel.backgroundColor = [UIColor redColor];
    customLabel.font = [UIFont systemFontOfSize:10];
    return customLabel;
}

@end
