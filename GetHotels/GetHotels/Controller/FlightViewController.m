//
//  FlightViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/02.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "FlightViewController.h"


@interface FlightViewController (){
    BOOL tags;
    BOOL tagsCity;
    
}
@property (weak, nonatomic) IBOutlet UIButton *lowTimeBtn;//最早时间
@property (weak, nonatomic) IBOutlet UIButton *highTimeBtn;//最晚时间
@property (weak, nonatomic) IBOutlet UIButton *startBtn;//出发地
@property (weak, nonatomic) IBOutlet UIButton *endBtn;//目的地
@property (weak, nonatomic) IBOutlet UITextField *lowPriceTextField;//最低价格
@property (weak, nonatomic) IBOutlet UITextField *highPriceTextField;//最高价格
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;//标题
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;//详情
- (IBAction)lowTimeAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)highTimeAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)startAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)endAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)connectAction:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIView *view1;
- (IBAction)cancelAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)postAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property(nonatomic)NSTimeInterval startTime;
@property(nonatomic)NSTimeInterval arrTime;
@property(nonatomic)NSTimeInterval tempTime;
@property(strong,nonatomic)NSMutableArray *selectOfferArr;
@property (weak, nonatomic) IBOutlet UIView *View2;

@end

@implementation FlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInitialize];
    [self uiLayout];
    [self navigationConfiguration];
    //监听选择城市后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetHome:) name:@"ResetHome" object:nil];
//    //注册键盘弹出通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
//    //注册键盘隐藏通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)name:UIKeyboardWillHideNotification object:nil];
    [self setShadow];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//关于数据的初始化
-(void)dataInitialize{
    _startTime = [NSDate.date timeIntervalSince1970];
    _arrTime = [NSDate.dateTomorrow timeIntervalSince1970];
    _selectOfferArr = [NSMutableArray new];
    tags = nil;
    tagsCity = nil;
}

//关于界面的操作
-(void)uiLayout{
    [[UIPickerView appearance] setBackgroundColor:[UIColor whiteColor]];
}

//设置导航栏的方法
- (void)navigationConfiguration{
    //设置导航栏标题颜色
    //创建一个属性字典
    NSDictionary *titleTextOption = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //将上述的数字字典配置给导航栏的标题
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextOption];
    //更改导航栏的标题
    self.navigationItem.title = @"发布需求";
    //设置导航栏颜色（风格颜色：导航栏整体的背景色和状态栏整体的背景色）
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:41.f/255.f green:124.f/255.f blue:246.f/255.f alpha:1];
    //配置导航栏的毛玻璃效果 YES表示有  NO表示没有
    [self.navigationController.navigationBar setTranslucent:NO];
    //设置导航栏是否隐藏
    self.navigationController.navigationBar.hidden = NO;
    //配置导航栏上的item的风格颜色（如果是文字则文字变成白色，如果是图片则图片的透明部分变成白色）
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - Hiddenkeyboard
//Return键是否能被点击 返回YES表示能点，返回NO表示不能被点
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //收起键盘
    //[textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

//点击键盘以外的部分收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

////键盘弹出后将视图向上移动
//-(void)keyboardWillShow:(NSNotification *)note
//{
//    NSDictionary *info = [note userInfo];
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    //目标视图
//    CGRect frame = _view1.frame;
//    int y = frame.origin.y + frame.size.height - (self.view.frame.size.height - keyboardSize.height);
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeView" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    if(y > 0)
//    {
//        self.view.frame = CGRectMake(0, -y, self.view.frame.size.width, self.view.frame.size.height);
//    }
//    [UIView commitAnimations];
//}

//键盘隐藏后将视图恢复到原始状态
-(void)keyboardWillHide:(NSNotification *)note
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma  mark - notification
-(void)checkDepartCity:(NSNotification *)note{
    NSString *cityStr=note.object;
    if(![_startBtn.titleLabel.text isEqualToString:cityStr]){
        [_startBtn setTitle:cityStr forState:UIControlStateNormal];
    }
}
-(void)checkDestinationCity:(NSNotification *)note{
    NSString *cityStr=note.object;
    if(![_endBtn.titleLabel.text isEqualToString:cityStr]){
        [_endBtn setTitle:cityStr forState:UIControlStateNormal];
    }
}

//监听到选择城市的通知后做什么
-(void)resetHome:(NSNotification *)notification{
    NSLog(@"监听到了");
    //拿到通知所携带的参数
    NSString *city = notification.object;
    if (tagsCity) {
        [_endBtn setTitle:city forState:UIControlStateNormal];
    } else{
        [_startBtn setTitle:city forState:UIControlStateNormal];
    }
}
#pragma mark -request
//发布
-(void)offerRequest{
    NSString *lowTime = _lowTimeBtn.titleLabel.text;
    NSString *highTime = _highTimeBtn.titleLabel.text;
    NSString *start = _startBtn.titleLabel.text;
    NSString *end = _endBtn.titleLabel.text;
    NSString *lowPrice = _lowPriceTextField.text;
    NSString *highPrice = _highPriceTextField.text;
    NSString *setHour = @"0-24";
    NSString *detail = _detailTextField.text;
    NSString *peopleNumber = @"1";
    NSString *childNumber = @"1";
    NSString *weight = @"1";
    
    NSDictionary *para = @{@"openid":[Utilities getUserDefaults:@"openid"],@"set_low_time_str":lowTime,@"set_high_time_str":highTime,@"set_hour":setHour,@"departure":start,@"destination":end,@"low_price":lowPrice,@"high_price":highPrice,@"people_number":peopleNumber,@"child_number":childNumber,@"weight":weight,@"aviation_demand_detail":detail};
    [RequestAPI requestURL:@"/addIssue_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [Utilities popUpAlertViewWithMsg:@"发布成功" andTitle:@"提示" onView:self];
    } failure:^(NSInteger statusCode, NSError *error) {}];
    [Utilities popUpAlertViewWithMsg:@"发布失败" andTitle:@"提示" onView:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender{
    if ([segue.identifier isEqualToString:@"offerToCity"]) {
    }
}
- (void)setShadow {
    
    _View2.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _View2.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _View2.layer.shadowOpacity = 0.7f;//阴影透明度，默认0
    _View2.layer.shadowRadius = 4.f;//阴影半径，默认3
}
- (IBAction)lowTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _bottomView.hidden = NO;
    tags=YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)highTimeAction:(UIButton *)sender forEvent:(UIEvent *)event {
    _bottomView.hidden = NO;
    tags=NO;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)startAction:(UIButton *)sender forEvent:(UIEvent *)event {
    tagsCity = NO;
    [self performSegueWithIdentifier:@"flightToCity" sender:nil];
}

- (IBAction)endAction:(UIButton *)sender forEvent:(UIEvent *)event {
    tagsCity = YES;
    [self performSegueWithIdentifier:@"flightToCity" sender:nil];
}

- (IBAction)connectAction:(UIBarButtonItem *)sender {
    if(tags){
        NSDate *pickerDate= _pickerView.date;
        //datetemp=_datePicker.date;
        _tempTime = [pickerDate timeIntervalSince1970];
        if (_startTime > _arrTime) {
            [Utilities popUpAlertViewWithMsg:@"时间有误" andTitle:@"提示" onView:self];
            return;
        }
        NSDateFormatter *pickerFormatter =[[NSDateFormatter alloc ]init];
        [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *startString =[pickerFormatter stringFromDate:pickerDate];
        [_lowTimeBtn setTitle:startString forState:UIControlStateNormal];
        _bottomView.hidden=YES;
    }
    
    else{
        
        NSDate *pickerDate= _pickerView.date;
        _tempTime = [pickerDate timeIntervalSince1970];
        if (_tempTime < _arrTime) {
            [Utilities popUpAlertViewWithMsg:@"时间有误" andTitle:@"提示" onView:self];
            return;
        }
        NSDateFormatter *pickerFormatter =[[NSDateFormatter alloc ]init];
        [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *endString =[pickerFormatter stringFromDate:pickerDate];
        [_highTimeBtn setTitle:endString forState:UIControlStateNormal];
        _bottomView.hidden=YES;
        
    }
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    _bottomView.hidden = YES;
}
- (IBAction)postAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if ([_lowTimeBtn.titleLabel.text isEqualToString:@"2月24日"]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_highTimeBtn.titleLabel.text isEqualToString:@"2月25日"]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_startBtn.titleLabel.text isEqualToString:@"请选择城市"]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_endBtn.titleLabel.text isEqualToString:@"请选择城市"]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_lowPriceTextField.text isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_highPriceTextField.text isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else if ([_titleTextField.text isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整" andTitle:@"提示" onView:self];
    }else {
        [self offerRequest];
    }
}
@end
