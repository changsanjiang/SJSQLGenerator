//
//  SJSQLSelect.h
//  SJSQLGenerator
//
//  Created by BlueDancer on 2018/7/13.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SJSQLSelect, SJSQLFrom, SJSQLWhere, SJSQLGroupBy, SJSQLHaving, SJSQLOrderBy, SJSQLToString, SJSQLLimit;

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
/// A null-terminated UTF8 representation of the string.
/// This C string is a pointer to a structure inside the string object, which may have a lifetime shorter than the string object and will certainly not have a longer lifetime. Therefore, you should copy the C string if it needs to be stored outside of the memory context in which you use this property.
@property (nonatomic, readonly) const char *to_s_c;
@end

@protocol SJSQLSelect
///
///
/// SELECT("prod_name, prod_price")                                         --  表列查询
///
///                                                                         --  计算字段: https://www.jianshu.com/p/768b033113c4
/// SELECT("vend_name || '(' || vend_country || ')' AS vend_title")         --  `||` 拼接. AS + 计算字段. `Bears R US(USA)` == `name + (country)` == title
/// SELECT("item_price * item_num AS expended_price")                       --  `+ - * /`. 此外可以使用`()`调整优先级
///
///                                                                         --  使用函数: https://www.jianshu.com/p/2e7d1423946d
///                                                                         --  使用函数: https://www.jianshu.com/p/2a4089feb564
/// SELECT("vend_name, UPPER(vend_name) AS vend_name_upcase")               --  `UPPER()`文本转大写
/// SELECT("vend_name, LOWER(vend_name) AS vend_name_downcase")             --  `LOWER()`文本转小写
/// SELECT("AVG(prod_price) AS avg_price")                                  --  `AVG()`返回平均值
/// SELECT("MAX(prod_price) AS max_price, MIN(prod_price) AS min_price")    --  `MAX(), MIN()`函数
///                                                                         --  .... 还有好多函数
///
@property (nonatomic, copy, readonly) id<SJSQLFrom> (^SELECT)(char *sub);
@end

@protocol SJSQLFrom<SJSQLToString>
@property (nonatomic, copy, readonly) id<SJSQLWhere, SJSQLOrderBy, SJSQLLimit> (^FROM)(char *sub);
@end

@protocol SJSQLWhere<SJSQLToString, SJSQLLimit>
///
/// WHERE("prod_price >= 3")                                                --  >=, <=, >, <, =
/// WHERE("prod_price >= 3, vend_id = 'BRS01'")                             --  ...
///
///                                                                         --  搜索模式
/// WHERE("prod_name LIKE 'Fish%%'")                                        --  `Fish%`. 其中谓词: LIKE. `%`告诉DBMS匹配`Fish`0个以上字符. 相当于正则中的`*`
/// WHERE("prod_name LIKE '%%bean bag%%'")                                  --  `%bean bga%`. 通配符可以在搜索模式中使用多次
/// WHERE("prod_name LIKE 'F%%y'")                                          --  `F%y`
/// WHERE("prod_name LIKE '_8 inch teddy bear'")                            --  `_8 inch teddy bear`. 其中`_`匹配单个字符. 相当于正则中的`.`
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
@property (nonatomic, copy, readonly) id<SJSQLOrderBy, SJSQLGroupBy> (^WHERE)(char *sub);
@end

@protocol SJSQLGroupBy<SJSQLToString>
@property (nonatomic, copy, readonly) id<SJSQLHaving> (^GROUP_BY)(char *sub);
@end

@protocol SJSQLHaving<SJSQLToString>
@property (nonatomic, copy, readonly) id<SJSQLOrderBy> (^HAVING)(char *sub);
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
