//
//  ViewController.m
//  test
//
//  Created by yanzhen on 2018/4/11.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

#import "ViewController.h"
#import <OCMock/OCMock.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //BBD测试工具Kiwi
    [self testBlock];
    
}

#pragma mark - block
- (void)testBlock
{
    id person = OCMClassMock([Person class]);
    OCMStub([person waitSomeoneEating:@"5" go:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        //2. declare a block with same signature
        void (^block)(NSString *names);
        //3. link argument 3 with with our block callback
        [invocation getArgument:&block atIndex:3];
        //4. invoke block with pre-defined input
        block(@"no no no!!!");
    });
    
    //注意5要和上面相同
    [person waitSomeoneEating:@"5" go:^(NSString *name) {
        NSLog(@"TTTT-----------name is :%@",name);
    }];
}

#pragma mark - 验证方法是否被调用
- (void)testForMethod
{
    //模拟一个Person对象
    id person = OCMClassMock([Person class]);
    //调用say,注意参数
    [person say:@"hello1"];
//    OCMVerify([person say:@"hello"]);
    //当被验证的方法没有被调用的时候会抛出异常
    OCMVerify([person say:[OCMArg any]]);
    
}

#pragma mark - Partial
- (void)testPartial
{
    //创建真实person对象
    Person *person = [[Person alloc] init];
    //对象绑定到虚拟的mock
    id aMock = OCMPartialMock(person);
    //调用stub会获得返回结果1123，不调用会返回真实调用结果
    //非绑定的（OCMPartialMock）直接调用跳过stub会导致崩溃
    OCMStub([aMock testForHello]).andReturn(1223);
    long test = [aMock testForHello];
    NSLog(@"TTTT-----------:%ld",test);
}

#pragma mark - 测试返回值
- (void)testForReturn1{
    //用于调试接口，返回某个返回值------处理场景
    
    
    //模拟一个Person对象
    id mock = OCMClassMock([Person class]);
    //给person调用testForHello返回值是1223
    OCMStub([mock testForHello]).andReturn(1223);
    long tt = [mock testForHello];
    NSLog(@"TTTT-----------:%ld",tt);
}

- (void)testForReturn2
{
    id jalopy = OCMStrictClassMock([Person class]);
    //[OCMArg any]表示任何参数，不能代表基本数据类型，
    //cm强制测试接口时候必须传cm否则崩溃
    //测试返回结果是100cm
    OCMStub([jalopy setHeight:[OCMArg any] unit:@"cm"]).andReturn(@"100cm");
    //第一个参数是固定的，第二个符合测试传cm，其它会导致崩溃
    NSString *test = [jalopy setHeight:@"175" unit:@"cm"];
    NSLog(@"TTTT-----------:%@",test);
}
@end
