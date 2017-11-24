//
//  ChooseCityTableViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "ChooseCityTableViewController.h"
#import <CoreLocation/CoreLocation.h>//使用该框架才可以使用定位功能

@interface ChooseCityTableViewController ()<CLLocationManagerDelegate>{
    BOOL firstVisit;
}
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) NSDictionary *cities;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) CLLocationManager *locMgr;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation ChooseCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self uilayout];
    [self dataInitialize];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每次将要离开这个页面的时候
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //关掉开关
    [_locMgr stopUpdatingLocation];
}
#pragma mark - Table view data source


//这个方法专门做导航条的控制
- (void)naviConfig{
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否被隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
    //    //为导航条左上角创建一个按钮
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backAction)];
    //    self.navigationItem.leftBarButtonItem = left;
}

- (void) uilayout {
    if (![[[StorageMgr singletonStorageMgr] objectForKey:@"LocCity"] isKindOfClass:[NSNull class]]) {
        if ([[StorageMgr singletonStorageMgr] objectForKey:@"LocCity"] != nil) {
            //已获取定位，将定位到的城市显示在按钮上
            [_cityBtn setTitle:[[StorageMgr singletonStorageMgr] objectForKey:@"LocCity"] forState:UIControlStateNormal];
            _cityBtn.enabled = YES;
            return;
        }
    }
    //当还没获取定位的情况下，去执行定位功能
    [self locationStart];
    
    
}

- (void) locationStart {
    //这个方法专门处理定位的基本设置
    _locMgr = [CLLocationManager new];
    //签协议
    _locMgr.delegate = self;
    //定位到的设备位移多少距离进行一次识别
    _locMgr.distanceFilter = kCLHeadingFilterNone;
    //设置把地球分割成边长多少精度的方块
    _locMgr.desiredAccuracy = kCLLocationAccuracyBest;
    //打开定位服务的开关（开始定位）
    [_locMgr startUpdatingLocation];
}


//- (void)backAction{
//    //消失页面
//    [self dismissViewControllerAnimated:YES completion:nil];
//    //[self.navigationController popViewControllerAnimated:YES];//用push返回上一页
//}

- (void) dataInitialize {
    firstVisit = YES;
    //创建文件管理器
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    //获取要获取的文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"];
    //判断路径下是否存在文件
    if ([fileMgr fileExistsAtPath:filePath]) {
        //将文件内容读取为对应文件
        NSDictionary *fileContent = [NSDictionary dictionaryWithContentsOfFile:filePath];
        //判断读取到的内容是否存在
        if (fileContent) {
            // NSLog(@"fileContent:%@",fileContent);
            _cities = fileContent;
            //获取字典所有的键
            NSArray *rawKeys = [fileContent allKeys];
            //根据拼音首字母进行能够识别多音字的升序排序
            _keys = [rawKeys sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //获取当前正在渲染的组的名称
    NSString *key = _keys[section];
    //根据组的名称作为键，来查询到对应的值
    NSDictionary *sectionCities = _cities[key];
    //返回这一组城市的个数来作为行数
    return sectionCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    //获取当前正在渲染的组的名称
    NSString *key = _keys[indexPath.section];
    //根据组的名称作为键，来查询到对应的值
    NSArray *sectionCities = _cities[key];
    NSDictionary *city = sectionCities[indexPath.row];
    cell.textLabel.text =city[@"name"];
    
    return cell;
}
//设置组的头标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _keys[section];
}
//设置section header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}
//按住细胞以后（取消选择）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //获取当前正在渲染的组的名称
    NSString *key = _keys[indexPath.section];
    //根据组的名称作为键，来查询到对应的值（这个值就是这一组城市对应城市数组）
    NSArray *sectionCities = _cities[key];
    NSDictionary *city = sectionCities[indexPath.row];
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"ResetHome" object:city[@"name"]] waitUntilDone:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//设置右侧快捷键的栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (IBAction)cityAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    
    NSNotification *note = [NSNotification notificationWithName:@"ResetHome" object:[[StorageMgr singletonStorageMgr] objectForKey:@"LocCity"]];
    //结合线程的通知，表示先让通知接收者完成它收到通知要做的事以后再执行别的任务
    [noteCenter performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES];
    //返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
