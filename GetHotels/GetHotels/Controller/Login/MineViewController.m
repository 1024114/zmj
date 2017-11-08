//
//  MineViewController.m
//  GetHotels
//
//  Created by admin1 on 2017/11/7.
//  Copyright © 2017年 admin2. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *UsernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *LoginLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
- (IBAction)ActionLoginBtn:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong,nonatomic)NSArray *array;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个方法用来做一些数据的初始化
-(void)dataInitialize{
    _array = @[@"我的活动",@"我的推广",@"积分中心",@"意见反馈",@"关于我们"];
    
}
//这个方法用来设置一些控件的属性
-(void)uiLayout{
    //去掉tableView底部多余的分隔线
    _tableView.tableFooterView = _footerView;
    //设置头像为圆形
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
    //设置边框
    _headImageView.layer.borderWidth = 2;
    _headImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}
-(void)uiReset{
    //用来判断当前有没有登录
    if ([Utilities loginCheck]) {
        _LoginLabel.hidden = YES;
        _UsernameLabel.hidden = NO;
//        //通过StorageMgr拿到登录后存起来的用户信息
//        UsersModel *userModel = [[StorageMgr singletonStorageMgr] objectForKey:@"UsersInfo"];
//        //设置头像
//        [_headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.headImage] placeholderImage:[UIImage imageNamed:@"ic_user_head"]];
//        //设置昵称
//        _UsernameLabel.text = userModel.nickName;
    } else{
        _headImageView.image = [UIImage imageNamed:@"ic_user_head"];
        _UsernameLabel.hidden = YES;
        _LoginLabel.hidden = NO;
    }
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //通过Identifier拿到对应的细胞
    UITableViewCell *cell = nil;
    //判断当前的行是否为空行，分别拿到对应的细胞
    if (indexPath.row == _array.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spaceCell" forIndexPath:indexPath];
    } else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell" forIndexPath:indexPath];
        //通过当前的行号去数据中拿数据
        NSString *title = _array[indexPath.row];
        //设置细胞上控件的属性
        cell.textLabel.text = title;
        cell.textLabel.textColor = [UIColor grayColor];
    }
    return cell;
}
//设置细胞高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _array.count) {
        return 0;
    }
    return 50;
}
//选中行时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消当前选中行的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //当用户登录才跳页
    if ([Utilities loginCheck]) {
        //根据当前选中的行来判断要跳到哪个页面
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"mineToMyActivity" sender:nil];
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
                
            default:
                break;
        }
    } else{
        //跳转到登录页面
        //拿到要跳转页面的导航控制器
        UINavigationController *loginNC = [Utilities getStoryboardInstance:@"Login" byIdentity:@"Login"];
        //以modal的方式跳页
        [self presentViewController:loginNC animated:YES completion:^{
        }];
        
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionLoginBtn:(UIButton *)sender forEvent:(UIEvent *)event {
   
        
    
}
@end
