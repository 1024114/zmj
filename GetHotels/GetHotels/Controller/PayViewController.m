//
//  PayViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/05.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "PayViewController.h"
#import "PayTableViewCell.h"
#import "DetailViewController.h"
#import "GBAlipayManager.h"
@interface PayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *hotelNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIButton *PayBtn;
- (IBAction)PayAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UITableView *PayTableView;

@property (strong,nonatomic)NSArray *arr;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr = @[@"支付宝支付",@"微信支付",@"银联支付"];
    [self naviConfig];
    [self uiLayout];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)naviConfig{
    self.navigationItem.title = @"支付";
    //实例化一个button 类型为UIButtonTypeSystem
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //设置位置大小
    leftBtn.frame = CGRectMake(0, 0, 15, 20);
    //设置其背景图片为返回图片
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    //给按钮添加事件
    //[leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
}

- (void)uiLayout{
    _hotelNameLbl.text = _payModel.hotel_name;
    _priceLbl.text = [NSString stringWithFormat:@"%@元",_payModel.price];
    NSString *startTime = [[StorageMgr singletonStorageMgr]objectForKey:@"startTime"];
    NSString *endTime = [[StorageMgr singletonStorageMgr]objectForKey:@"endTime"];
    _dateLbl.text = [NSString stringWithFormat:@"%@——%@",startTime,endTime];
    self.PayTableView.tableFooterView = [UIView new];
   //将表格视图设置为“编辑”
    self.PayTableView.editing = YES;
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    //用代码表示视图中的某个cell
    [self.PayTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
}

//设置每一行被点击以后要做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //遍历表格视图中选中状态下的cell
    for(NSIndexPath *eachIP in tableView.indexPathsForSelectedRows){
        //当选中的cell不是当前正在按得时候
        if(eachIP != indexPath)
            //取消cell选中状态
            [tableView deselectRowAtIndexPath:eachIP animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell" forIndexPath:indexPath];
    
    cell.PayTypeLbl.text = _arr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
//设置组的头标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"支付方式";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PayAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //拿到选中行的行号
    NSInteger row = [self.PayTableView indexPathForSelectedRow].row;
    switch (row) {
        case 0:
        {
            NSString *tradeNO = [GBAlipayManager generateTradeNO];
            [GBAlipayManager alipayWithProductName:_name amount:_applyFee tradeNO:tradeNO notifyURL:[NSString stringWithFormat:@"www.fisheep.com?tradeNO=%@",tradeNO] productDescription:[NSString stringWithFormat:@"%@",_name] itBPay:@"30"];
        };
            break;
        case 1:
            
            break;
            
        default:
            
            break;
    }
}
//监听到支付结果后做什么
-(void)dealAlipayResult:(NSNotification *)notification{
    //拿到通知携带的参数
    NSString *result = notification.object;
    if([result isEqualToString:@"9000"]){
        [self payResultAlert:@"支付成功"];
    }else{
        [self payResultAlert:@"支付失败"];
        
    }
    
}
-(void)payResultAlert:(NSString *)message{
    //创建提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功!" preferredStyle:UIAlertControllerStyleAlert];
    //按钮
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //回到上个页面
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //将按钮添加到提示框中
    [alert addAction:action];
    //显示提示框
    [self presentViewController:alert animated:YES completion:nil];
}
@end
