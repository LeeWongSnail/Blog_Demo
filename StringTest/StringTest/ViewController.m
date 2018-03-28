//
//  ViewController.m
//  StringTest
//
//  Created by LeeWong on 2018/3/26.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)blockTest
{
    __block NSInteger a = 1;
    
    void (^myBlock)() = ^(){
        NSInteger b = 3;
        NSLog(@"%tu",(a+b));
    };
    
    a = 2;
    myBlock();
    
}

- (void)MutableStringTest
{
    // 1
    NSMutableString *str = [[NSMutableString alloc] init];
    NSMutableString *str2 = [[NSMutableString alloc] init];
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]);//1,1
    
    str2 = [str copy];         //copy返回一个不可变对象属于常量
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]);//1,-1
}


- (void)StringTest {
    // 2
    NSString *str = [[NSString alloc] init];
    NSString *str2 = [[NSString alloc] init];
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]); //-1,-1
    
    str2 = [str copy];
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]);//-1,-1
}

- (void)mutableCopyTest
{
    // 3
    NSString *str = [[NSString alloc] initWithFormat:@"abc%@", @"hehe"];
    NSString *str2 = [[NSString alloc] initWithFormat:@"bbc%@", @"hehe"];
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]); //-1,-1
    
    str2 = [str mutableCopy];
    NSLog(@"%ld, %ld", [str retainCount], [str2 retainCount]);//-1,1
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self MutableStringTest];
//    [self StringTest];
//    [self mutableCopyTest];
    [self blockTest];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
