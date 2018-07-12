//
//  SJSQL.h
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/12.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SJSQLFrom, SJSQLWhere, SJSQLOrderBy, SJSQLToString, SJSQLLimit;

NS_ASSUME_NONNULL_BEGIN

/// generate sql string
///
/// SJ_SELECT("*").FROM("Products").WHERE("prod_price = 3.14").to_s;
///
/// SJ_SELECT("DISTINCT prod_price, vend_id").FROM("Products").WHERE("prod_price >= 4").to_s;
///
/// SJ_SELECT("*").FROM("Products").WHERE("prod_price > 3").ORDER_BY("prod_price DESC").LIMIT(2, 5).to_s;
///
extern id<SJSQLFrom> SJ_SELECT(char *sub);



#pragma mark -
@protocol SJSQLToString
@property (nonatomic, copy, readonly) NSString *to_s;
@end

@protocol SJSQLFrom
@property (nonatomic, copy, readonly) id<SJSQLWhere, SJSQLOrderBy, SJSQLLimit> (^FROM)(char *sub);
@end

@protocol SJSQLWhere<SJSQLToString, SJSQLLimit>
///
/// WHERE("prod_price >= 3")                                                --  >=, <=, >, <, =
///
/// WHERE("prod_des IS NULL")                                               --  IS NULL
/// WHERE("prod_des ISNULL")                                                --  ISNULL 相当于 IS NULL
///
/// WHERE("vend_id IN('DLL01', 'BRS01')")                                   --  IN, 此操作符一般比一组OR操作符执行的更快
///
/// WHERE("vend_id NOT 'DLL01'")                                            --  NOT
/// WHERE("vend_id NOT IN('DLL01', 'BRS01')")                               --  NOT
/// WHERE("NOT vend_id IN('DLL01', 'BRS01')")                               --  NOT
///
/// WHERE("prod_price BETWEEN 3 AND 8")                                     --  BETWEEN
///
/// WHERE("prod_price >= 3 AND prod_price <= 10")                           --  AND
///
/// WHERE("vend_id = 'BRS01' OR vend_id = 'DLL01'")                         --  OR
///
/// WHERE("vend_id = 'BRS01' OR vend_id = 'DLL01' AND prod_price >= 3")     --  优先级: AND 优先级更高, 此条子句优先处理 AND 子句
///
/// WHERE("(vend_id = 'BRS01' OR vend_id = 'DLL01') AND prod_price >= 3")   --  优先级: ()  优先级更改, 此条子句优先处理 () 中的子句
///
@property (nonatomic, copy, readonly) id<SJSQLOrderBy> (^WHERE)(char *sub);
@end

@protocol SJSQLOrderBy<SJSQLToString>
///
/// 如果它不是最后的子句, 将会出现错误消息
///
/// ORDER_BY("prod_price DESC, prod_id ASC")                                --  DESC: Z -> A, ASC:  A -> Z
///
@property (nonatomic, copy, readonly) id<SJSQLLimit, SJSQLToString> (^ORDER_BY)(char *sub);
@end

@protocol SJSQLLimit
///
/// LIMIT(0, 5)                                                             -- 返回从第0行开始的5行数据, 也就是 0, 1, 2, 3, 4
///
@property (nonatomic, copy, readonly) id<SJSQLToString>(^LIMIT)(unsigned long begin, unsigned long offset);
@end

NS_ASSUME_NONNULL_END
