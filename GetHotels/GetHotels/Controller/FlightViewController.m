//
//  FlightViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/02.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "FlightViewController.h"

@interface FlightViewController (){
    NSTimeInterval StartTime;
    NSTimeInterval EndTime;
    NSInteger flag;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *setOutDay;

@property (weak, nonatomic) IBOutlet UILabel *arriveDay;
@property (weak, nonatomic) IBOutlet UIButton *setOutDate;
@property (weak, nonatomic) IBOutlet UIButton *arriveDate;
@property (weak, nonatomic) IBOutlet UIButton *setOutCity;
@property (weak, nonatomic) IBOutlet UIButton *arriveCity;


@property (weak, nonatomic) IBOutlet UITextField *lowPrice;
@property (weak, nonatomic) IBOutlet UITextField *highPrice;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;
@property (weak, nonatomic) IBOutlet UIButton *releaseBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePickerView;


- (IBAction)setOutDateAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)arriveDateAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)setOutCityAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)arriveCityAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)releaseAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong,nonatomic)NSString *istoDay;
@end

@implementation FlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
//    [self offerRequest];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    //设置pickView的背景颜色
    _timePickerView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
   
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
    //设置头像为圆形
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 3;
    
}
////监听到选择城市的通知后做什么
//-(void)resetHome:(NSNotification *)notification{
//    //NSLog(@"监听到了");
//    //拿到通知所携带的参数
//    NSString *city = notification.object;
//    //非空检查
//    if (![[Utilities getUserDefaults:@"UserCity"] isKindOfClass:[NSNull class]]) {
//        if ([Utilities getUserDefaults:@"UserCity"] != nil) {
//            //判断选择到的城市名和当前页面显示的城市名是否一致
//            if (![[Utilities getUserDefaults:@"UserCity"] isEqualToString:city]) {
//                //不但要替换掉城市按钮的标题，而且还要替换单例化全局变量中的值
//                [Utilities removeUserDefaults:@"UserCity"];
//                [Utilities setUserDefaults:@"UserCity" content:city];
//            }
//        }
//    }
//}
//
//
//-(void)offerRequest{
//    double price=[_lowPrice.text doubleValue];//价格
//
//
//    NSString *intimestr=_setOutDate.titleLabel.text;//出发时间
//
//    NSString *outtimestr=_arriveDate.titleLabel.text;//到达时间
//    NSString *departurestr=_setOutCity.titleLabel.text;//出发地
//    NSString *destinationstr=_arriveCity.titleLabel.text;//目的地
// //航班
//
//    NSDictionary *para=@{@"business_id":@2,@"aviation_demand_id":[[StorageMgr singletonStorageMgr]objectForKey:@"id"],@"final_price":@(price),@"in_time_str":intimestr,@"out_time_str":outtimestr,@"departure":departurestr,@"destination":destinationstr};
//    [RequestAPI requestURL:@"/offer_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
//
//
//    } failure:^(NSInteger statusCode, NSError *error) {}];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)uiLayout{
    _setOutDate = [NSDate date];//调用该行代码的时间
    NSDateFormatter *nowformatter = [[NSDateFormatter alloc] init];
    nowformatter.dateFormat = @"MM月dd日";
    _istoDay = [nowformatter stringFromDate:_setOutDate];
    [[StorageMgr singletonStorageMgr] addKey:@"startTime" andValue:_istoDay];
    [_setOutDate setTitle:_istoDay forState:UIControlStateNormal];
    _setOutDate.titleLabel.text = _istoDay;
}


- (IBAction)setOutDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSTimeInterval  setOutDateAction = [Utilities cTimestampFromString:_setOutDate.titleLabel.text format:@"MM月dd日"];
    NSLog(@"setOut:%f",setOutDateAction);
    //显示PickerView
    _timePickerView.hidden = NO;
}

- (IBAction)arriveDateAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _timePickerView.hidden = NO;
}

- (IBAction)setOutCityAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)arriveCityAction:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)releaseAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
}
@end
