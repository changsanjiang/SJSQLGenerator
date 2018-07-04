//
//  Product.m
//  SQLDemo
//
//  Created by 畅三江 on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (instancetype)prodWithName:(NSString *)prod_name
                       price:(double)prod_price
                        desc:(NSString *)prod_desc {
    static NSInteger prod_id;
    Product * prod = Product.new;
    prod.prod_id = ++ prod_id;
    prod.prod_name = prod_name;
    prod.prod_price = prod_price;
    prod.prod_desc = prod_desc;
    return prod;
}
@end
