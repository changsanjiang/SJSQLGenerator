//
//  Order.h
//  SQLDemo
//
//  Created by BlueDancer on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
/// 订单号
@property (nonatomic) NSInteger order_num;
/// 订单日期
@property (nonatomic, strong) NSString *order_date;
/// 订单顾客ID
@property (nonatomic) NSInteger cust_id;
@end
