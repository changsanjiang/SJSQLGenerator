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
extern id<SJSQLFrom> SJ_SELECT(char *sub);



#pragma mark -
@protocol SJSQLToString
@property (nonatomic, copy, readonly) NSString *to_s;
@end

@protocol SJSQLFrom
@property (nonatomic, copy, readonly) id<SJSQLWhere, SJSQLOrderBy, SJSQLLimit> (^FROM)(char *sub);
@end

@protocol SJSQLWhere<SJSQLToString, SJSQLLimit>
@property (nonatomic, copy, readonly) id<SJSQLOrderBy> (^WHERE)(char *sub);
@end

@protocol SJSQLOrderBy<SJSQLToString>
/// 如果它不是最后的子句, 将会出现错误消息
///
/// DESC: Z -> A
///
/// ASC:  A -> Z
@property (nonatomic, copy, readonly) id<SJSQLLimit, SJSQLToString> (^ORDER_BY)(char *sub);
@end

struct SJLimit {
    unsigned long begin;
    unsigned long offset;
};

typedef struct SJLimit SJLimit;

extern SJLimit SJMakeLimit(unsigned long begin, unsigned long offset);

@protocol SJSQLLimit
@property (nonatomic, copy, readonly) id<SJSQLToString>(^LIMIT)(SJLimit limit);
@end

NS_ASSUME_NONNULL_END
