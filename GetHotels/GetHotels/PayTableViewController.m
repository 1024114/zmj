//
//  PayTableViewController.m
//  
//
//  Created by admin1 on 2017/11/7.
//

#import "PayTableViewController.h"
#import "GBAlipayManager.h"

@interface PayTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyFeeLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *querenBtn;
- (IBAction)ActionQuerenBtn:(UIButton *)sender forEvent:(UIEvent *)event;
@property (strong, nonatomic) NSArray *array;

@end

@implementation PayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiLayout];
    [self navigationConfiguration];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //初始化数组并添加对象
    _array = @[@"支付宝支付", @"微信支付", @"银联支付"];
    //调用配置导航栏的方法
  
    
    //注册监听，监听支付结果
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealAlipayResult:) name:@"AlipayResult" object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//配置导航栏的方法
-(void)navigationConfiguration{
    //更改导航栏的标题
    self.navigationItem.title = @"活动报名支付";
    //给导航栏右边添加一个Item
    UIBarButtonItem *rightItem  = [[UIBarButtonItem alloc] initWithTitle:@"支付" style:UIBarButtonItemStylePlain target:self action:@selector(payAction)];
    //将上述按钮添加到导航栏
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)uiLayout{
    //去掉底部多余的线
    self.tableView.tableFooterView = [UITableView new];
    //让tableView可编辑
    self.tableView.editing = YES;
    //让tableView默认选中第0行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
//    //设置头部视图中元素的属性
//    _nameLabel.text = _name;
//    _contentLabel.text = _content;
//    _applyFeeLabel.text = [NSString stringWithFormat:@"%@元", _applyFee];
}
#pragma mark - Table view data source
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

#pragma mark - Table view data source
//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //根据数组自适应行数
    return _array.count;
}



//每行长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //根据Identifier拿到细胞
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paycell" forIndexPath:indexPath];
    //根据行号当下标去数组中拿数据
    NSString *title = _array[indexPath.row];
    //将数据显示到细胞
    cell.textLabel.text = title;
    
    return cell;
}

//选中行的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //将之前选中的所有行的indexpath遍历出来
    for (NSIndexPath *eachIndexPath in tableView.indexPathsForSelectedRows) {
        //和当前选中的行的indexpath做对比，如果不一样将之前选中的行取消
        if (indexPath != eachIndexPath) {
            [tableView deselectRowAtIndexPath:eachIndexPath animated:NO];
        }
    }
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"支付方式";
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ActionQuerenBtn:(UIButton *)sender forEvent:(UIEvent *)event {
    //拿到选中行的行号
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    switch (row) {
        case 0:
        {
            NSString *tradeNO = [GBAlipayManager generateTradeNO];
//            [GBAlipayManager alipayWithProductName:_name amount:_applyFee tradeNO:tradeNO notifyURL:[NSString stringWithFormat:@"www.fisheep.com?tradeNO=%@",tradeNO] productDescription:[NSString stringWithFormat:@"%@活动报名费",_name] itBPay:@"30"];
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
