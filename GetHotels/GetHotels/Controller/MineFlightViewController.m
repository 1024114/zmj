//
//  MineFlightViewController.m
//  GetHotels
//
//  Created by admin on 2017/11/27.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import "MineFlightViewController.h"
#import "NoQuotationTableViewCell.h"
#import "AlreadyOfferTableViewCell.h"
#import "ClinchTableViewCell.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface MineFlightViewController (){
    NSInteger NoQuotationPageNum;
    NSInteger AlreadyOfferPageNum;
    NSInteger ClinchPageNum;
}
@property (weak, nonatomic) IBOutlet UITableView *NoQuotationTableView;
@property (weak, nonatomic) IBOutlet UITableView *AlreadyOfferTableView;
@property (weak, nonatomic) IBOutlet UITableView *ClinchTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;
@property(strong,nonatomic)NSMutableArray *NoQuotationArr;

@end

@implementation MineFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiLayout];
    [self segmentedControlset];
    [self NoQuotationRequest];
    [self dataInitialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)uiLayout{
    //去掉tableView底部多余的线
    self.NoQuotationTableView.tableFooterView = [UITableView new];
    self.AlreadyOfferTableView.tableFooterView = [UITableView new];
    self.ClinchTableView.tableFooterView = [UITableView new];
}

-(void)dataInitialize{
    NoQuotationPageNum = 1;
    _NoQuotationArr = [NSMutableArray new];
}

//#pragma mark -scrollView
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if(scrollView==_scrollView){
//        NSInteger page = [self scrollCheck:scrollView];
//        [_segmentedControl4 setSelectedSegmentIndex:page animated:YES];
//    }
//}
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    if (scrollView == _scrollView) {
//        [self scrollCheck:scrollView];
//    }
//}
//- (NSInteger)scrollCheck: (UIScrollView *)scrollView{
//    NSInteger page = scrollView.contentOffset.x / (scrollView.frame.size.width);
//    if(staleFlag==1 && page==1){
//        staleFlag=0;
//        [self staleInitializeData];
//    }
//
//    return page;
//}

#pragma mark - Request
-(void)NoQuotationRequest{
    NSDictionary *para=@{@"openid":@"151028344495518800588806",@"pageNum":@(NoQuotationPageNum),@"pageSize":@10,@"state":@(2)};
    [RequestAPI requestURL:@"/findAllIssue_edu" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
    } failure:^(NSInteger statusCode, NSError *error) {

    }];
}

-(void)segmentedControlset{
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Tying up the segmented control to a scroll view
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 50)];
    self.segmentedControl4.sectionTitles = @[@"未报价", @"已报价",@"已成交"];
    self.segmentedControl4.selectedSegmentIndex = 0;
    //颜色
    self.segmentedControl4.backgroundColor = self.navigationController.navigationBar.barTintColor;
    self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor groupTableViewBackgroundColor]};
    self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl4.tag = 3;
    //把self转换成弱指针
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
}

////每组有多少行
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
////每行长什么样
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 1;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
