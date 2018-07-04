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
    
    
    SELECT(s(Product)).FROM("Products").WHERE(c1(Product, prod_id = 10)).ORDERBY();
    SELECT(s1(Product, prod_name)).FROM("Products").WHERE(c1(Product, prod_id = 10));
    SELECT(s2(Product, prod_name, prod_price)).FROM("Products").WHERE(c1(Product, prod_id = 10));
    SELECT(s3(Product, prod_name, prod_price, prod_desc)).FROM("Products").WHERE(c1(Product, prod_id = 10));
    SELECT(s4(Product, prod_name, prod_price, prod_desc, vend_id)).FROM("Products").WHERE(c1(Product, prod_id = 10));
    
    // Do any additional setup after loading the view, typically from a nib.
}


/// 测试SELECT
- (void)testSelect {
    s(Product);
    s1(Product, prod_id);
    s2(Product, prod_id, prod_name);
    s3(Product, prod_id, prod_name, prod_price);
    s4(Product, prod_id, prod_name, prod_price, prod_desc);
    s5(Product, prod_id, prod_name, prod_price, prod_desc, vend_id);
}

/// 测试查询条件
- (void)testCondition {
    
    /// 产品id等于10的产品
    /// 等于
    c1(Product, prod_id = 10);
    
    /// 产品id小于20, 大于10的产品
    /// AND
    c2(Product, prod_id <= 20, prod_id >= 10);

    /// 产品名称等于`apple`或者等于`banana`的产品
    /// OR
    c2(Product, prod_name = @"apple", prod_name = @"banana");
    
    /// 产品名称等于`apple`或者等于`banana`, 并且供应商的ID等于2008的产品
    /// (OR) + AND
    c3(Product, prod_name = @"apple", prod_name = @"banana", vend_id = 2008);
    
    /// 产品ID等于`10`, `11`, `12`, `13`的产品
    /// IN
    id ids = @[@(10), @(11), @(12), @(13)];
    c1(Product, prod_id = ids); // 报警告, 想办法处理一下
}

@end
