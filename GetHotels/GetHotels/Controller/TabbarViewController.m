//
//  TabbarViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *nc = [Utilities getStoryboardInstance:@"Hotels" byIdentity:@"hotel"];
    nc.tabBarItem.image = [[UIImage imageNamed:@"hotel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    nc.tabBarItem.title = @"酒店";
    UIViewController *nc1 = [Utilities getStoryboardInstance:@"Flight" byIdentity:@"aviation"];
    nc1.tabBarItem.image = [[UIImage imageNamed:@"aviation"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    nc1.tabBarItem.title = @"航班";
    
    UIViewController *nc2 = [Utilities getStoryboardInstance:@"Myinfo" byIdentity:@"mhstate"];
    nc2.tabBarItem.image = [[UIImage imageNamed:@"mhstate"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    nc2.tabBarItem.title = @"我的";
    
    [self addChildViewController:nc];
    [self addChildViewController:nc1];
    [self addChildViewController:nc2];
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
