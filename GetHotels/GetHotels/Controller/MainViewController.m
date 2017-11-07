//
//  MainViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/7.
//  Copyright © 2017年 admin2. All rights reserved.
//

#import "MainViewController.h"
#import "Utilities.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *vc = [Utilities getStoryboardInstance:@"Hotel" byIdentity:@"Hotel"];
    [self setupOneChildViewController:vc title:@"酒店" image:@"hotel"];
    
    UIViewController *nc = [Utilities getStoryboardInstance:@"Aviation" byIdentity:@"aviation"];
    [self setupOneChildViewController:nc title:@"航空" image:@"aviation"];
    
    UIViewController *ac = [Utilities getStoryboardInstance:@"Mine" byIdentity:@"Mine"];
    [self setupOneChildViewController:ac title:@"我的" image:@"mhstate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image{
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值，判断图片传入值是空还是nil
        vc.tabBarItem.image = [UIImage imageNamed:image];
    }
    [self addChildViewController:vc];
    
    
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
