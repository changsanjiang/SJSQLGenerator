//
//  SJViewController.m
//  SJSQLGenerator
//
//  Created by changsanjiang@gmail.com on 07/14/2018.
//  Copyright (c) 2018 changsanjiang@gmail.com. All rights reserved.
//

#import "SJViewController.h"
#import "Product.h"
#import "SJSQL.h"
#import <stdarg.h>

/**
 最近在复习SQL, 我会在这个库记录SQL相关的子句, 以防后期遗忘
 
 目的很简单如下:
 函数调用:    SELECT("*").FROM("Products").WHERE("prod_price = 3.14").to_s;
 生成的语句: "SELECT * FROM Products WHERE prod_price = 3.14;"
 
 */

#import <sqlite3.h>
#import <SJDBMap/SJDatabaseFunctions.h>
#import "Vendor.h"
#import "CollectionViewCell.h"

static NSString *CollectionViewCellID = @"CollectionViewCell";

@interface SJViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) sqlite3 *database;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary *> *data;
@property (nonatomic, strong) NSArray<NSString *> *keys;
@end

@implementation SJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTestData];
    
    NSString *
    sql =
    SJ_SELECT("*").
    FROM("Products").
    WHERE("prod_price >= 4").to_s;
    
    sql =
    SJ_SELECT("*").
    FROM("Products").
    ORDER_BY("prod_price DESC").to_s;
    
    sql =
    SJ_SELECT("*").
    FROM("Products").
    WHERE("prod_price > 3").
    ORDER_BY("prod_price DESC").LIMIT(0, 5).to_s;
    
    sql =
    SJ_SELECT("*").
    FROM("Products").
    LIMIT(1, 0).to_s;
    
    sql =
    SJ_SELECT("*").
    FROM("Products").
    WHERE("NOT vend_id IN('DLL01', 'BRS01')").to_s;
    
    sql =
    SJ_SELECT("Date()").to_s;
    
    sql =
    SJ_SELECT("TRIM('   sbc    ')").to_s;
    
    sql =
    SJ_SELECT("vend_name || '(' || vend_country || ')' AS vend_title").
    FROM("Vendors").to_s;
    
    sql =
    SJ_SELECT("LOWER(vend_name) AS Tse").
    FROM("Vendors").to_s;
    
    sql =
    SJ_SELECT("*").
    FROM("Prodcuts").to_s;
    
    sql =
    SJ_SELECT("COUNT(*) AS items, order_num")
    .FROM("OrderItems")
    .GROUP_BY("Order_num")
    .LIMIT(2, 2).to_s;
    
    
    sql =
    SJ_SELECT("COUNT(*) AS items, order_num")
    .FROM("OrderItems")
    .WHERE("item_price > 4")
    .GROUP_BY("order_num")
    .HAVING("items >= 2")
    .ORDER_BY("order_num, items")
    .LIMIT(2, 2).to_s;
    
    sql =
    SJ_SELECT("cust_name, cust_email")
    .FROM("Customers")
    .WHERE("cust_id IN (%s)",
                        SJ_SELECT("cust_id")
                        .FROM("Orders")
                        .WHERE("order_num IN (%s)",
                                             SJ_SELECT("order_num")
                                             .FROM("OrderItems")
                                             .WHERE("prod_id = 'RGAN01'").to_s_c).to_s_c).to_s;
    
    
    
    sql =
    SJ_SELECT("cust_name, cust_email")
    .FROM("Customers")
    .INNER_JOIN("Orders, OrderItems")
    .ON("prod_id = 'RGAN01' AND OrderItems.order_num = Orders.order_num AND Customers.cust_id = Orders.cust_id").to_s;
    
    
    sql =
    SJ_SELECT("vend_city, vend_name, prod_name, prod_price")
    .FROM("Vendors")
    .INNER_JOIN("Products")
    .ON("Vendors.vend_id = Products.vend_id").to_s;
    
    
    sql =
    SJ_SELECT("Customers.cust_id, Orders.order_num")
    .FROM("Customers")
    .LEFT_OUTER_JOIN("Orders")
    .ON("Customers.cust_id = Orders.cust_id").to_s;
    
    
    sql =
    SJ_SELECT("Customers.cust_id, COUNT(Orders.order_num) AS num_ord")
    .FROM("Customers")
    .LEFT_OUTER_JOIN("Orders")
    .ON("Customers.cust_id = Orders.cust_id")
    .GROUP_BY("Customers.cust_id").to_s;
    
    
    sql =
    SJ_SELECT("Vendors.vend_name, Products.prod_name, Products.prod_price")
    .FROM("Vendors")
    .INNER_JOIN("Products")
    .ON("Vendors.vend_id = Products.vend_id").to_s;
    
    
    sql =
    SJ_SELECT("cust_name, cust_contact, cust_email")
    .FROM("Customers")
    .WHERE("cust_state IN ('IL', 'IN', 'MI')")
    .UNION()
    .SELECT("cust_name, cust_contact, cust_email")
    .FROM("Customers")
    .WHERE("cust_name = 'Fun4All'")
    .ORDER_BY("cust_name, cust_contact").to_s;
    
    _data = sj_sql_query(self.database, sql.UTF8String, nil);
    _keys = _data.firstObject.allKeys;
    [self.view addSubview:self.collectionView];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareTestData {
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"tysql" ofType:@"sqlite"];
    sj_database_open(dbPath.UTF8String, &_database);
}

- (UICollectionView *)collectionView {
    if ( _collectionView ) return _collectionView;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:NSClassFromString(CollectionViewCellID) forCellWithReuseIdentifier:CollectionViewCellID];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ( section == 0 ) return _keys.count;
    return _data.count * _keys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    if ( indexPath.section == 0 ) cell.text = _keys[indexPath.item];
    else cell.text = _data[indexPath.item / _keys.count % _data.count][_keys[indexPath.item % _keys.count]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width / _keys.count, 44);
}
@end
