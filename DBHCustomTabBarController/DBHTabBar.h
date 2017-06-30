//
//  DBHTabBar.h
//  TabbarItemTest
//
//  Created by DBH on 17/6/27.
//  Copyright © 2017年 邓毕华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DBHTabBar;

@protocol DBHTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(DBHTabBar *)tabBar;

@end

@interface DBHTabBar : UITabBar

@property (nonatomic, weak) id<DBHTabBarDelegate> myDelegate;

@end
