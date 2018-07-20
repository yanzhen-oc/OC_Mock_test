//
//  Person.h
//  test
//
//  Created by yanzhen on 2018/4/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
- (long)testForHello;
//can't int
//- (NSString *)setHeight:(int)height unit:(NSString *)unit;
- (NSString *)setHeight:(NSString *)height unit:(NSString *)unit;

- (void)say:(NSString *)thing;
- (void)waitSomeoneEating:(NSString *)time go:(void (^) (NSString *name))callback;
@end
