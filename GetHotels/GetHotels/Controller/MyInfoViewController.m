//
//  MyInfoViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/02.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoTableViewCell.h"
#import "UserModel.h"
@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITableView *myInfoTableView;
- (IBAction)LoginBtn:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong, nonatomic)NSArray *myInfoArr;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
    _myInfoArr = @[@{@"leftIcon":@"酒店",@"title":@"我的酒店"},@{@"leftIcon":@"航班",@"title":@"我的航空"},@{@"leftIcon":@"news",@"title":@"我的消息"},@{@"leftIcon":@"账户设置",@"title":@"账户设置"},@{@"leftIcon":@"使用协议",@"title":@"使用协议"},@{@"leftIcon":@"联系客服",@"title":@"联系客服"}];
    [self uiLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//这个方法做导航条的基本属性设置
-(void)naviConfig{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationItem.title = @"我的";
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(23, 124, 236);
    //设置导航栏标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否被隐藏
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条阿按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}
//当前页面将要显示的时候，隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([Utilities loginCheck]) {
        //已登录
        _loginBtn.hidden = YES;
        _userNameLabel.hidden = NO;
        _levelLabel.hidden = NO;
        _headImage.image = [UIImage imageNamed:@"icon"];
        //用一个model承接存在单例化全局变量中的Model
        UserModel *user = [[StorageMgr singletonStorageMgr] objectForKey:@"UserInfo"];
        _userNameLabel.text = user.nick_name;
        
    }else{
        _loginBtn.hidden = NO;
        _userNameLabel.hidden = YES;
        _levelLabel.hidden = YES;
        _headImage.image = [UIImage imageNamed:@"默认头像"];
       
    }
}

//这个方法用来设置一些控件的属性
-(void)uiLayout{
    
    //设置头像为圆形
    _headImage.layer.cornerRadius = _headImage.frame.size.width / 2;
    //设置边框
    _headImage.layer.borderWidth = 2;
    _headImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {· 111111
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//细胞有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _myInfoArr.count;
    
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myInfoCell" forIndexPath:indexPath];
    
    //根据行号拿到数组中对应的数据
    NSDictionary *dict = _myInfoArr[indexPath.section];
    cell.leftIcon.image = [UIImage imageNamed:dict[@"leftIcon"]];
    cell.titleLabel.text = dict[@"title"];
    return cell;
    
}
//设置细胞高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

//设置组的底部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 5.f;
    }
    return 1.f;
}


//按住细胞以后（取消选择）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([Utilities loginCheck]) {
    
        switch (indexPath.section) {
                case 0:{
                    [self performSegueWithIdentifier:@"myInfoToHotels" sender:self];
                }
                    break;
            case 1:{
                [self performSegueWithIdentifier:@"myInfoToAir" sender:self];
            }
                break;
            case 5:{
                //创建提示框
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否拨打客服电话13286535443" preferredStyle:UIAlertControllerStyleAlert];
                //创建提示框的确认按钮
                UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                //创建提示框的取消按钮
                UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                //将按钮添加到提示框中 （多个按钮从左到右，从上到下，如果按钮的风格是UIAlertActionStyleCancel 是中是最左或者最下）
                [alert addAction:actionA];
                [alert addAction:actionB];
                
                //显示提示框
                [self presentViewController:alert animated:YES completion:nil];
            }
                    
                default:
                    break;
            }
    
    }else{
    UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Myinfo" byIdentity:@"SignNavi"];
        [self presentViewController:signNavi animated:YES completion:nil];
        }
 }
 
 

- (IBAction)LoginBtn:(UIButton *)sender forEvent:(UIEvent *)event {
    UINavigationController *signNavi = [Utilities getStoryboardInstance:@"Myinfo" byIdentity:@"SignNavi"];
    [self presentViewController:signNavi animated:YES completion:nil];
       }
@end
