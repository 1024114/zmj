//
//  LoginViewController.m
//  GetHotels
//
//  Created by admin1 on 2017/11/8.
//  Copyright © 2017年 admin2. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *UsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)joinUsAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //值不为null
    if ([[Utilities getUserDefaults:@"Username"] isKindOfClass:[NSNull class]]) {
        //值不为nil
        if ([Utilities getUserDefaults:@"Username"] != nil) {
            //将值设置给文本输入框
            _UsernameTextField = [Utilities getUserDefaults:@"Username"];
        }
    }
}

//设置导航栏的方法
- (void)navigationConfiguration{
    //设置导航栏标题颜色
    //创建一个属性字典
    NSDictionary *titleTextOption = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //将上述的数字字典配置给导航栏的标题
    [self.navigationController.navigationBar setTitleTextAttributes:titleTextOption];
    //设置导航栏颜色（风格颜色：导航栏整体的背景色和状态栏整体的背景色）
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
}
#pragma mark - Request
//获取加密所需的模数和指数
-(void)readyEncoding{
    //创建一个蒙层并开始动画
    UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
    NSDictionary *para = @{@"deviceType":@7001,@"deviceId":[Utilities uniqueVendor]};
    //开始网络请求
    [RequestAPI requestURL:@"/login/getKey" withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
        //让蒙层停止转动
        [aiv stopAnimating];
        NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"resultFlag"] integerValue] == 8001) {
            //从接口返回的数据中拿值
            NSDictionary *result = responseObject[@"result"];
            //每次在添加单例化全局变量的时候，先根据键删除一遍
            [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Exponent"];
            [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Modulus"];
            //将模数和指数拿出来存到临时的单例化全局变量中
            [[StorageMgr singletonStorageMgr] addKey:@"Exponent" andValue:result[@"exponent"]];
            [[StorageMgr singletonStorageMgr] addKey:@"Modulus" andValue:result[@"modulus"]];
//            //调用登录的方法
//            [self login];
        }else{
            //业务逻辑的失败
            [Utilities popUpAlertViewWithMsg:@"请求失败，请稍后再试" andTitle:@"提示" onView:self onCompletion:^{}];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        //让蒙层停止转动
        [aiv stopAnimating];
        [Utilities popUpAlertViewWithMsg:@"网络错误，请稍后再试" andTitle:@"提示" onView:self onCompletion:^{}];
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

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //判断用户名的输入框有每一内容
    if (_UsernameTextField  .text.length == 0 || _PwdTextField.text.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入用户名或密码" andTitle:nil onView:self onCompletion:^{
            
        }];
        return;
    }
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //判断用户名的长度是否为11位，是否全是数字
    if (_UsernameTextField.text.length != 11 || [_UsernameTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound) {
        [Utilities popUpAlertViewWithMsg:@"请输入正确的用户名" andTitle:nil onView:self onCompletion:^{
            
        }];
        return;
    }
    [self readyEncoding];
}


- (IBAction)joinUsAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //通过segue来跳页
    [self performSegueWithIdentifier:@"loginTosignUp" sender:nil];
}
@end
