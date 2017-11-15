//
//  PayViewController.h
//  GetHotels
//
//  Created by admin on 2017/11/05.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelsModel.h"

@interface PayViewController : UIViewController
@property (strong,nonatomic)HotelsModel *payModel;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *applyFee;
@end
