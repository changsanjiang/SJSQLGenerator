//
//  ViewController.m
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/4.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "ViewController.h"
#import "SJSQL.h"
#import "Product.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /// 选出id等于10的商品
    SELECT(s(Product)).FROM("Product").WHERE(c1(Product, prod_id = 10));
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)testSelect {
    
    s(Product);
    s1(Product, prod_id);
    s2(Product, prod_id, prod_name);
    s3(Product, prod_id, prod_name, prod_price);
    s4(Product, prod_id, prod_name, prod_price, prod_desc);
    s5(Product, prod_id, prod_name, prod_price, prod_desc, vend_id);
    
}

- (void)testCondition {
    
    /// 等于
    /// 产品id等于10的商品
    c1(Product, prod_id = 10);
    
    /// AND
    /// 产品id小于20, 大于10的商品
    c2(Product, prod_id <= 20, prod_id >= 10);
    
    /// OR
    c2(Product, prod_name = @"bear", prod_name = @"hear");
    
    /// (OR) + AND
    
    
    /// IN
    
    
}

@end
