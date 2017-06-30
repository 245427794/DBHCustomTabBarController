//
//  DBHMainTabbarController.m
//  TabbarItemTest
//
//  Created by DBH on 17/6/27.
//  Copyright © 2017年 邓毕华. All rights reserved.
//

#import "DBHMainTabbarController.h"

#import "DBHTabBar.h"

/**
 *  将16进制rgb颜色转换成UIColor
 */
#define COLORFROM16(RGB, A) [UIColor colorWithRed:((float)((RGB & 0xFF0000) >> 16)) / 255.0 green:((float)((RGB & 0xFF00) >> 8)) / 255.0 blue:((float)(RGB & 0xFF)) / 255.0 alpha:A]

@interface DBHMainTabbarController ()<DBHTabBarDelegate>

@property (nonatomic, strong) NSArray *vcTitleArray;
@property (nonatomic, strong) NSArray *vcItemArray;

@end

@implementation DBHMainTabbarController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self addAllChildViewController];
    
    DBHTabBar *tabBar = [[DBHTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    // 设置tabBar的代理
    tabBar.myDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - Private Methods
// 初始化所有的子控制器
- (void)addAllChildViewController {
    for (NSInteger i = 0; i < self.vcTitleArray.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        
        vc.title = self.vcTitleArray[i];
        vc.tabBarItem.image = [[UIImage imageNamed:self.vcItemArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_color", self.vcItemArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLORFROM16(0x62ac93, 1)} forState:UIControlStateSelected];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.title = self.vcTitleArray[i];
        nav.navigationBar.translucent = NO;
        nav.navigationBar.shadowImage = [[UIImage alloc] init];
        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [nav.navigationBar setTintColor:[UIColor whiteColor]];
        [nav.navigationBar setBarTintColor:COLORFROM16(0x62ac93, 1)];
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [self addChildViewController:nav];
    }
}

#pragma DBHTabBarDelegate
/**
 *  点击了加号按钮
 */
- (void)tabBarDidClickPlusButton:(DBHTabBar *)tabBar
{
    UIAlertController *promptAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了加号按钮" preferredStyle:UIAlertControllerStyleAlert];
    [promptAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:promptAlert animated:YES completion:nil];
}

#pragma mark - Getters And Setters
- (NSArray *)vcTitleArray {
    if (!_vcTitleArray) {
        _vcTitleArray = @[@"私人医生", @"有偿问诊", @"平台推荐", @"我"];
    }
    return _vcTitleArray;
}
- (NSArray *)vcItemArray {
    if (!_vcItemArray) {
        _vcItemArray = @[@"医生footer", @"问诊footer", @"推荐footer", @"我的footer"];
    }
    return _vcItemArray;
}

@end
