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
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
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

- (IBAction)releaseAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
