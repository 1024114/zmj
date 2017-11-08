//
//  SignUpViewController.m
//  GetHotels
//
//  Created by admin1 on 2017/11/8.
//  Copyright © 2017年 admin2. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置导航栏的方法
- (void)navigationConfiguration{
    //    //设置导航栏标题颜色
    self.navigationItem.title = @"注册";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Hiddenkeyboard
//Return键能不能被点，被点了做什么
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //让textField放弃第一响应者（收起键盘）
    [textField resignFirstResponder];
    return YES;
}
//点击键盘以外的部分收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
