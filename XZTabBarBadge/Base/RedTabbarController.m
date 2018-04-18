//
//  RedTabbarController.m
//  XZTabBarBadge
//
//  Created by cao yue on 2018/4/18.
//  Copyright © 2018年 cao yue. All rights reserved.
//

#define kUIToneBackgroundColor [UIColor redColor]

#import "RedTabbarController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "PictureViewController.h"
#import "MyViewController.h"
#import "UITabBar+Badge.h"

@interface RedTabbarController ()

@end

@implementation RedTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadControllers];
    [self loadData];
}

- (void)loadControllers {
    NSArray *tabArray = @[@[@"HomeViewController",@"tabbar_home",@"首页"],
                       @[@"MessageViewController",@"tabbar_message",@"消息"],
                       @[@"PictureViewController",@"tabbar_picture",@"图片"],
                       @[@"MyViewController",@"tabbar_me",@"我"]];
    [self loadViewControllerWithInfo:tabArray];
}

- (void)loadViewControllerWithInfo:(NSArray *)array {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSInteger index = 0; index < array.count; index++) {
        NSString *className = array[index][0];
        NSString *imageName = array[index][1];
        NSString *title = array[index][2];
        Class class = NSClassFromString(className);
        UIViewController *rootVC = [[class alloc] init];
        UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectImage];
        rootVC.tabBarItem = tabBarItem;
        [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kUIToneBackgroundColor,NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:rootVC];
        [viewControllers addObject:rootNav];
    }
    self.viewControllers = [viewControllers copy];
}

- (void)loadData {
    [self.tabBar setBadgeValue:@"88" index:0];
    [self.tabBar setBadgeValue:@"10" index:1];
    [self.tabBar setBadgeValue:@"99" index:2];
    [self.tabBar setBadgeValue:@"-1" index:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
