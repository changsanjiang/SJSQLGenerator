//
//  SJSQL.m
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/12.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "SJSQL.h"

NS_ASSUME_NONNULL_BEGIN
/**
 目的很简单如下:
 函数调用:    SELECT("*").FROM("Products").WHERE("prod_price = 3.14").to_s;
 生成的语句: "SELECT * FROM Products WHERE prod_price = 3.14;"
 
 
 // 返回(价格 + 供应商)不重复的数据
 SJ_SELECT("DISTINCT prod_price, vend_id").FROM("Products").WHERE("prod_price >= 4").to_s
 
 // 这些修饰, 怎么完美的添加上去呢?
 
 SELECT DISTINCT prod_price FROM Products;
 
 SELECT prod_price FROM Products WHERE vend_id = 'BRS01' ORDER BY prod_price DESC;
 
 // 是否妥协?
 // 待续
 // 前缀函数解决
 SJ_SELECT(DISTINCT("prod_price, vend_id")).FROM("Products").WHERE("prod_price >= 4").to_s
 
 // 后缀函数呢? DESC? ASC?
 // ........
 
 */

@class SJSQLFrom, SJSQLWhere;

#pragma mark - SELECT
@interface SJSQLSelect: NSObject<SJSQLToString>
@end

@implementation SJSQLSelect {
    NSMutableString *_sqlStrM;
}
- (instancetype)initWithSub:(char *)sub {
    self = [super init];
    if ( !self ) return nil;
    _sqlStrM = [[NSMutableString alloc] initWithFormat:@"SELECT %s", sub];
    return self;
}
- (NSString *)to_s {
    if ( [_sqlStrM hasSuffix:@";"] ) return _sqlStrM;
    return [_sqlStrM stringByAppendingString:@";"];
}
@end

extern id<SJSQLFrom> SJ_SELECT(char *sub) {
    return (id)[[SJSQLSelect alloc] initWithSub:sub];
}

#pragma mark - From
@interface SJSQLSelect(From)<SJSQLFrom>
@end

@implementation SJSQLSelect(From)
- (id<SJSQLWhere> (^)(char *))FROM {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@" FROM %s", sub];
        return (id)self;
    };
}
@end

#pragma mark - Where
@interface SJSQLSelect(Where)<SJSQLWhere>
@end

@implementation SJSQLSelect(Where)
- (id<SJSQLOrderBy, SJSQLToString> (^)(char *))WHERE {
    return ^ (char *sub){
        [self->_sqlStrM appendFormat:@" WHERE %s", sub];
        return (id)self;
    };
}
@end

#pragma mark - Order_By
/// 在指定一条 ORDER BY 子句时, 应该保证它是 SELECT 语句中最后一条子句. 如果它不是最后的子句, 将会出现错误消息.
@interface SJSQLSelect(Order_By)<SJSQLOrderBy>
@end

@implementation SJSQLSelect(Order_By)
- (id<SJSQLToString> (^)(char * _Nonnull))ORDER_BY {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@" ORDER BY %s", sub];
        return (id)self;
    };
}
@end

#pragma mark - Limit
@interface SJSQLSelect(Limit)<SJSQLLimit>
@end

@implementation SJSQLSelect(Limit)
- (id<SJSQLToString> (^)(unsigned long begin, unsigned long offset))LIMIT {
    return ^ (unsigned long begin, unsigned long offset) {
        [self->_sqlStrM appendFormat:@" LIMIT %lu, %lu", begin, offset];
        return self;
    };
}
@end

NS_ASSUME_NONNULL_END
