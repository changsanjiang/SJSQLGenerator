//
//  ViewController.m
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/4.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"
#import "SJSQL.h"

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

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic) sqlite3 *database;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<NSDictionary *> *data;
@property (nonatomic, strong) NSArray<NSString *> *keys;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTestData];
    

    NSString *
    sql = SJ_SELECT("*").FROM("Products").WHERE("prod_price >= 4").to_s;
    sql = SJ_SELECT("*").FROM("Products").ORDER_BY("prod_price DESC").to_s;
    sql = SJ_SELECT("*").FROM("Products").WHERE("prod_price > 3").ORDER_BY("prod_price DESC").LIMIT(0, 5).to_s;
    sql = SJ_SELECT("*").FROM("Products").LIMIT(1, 0).to_s;
    sql = SJ_SELECT("*").FROM("Products").WHERE("NOT vend_id IN('DLL01', 'BRS01')").to_s;
    
    sql = SJ_SELECT("Date()").to_s;
    sql= SJ_SELECT("TRIM('   sbc    ')").to_s;
    
    sql = SJ_SELECT("vend_name || '(' || vend_country || ')' AS vend_title").FROM("Vendors").to_s;
    
    sql = SJ_SELECT("LOWER(vend_name) AS Tse").FROM("Vendors").to_s;
    
    
    
    
    
    
    
    
    
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

