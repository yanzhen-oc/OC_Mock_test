//
//  Person.m
//  test
//
//  Created by yanzhen on 2018/4/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import "Person.h"

@implementation Person
- (long)testForHello
{
    NSLog(@"TTTT-----------:rt");
    return 2;
        
}

-(NSString *)setHeight:(NSString *)height unit:(NSString *)unit
{
    return [NSString stringWithFormat:@"%@%@",height, unit];
}

-(void)say:(NSString *)thing
{
    NSLog(@"person say: something");
}

-(void)waitSomeoneEating:(NSString *)time go:(void (^)(NSString *))callback
{
    NSLog(@"TTTT-----------:%@",time);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time.integerValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !callback ?: callback(@"hello world");
    });
}
@end
