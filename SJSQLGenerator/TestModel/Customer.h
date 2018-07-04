//
//  Customer.h
//  SQLDemo
//
//  Created by BlueDancer on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject
/// 顾客ID
@property (nonatomic) NSInteger cust_id;
/// 顾客名
@property (nonatomic, strong) NSString *cust_name;
/// 顾客的地址
@property (nonatomic, strong) NSString *cust_address;
/// 顾客所在城市
@property (nonatomic, strong) NSString *cust_city;
/// 顾客所在州
@property (nonatomic, strong) NSString *cust_state;
/// 顾客地址邮政编码
@property (nonatomic, strong) NSString *cust_zip;
/// 顾客所在国家
@property (nonatomic, strong) NSString *cust_country;
/// 顾客的联系名
@property (nonatomic, strong) NSString *cust_contact;
/// 顾客的电子邮件地址
@property (nonatomic, strong) NSString *cust_email;
@end
