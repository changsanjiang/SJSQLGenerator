//
//  OrderItem.h
//  SQLDemo
//
//  Created by BlueDancer on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject
/// 订单号
@property (nonatomic) NSInteger order_num;
/// 订单物品号
@property (nonatomic) NSInteger order_item;
/// 产品ID
@property (nonatomic) NSInteger prod_id;
/// 物品数量
@property (nonatomic) NSInteger quantity;
/// 物品价格
@property (nonatomic) double item_price;
@end
