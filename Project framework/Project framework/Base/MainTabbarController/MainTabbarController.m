//
//  MainTabbarController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "MainTabbarController.h"
#import "HomeController.h"
@implementation MainTabbarController
- (CYLTabBarController *)mainTabBar{
    if (!_mainTabBar) {
        UIEdgeInsets imagesInsets = UIEdgeInsetsZero;
        UIOffset titlePosition =UIOffsetZero;
        _mainTabBar = [[CYLTabBarController alloc]initWithViewControllers:[self arryViewcontrollers] tabBarItemsAttributes:[self arrayAttributesItem] imageInsets:imagesInsets titlePositionAdjustment:titlePosition];
        
//        [_mainViewController setTintColor:[UIColor colorWithHexString:@"00AE68"]];
    }
    return _mainTabBar;
}

-(NSArray *)arryViewcontrollers{
    HomeController *homevc=[[HomeController alloc]init];
    RootNavigationController *homeNav = [[RootNavigationController alloc]initWithRootViewController:homevc];
    NSArray *arryviews=@[homeNav];
    return arryviews;
    
}

-(NSArray *)arrayAttributesItem{
    NSDictionary *hometar = @{
                              CYLTabBarItemTitle:@"首页",
                              CYLTabBarItemImage:@"",
                              CYLTabBarItemSelectedImage:@"",
                              };
    NSArray *arry = @[hometar];
    return arry;
}
@end
