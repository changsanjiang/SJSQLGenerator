//
//  SJSQL.h
//  SJDBMapProject
//
//  Created by BlueDancer on 2018/7/4.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdarg.h>
@class SJSELECT, SJFROM, SJWHERE, SJCONDITION, SJORDER;

#pragma mark - Select - 选择属性, 生成`SELECT`语句

#define t(__TYPE__)                                    ((__TYPE__ *)0)
#define s(__TYPE__)                                    s1(__TYPE__, NA)
#define s1(__TYPE__, arg1)                             s2(__TYPE__, arg1, NA)
#define s2(__TYPE__, arg1, arg2)                       s3(__TYPE__, arg1, arg2, NA)
#define s3(__TYPE__, arg1, arg2, arg3)                 s4(__TYPE__, arg1, arg2, arg3, NA)
#define s4(__TYPE__, arg1, arg2, arg3, arg4)           s5(__TYPE__, arg1, arg2, arg3, arg4, NA)
#define s5(__TYPE__, arg1, arg2, arg3, arg4, arg5) ^{\
t(__TYPE__).arg1; \
t(__TYPE__).arg2, \
t(__TYPE__).arg3; \
t(__TYPE__).arg4; \
t(__TYPE__).arg5; \
return properties(5, #arg1, #arg2, #arg3, #arg4, #arg5);\
}() \


#pragma mark - Condition - 条件, 生成`WHERE`语句

#define c1(__TYPE__, arg1)                             c2(__TYPE__, arg1, NA)
#define c2(__TYPE__, arg1, arg2)                       c3(__TYPE__, arg1, arg2, NA)
#define c3(__TYPE__, arg1, arg2, arg3)                 c4(__TYPE__, arg1, arg2, arg3, NA)
#define c4(__TYPE__, arg1, arg2, arg3, arg4)           c5(__TYPE__, arg1, arg2, arg3, arg4, NA)
#define c5(__TYPE__, arg1, arg2, arg3, arg4, arg5) ^{\
(void)(t(__TYPE__).arg1); \
(void)(t(__TYPE__).arg2), \
(void)(t(__TYPE__).arg3); \
(void)(t(__TYPE__).arg4); \
(void)(t(__TYPE__).arg5); \
return "[SJCONDITION new]"; \
}() \


#pragma mark - 函数

extern SJSELECT *SELECT(NSArray<NSString *> *args);

@interface SJSELECT : NSObject
@property (nonatomic, copy, readonly) SJFROM *(^FROM)(const char *table);
@end

@interface SJFROM: NSObject
@property (nonatomic, copy, readonly) SJWHERE *(^WHERE)(const char *condition);
@end

@interface SJWHERE: NSObject
@property (nonatomic, copy, readonly) SJORDER *(^ORDERBY)(void);
@end

@interface SJORDER: NSObject
@end


#pragma mark -
extern NSArray<NSString *> *properties(int count, ...);
@interface NSObject (SJAdd)
@property (nonatomic) char *NA;
@end
