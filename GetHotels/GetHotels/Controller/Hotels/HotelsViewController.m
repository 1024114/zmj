//
//  HotelsViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/6.
//  Copyright © 2017年 Education. All rights reserved.
//

#import "HotelsViewController.h"

@interface HotelsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UITableView *hotelsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *MysearchBar;
@property (weak, nonatomic) IBOutlet UIView *CycleAdView;

@property (strong, nonatomic) CLLocationManager *locMgr;
@property (strong, nonatomic) CLLocation *location;
@property (strong,nonatomic)NSString *city_name;
@property (strong,nonatomic)NSString *inTime;
@property (strong,nonatomic)NSString *outTime;
@property (strong,nonatomic)NSString *sortingId;
@property (strong,nonatomic)NSString *wxlongitude;
@property (strong,nonatomic)NSString *wxlatitude;
@property (strong,nonatomic)UIActivityIndicatorView *avi;
@property (strong, nonatomic) NSMutableArray *firstResArr;
@property (strong, nonatomic) NSMutableArray *AdImgarr;
@property (strong, nonatomic) NSMutableArray *AdImgarr1;

@end

@implementation HotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // Do any additional setup after loading the view.
    //    _AdImgarr1  = [[NSMutableArray alloc]initWithObjects:@"http://ac-tscmo0vq.clouddn.com/2a4957a871985ea0b0ec.png",@"http://ac-tscmo0vq.clouddn.com/8060e54840115e3dc743.png",@"http://ac-tscmo0vq.clouddn.com/1cbe1d0ad3bae6214d59.jpg",@"http://ac-tscmo0vq.clouddn.com/b3ca642f7a9297e907c7.jpg",@"http://ac-tscmo0vq.clouddn.com/5c1f5d0dd16e0888ecd0.jpg",nil];
    flag = YES;
    _AdImgarr  =   [NSMutableArray new];
    _firstResArr = [NSMutableArray new];
    pageNum = 1;
    pageSize = 10;
    startId = 1;
    priceId = 1;
    _inTime = @"2017-11-06";
    _outTime = @"2017-11-10";
    _sortingId = @"1";
    _city_name = @"无锡";//[[Utilities getUserDefaults:@"UserCity"] isKindOfClass:[NSNull class]]?@"无锡":[Utilities getUserDefaults:@"UserCity"] ;
    
    //NSLog(@"%@",[Utilities getUserDefaults:@"UserCity"]);
    _wxlongitude = @"120.300000";
    
    
    //     double loc = _location.coordinate.longitude;
    //    _wxlongitude = [NSString stringWithFormat:@"%f",loc];
    
    _wxlatitude =@"31.570000";
    
    [self naviConfig];
    [self netRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkCityState:) name:@"ResetHome" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每次将要来到这个页面的时候
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self locationConfig];
    [self locationStart];
    [self dataInitialize];
    
}
//每次将要离开这个页面的时候
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //关掉开关
    [_locMgr stopUpdatingLocation];
}

- (void)naviConfig{
    self.navigationItem.title = @"GetHotels";
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
    _MysearchBar.layer.borderWidth = 0;
    // _MysearchBar.layer.borderColor = [UIColor whiteColor];    //_MysearchBar.delegate = self;
    _MysearchBar.barStyle=UIBarStyleDefault;
    
    [ _MysearchBar setShowsCancelButton:NO];//显示右侧取消按钮
    _MysearchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    
}
//键盘收回
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //让根视图结束编辑状态达到收起键盘的目的
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//重设初始响应器
    return YES;
}

-(void) addZLImageViewDisPlayView:(NSArray *)arr{
    CGRect frame = CGRectMake(0,0, UI_SCREEN_W, 160);
    //初始化控件
    ZLImageViewDisplayView *imageViewDisplay = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:frame];
    imageViewDisplay.imageViewArray = arr;
    imageViewDisplay.scrollInterval = 3;
    imageViewDisplay.animationInterVale = 0.6;
    [_CycleAdView addSubview:imageViewDisplay];
}
//这个方法专门做数据的处理
- (void)dataInitialize{
    BOOL appInit = NO;
    if ([[Utilities getUserDefaults:@"UserCity"] isKindOfClass:[NSNull class]]) {
        //说明是第一次打开APP
        appInit = YES;
    } else {
        if ([Utilities getUserDefaults:@"UserCity"] == nil) {
            //也说明是第一次打开APP
            appInit = YES;
        }
    }
    if (appInit) {
        NSString *userCity = _cityBtn.titleLabel.text;
        
        [Utilities setUserDefaults:@"UserCity" content:userCity];
        
    } else {
        //不是第一次来到APP则将记忆城市与按钮上的城市名反向同步
        NSString *userCity = [Utilities getUserDefaults:@"UserCity"];
        [_cityBtn setTitle:userCity forState:UIControlStateNormal];
    }
    // _city_name = _cityBtn.titleLabel.text;
    // NSLog(@"city name:%@",_city_name);
    firstVisit = YES;
    isLoding = NO;
}

- (void)netRequest{
    // NSLog(@"city_name:%@",_city_name);
    _avi = [Utilities getCoverOnView:self.view];
    NSDictionary *para =  @{@"city_name":_city_name,@"pageNum":@(pageNum),@"pageSize":@(pageSize),@"startId":@(startId),@"priceId":@(priceId),@"sortingId":_sortingId,@"inTime":_inTime,@"outTime":_outTime,@"wxlatitude":_wxlatitude ,@"wxlongitude":_wxlongitude};
    [RequestAPI requestURL:@"/findHotelByCity_edu" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        //NSLog(@"responseObject:%@", responseObject);
        [_avi stopAnimating];
        
        if([responseObject[@"result"] integerValue] == 1){
            NSDictionary *content = responseObject[@"content"];
            NSArray *result = content[@"hotel"][@"list"];
            NSArray *Adarr  = content[@"advertising"];
            for (NSDictionary *dict in Adarr) {
                HotelsModel *resultModel = [[HotelsModel alloc] initWithAdImgDict:dict];
                [ _AdImgarr addObject:resultModel.AdImg];
 
            }
            // NSLog(@"网址：%@",_AdImgarr[1]);
            if(flag){
                flag = NO;
                [self addZLImageViewDisPlayView:_AdImgarr];
            }
            for (NSDictionary *dict in result) {
                HotelsModel *resultModel = [[HotelsModel alloc] initWithDict:dict];
                // NSLog(@"结果：%@",resultModel.hotelId);
                
                [_firstResArr addObject:resultModel];
                
            }
            
            [_hotelsTableView reloadData];
            
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
