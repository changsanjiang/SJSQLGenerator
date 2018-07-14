//
//  Product.h
//  SQLDemo
//
//  Created by 畅三江 on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

+ (instancetype)prodWithName:(NSString *)prod_name
                       price:(double)prod_price
                        desc:(NSString *)prod_desc;

/// 产品ID
@property (nonatomic) NSInteger prod_id;
/// 产品供应商ID
@property (nonatomic) NSInteger vend_id;
/// 产品名
@property (nonatomic, strong) NSString *prod_name;
/// 产品价格
@property (nonatomic) double prod_price;
/// 产品描述
@property (nonatomic, strong) NSString *prod_desc;
@end
