//
//  SJSQL.m
//  SJDBMapProject
//
//  Created by BlueDancer on 2018/7/4.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "SJSQL.h"

NSArray<NSString *> *properties(int count, ...) {
    if ( count == 0 ) return nil;
    va_list args;
    va_start(args, count);
    NSMutableArray<NSString *> *argsM = [NSMutableArray array];
    for ( int i = 0 ; i < count ; ++i ) {
        const char *arg = va_arg(args, char *);
        if ( 0 != strcmp("NA", arg) ) {
            [argsM addObject:[NSString stringWithUTF8String:arg]];
        }
    }
    va_end(args);
    return argsM;
}

@implementation NSObject (SJAdd)
- (void)setNA:(char *)NA {
    
}
- (char *)NA {
    return NULL;
}
@end

#pragma mark -


SJSELECT *SELECT(NSArray<NSString *> *args) {
    NSLog(@"SELECT %@", args);
    return [SJSELECT new];
}


@implementation SJSELECT
- (SJFROM *(^)(const char *))FROM {
    return ^(const char *table) {
        NSLog(@"FROM %s", table);
        return SJFROM.new;
    };
}
@end


@implementation SJFROM
- (SJWHERE *(^)(const char *condition))WHERE {
    return ^(const char *condition) {
        NSLog(@"WHERE %s", condition);
        return SJWHERE.new;
    };
}
@end


@implementation SJWHERE
- (SJORDER *(^)(void))ORDERBY {
    return ^{
        return SJORDER.new;
    };
}
@end


@implementation SJORDER

@end
