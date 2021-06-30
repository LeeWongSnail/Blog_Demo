//
//  ViewController.m
//  AutoReleasePoolDemo
//
//  Created by LeeWong on 2021/6/7.
//

#import "ViewController.h"
__weak NSString *string_weak_ = nil;
__weak NSString *string_weak1_ = nil;

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // 场景 1
//    NSString *string = [NSString stringWithFormat:@"leichunfeng"];
//    string_weak_ = string;
//    NSString *string2 = [[NSString alloc] initWithFormat:@"%@",@"leichunfeng"];
//    string_weak1_ = string2;

    // 场景 2
//    @autoreleasepool {
//        NSString *string = [NSString stringWithFormat:@"leichunfeng"];
//        string_weak_ = string;
//        NSString *string2 = [[NSString alloc] initWithFormat:@"%@",@"leichunfeng"];
//        string_weak1_ = string2;
//    }

    // 场景 3
    NSString *string = nil;
    NSString *string2 = nil;
    @autoreleasepool {
        string = [NSString stringWithFormat:@"leichunfeng"];
        string_weak_ = string;
        string2 = [[NSString alloc] initWithFormat:@"%@",@"leichunfeng1"];
        string_weak1_ = string2;
    }

    NSLog(@"string: %@  string1 = %@", string_weak_,string_weak1_);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string: %@  string1 = %@", string_weak_,string_weak1_);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"string: %@  string1 = %@", string_weak_,string_weak1_);
}




@end
