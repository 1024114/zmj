//
//  FlightViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/02.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "FlightViewController.h"

@interface FlightViewController ()
@property (weak, nonatomic) IBOutlet UILabel *setOutDate;
@property (weak, nonatomic) IBOutlet UILabel *setOutDay;
@property (weak, nonatomic) IBOutlet UILabel *arriveDate;
@property (weak, nonatomic) IBOutlet UILabel *arriveDay;
@property (weak, nonatomic) IBOutlet UILabel *setOutCity;
@property (weak, nonatomic) IBOutlet UILabel *arriveCity;
@property (weak, nonatomic) IBOutlet UITextField *lowPrice;
@property (weak, nonatomic) IBOutlet UITextField *highPrice;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;
@property (weak, nonatomic) IBOutlet UIButton *releaseBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *addressPickerView;

- (IBAction)releaseAction:(UIButton *)sender forEvent:(UIEvent *)event;
@end

@implementation FlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//这个方法做导航条的基本属性设置
-(void)naviConfig{
    self.navigationItem.title = @"航空";
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(20, 124, 236);
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否被隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1.0f]];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)releaseAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
