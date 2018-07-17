//
//  SJSQLSelect.m
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/13.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "SJSQLSelect.h"
#import <stdarg.h>

NS_ASSUME_NONNULL_BEGIN

#define SJSQL_CONFIG_MAXLOG (4096)

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
- (instancetype)init {
    self = [super init];
    if ( !self ) return nil;
    _sqlStrM = [NSMutableString string];
    return self;
}
- (NSString *)to_s {
    if ( [_sqlStrM hasSuffix:@";"] ) return _sqlStrM.copy;
    return [_sqlStrM stringByAppendingString:@";"];
}
- (const char *)to_s_c {
    return _sqlStrM.UTF8String;
}
@end

#pragma mark - Select
@interface SJSQLSelect(Select)<SJSQLSelect>
@end

@implementation SJSQLSelect(Select)
- (id (^)(char * _Nonnull))SELECT {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@"SELECT %s", sub];
        return self;
    };
}
@end

#pragma mark - From
@interface SJSQLSelect(From)<SJSQLFrom>
@end

@implementation SJSQLSelect(From)
- (id (^)(char *))FROM {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@" FROM %s", sub];
        return self;
    };
}
@end

#pragma mark - Where
@interface SJSQLSelect(Where)<SJSQLWhere>
@end

@implementation SJSQLSelect(Where)
- (id (^)(char *, ...))WHERE {
    return ^ (char *format, ...){
        char buf[SJSQL_CONFIG_MAXLOG];
        va_list ap;
        va_start(ap, format);
        vsnprintf(buf, sizeof(buf), format, ap);
        va_end(ap);
        [self->_sqlStrM appendFormat:@" WHERE %s", buf];
        return self;
    };
}
@end

#pragma mark - Group_By
@interface SJSQLSelect(Group_By)<SJSQLGroupBy>
@end

@implementation SJSQLSelect(Group_By)
- (id (^)(char * _Nonnull))GROUP_BY {
    return ^ (char *sub){
        [self->_sqlStrM appendFormat:@" GROUP BY %s", sub];
        return self;
    };
}
@end


#pragma mark - Having
@interface SJSQLSelect(Having)<SJSQLHaving>
@end

@implementation SJSQLSelect(Having)
- (id (^)(char * _Nonnull))HAVING {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@" HAVING %s", sub];
        return self;
    };
}
@end

#pragma mark - Order_By
/// 在指定一条 ORDER BY 子句时, 应该保证它是 SELECT 语句中最后一条子句. 如果它不是最后的子句, 将会出现错误消息.
@interface SJSQLSelect(Order_By)<SJSQLOrderBy>
@end

@implementation SJSQLSelect(Order_By)
- (id (^)(char * _Nonnull))ORDER_BY {
    return ^ (char *sub) {
        [self->_sqlStrM appendFormat:@" ORDER BY %s", sub];
        return self;
    };
}
@end

#pragma mark - Limit
@interface SJSQLSelect(Limit)<SJSQLLimit>
@end

@implementation SJSQLSelect(Limit)
- (id(^)(unsigned long begin, unsigned long offset))LIMIT {
    return ^ (unsigned long begin, unsigned long offset) {
        [self->_sqlStrM appendFormat:@" LIMIT %lu, %lu", begin, offset];
        return self;
    };
}
@end


extern id<SJSQLFrom> SJ_SELECT(char *sub) {
    return SJSQLSelect.new.SELECT(sub);
}
NS_ASSUME_NONNULL_END
