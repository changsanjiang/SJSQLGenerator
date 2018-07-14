//
//  Vendor.h
//  SQLDemo
//
//  Created by BlueDancer on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vendor : NSObject
/// 供应商ID
@property (nonatomic) long vend_id;
/// 供应商名
@property (nonatomic, strong) NSString *vend_name;
/// 供应商地址
@property (nonatomic, strong) NSString *vend_address;
/// 供应商所在城市
@property (nonatomic, strong) NSString *vend_city;
/// 供应商所在州
@property (nonatomic, strong) NSString *vend_state;
/// 供应商地址邮政编码
@property (nonatomic, strong) NSString *vend_zip;
/// 供应商所在国家
@property (nonatomic, strong) NSString *vend_country;
@end
