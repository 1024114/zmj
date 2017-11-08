//
//  DetailViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 admin2. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UILabel *starDayLbl;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (weak, nonatomic) IBOutlet UILabel *endDayLal;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImage;
@property (weak, nonatomic) IBOutlet UIButton *roomTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *breakfastLbl;
@property (weak, nonatomic) IBOutlet UILabel *roomArea;
@property (weak, nonatomic) IBOutlet UILabel *bedTypeLal;
@property (weak, nonatomic) IBOutlet UILabel *parkLbl;
@property (weak, nonatomic) IBOutlet UILabel *pickUpLbl;//接机服务
@property (weak, nonatomic) IBOutlet UILabel *fitnessLbl;//健身
@property (weak, nonatomic) IBOutlet UILabel *freeProductLbl;//免费产品
@property (weak, nonatomic) IBOutlet UILabel *freeWifi;
@property (weak, nonatomic) IBOutlet UILabel *wakeUpLbl;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLbl;
@property (weak, nonatomic) IBOutlet UILabel *luggageLbl;//行李寄存
@property (weak, nonatomic) IBOutlet UILabel *checkInTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *leaveTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *isCarrayPetLbl;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;
- (IBAction)purchaseAction:(UIButton *)sender forEvent:(UIEvent *)event;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)purchaseAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
