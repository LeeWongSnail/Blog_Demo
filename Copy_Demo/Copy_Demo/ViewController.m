//
//  ViewController.m
//  Copy_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//strong 或者copy实际使用都没什么影响
@property (nonatomic, copy) void (^(editBlock))(NSString *str);

//这种修饰在做修改操作的时候会发生崩溃
@property (nonatomic, copy) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *arrM1;
@end

@implementation ViewController

//copy 测试
- (void)testCopy
{
    self.arrM = [NSMutableArray array];
    [self.arrM addObject:@"1"];
    
    self.arrM1 = [NSMutableArray array];
    [self.arrM1 addObject:@"2"];
}

//非集合类的copy
//对于immutable类型的对象copy copy操作为浅拷贝 mutablecopy为深拷贝
- (void)immutableNotSetCopy
{
    NSString *str = @"123";
    NSLog(@"%p",str);
    NSString *str1 = [str copy];
    NSLog(@"%p",str1);
    NSString *str2 = [str mutableCopy];
    NSLog(@"%p",str2);
}

//对于mutable的对象的copy和mutablecopy均为深拷贝
- (void)mutableNotSetCopy {
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"123"];
    NSLog(@"%p",str);
    
    NSString *copyStr = [str copy];
    NSLog(@"%p",copyStr);
    
    NSString *strM = [str mutableCopy];
    NSLog(@"%p",strM);
}


// 对于集合对象

//对于不可变对象
- (void)immutableSetCopy
{
    NSArray *elem1  = @[@"1",@"2"];
    NSArray *elem2  = @[@"3",@"4"];
    NSArray *elem3  = @[@"5",@"6"];

    
    NSArray *arr = @[elem1,elem2,elem3];
    NSLog(@"%p",arr);
    NSLog(@"---------------------------------------------");

    NSArray *arr1 = [arr copy];
    NSLog(@"%p",arr1);
    NSLog(@"---------------------------------------------");
    for (NSArray *elem in arr1) {
        NSLog(@"%p",elem);
    }
    NSLog(@"---------------------------------------------");

    NSArray *arr2 = [arr mutableCopy];
    NSLog(@"%p",arr2);
    NSLog(@"---------------------------------------------");
    for (NSArray *elem in arr2) {
        NSLog(@"%p",elem);
    }
}

//对于可变对象
- (void)mutableSetCopy
{
    NSArray *elem1  = @[@"1",@"2"];
    NSArray *elem2  = @[@"3",@"4"];
    NSArray *elem3  = @[@"5",@"6"];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[elem1,elem2,elem3]];
    NSLog(@"%p",arr);
    NSLog(@"---------------------------------------------");
    
    NSArray *arr1 = [arr copy];
    NSLog(@"%p",arr1);
    NSLog(@"---------------------------------------------");
    for (NSArray *elem in arr1) {
        NSLog(@"%p",elem);
    }
    NSLog(@"---------------------------------------------");
    
    NSArray *arr2 = [arr mutableCopy];
    NSLog(@"%p",arr2);
    NSLog(@"---------------------------------------------");
    for (NSArray *elem in arr2) {
        NSLog(@"%p",elem);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self mutableSetCopy];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
