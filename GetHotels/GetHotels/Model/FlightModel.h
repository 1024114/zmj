//
//  FlightModel.h
//  GetHotels
//
//  Created by admin on 2017/11/23.
//  Copyright © 2017年 EDucation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightModel : NSObject

@property (nonatomic) NSInteger airID;//航空id
@property(strong,nonatomic)NSString *lowPrice;//最低价格
@property(strong,nonatomic)NSString *highPrice;//最高价格
@property(strong,nonatomic)NSString *lowTime;//最早时间
@property(strong,nonatomic)NSString *highTime;//最晚时间
@property(strong,nonatomic)NSString *detail;//详情
@property(strong,nonatomic)NSString *title;//标题
@property(strong,nonatomic)NSString *start;//出发地
@property(strong,nonatomic)NSString *end;//目的地


@end
