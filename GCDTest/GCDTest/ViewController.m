//
//  ViewController.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+setPriority.h"
#import "ViewController+Apply.h"
#import "ViewController+Barrier.h"
#import "ViewController+Semaphor.h"
#import "ViewController+GroupNotify.h"
#import "ViewController+CancelBlock.h"
#import "ViewController+Lock.h"
#import "ViewController+Suspend.h"

@interface ViewController ()

@end

@implementation ViewController


//串行队列 同步任务
- (void)serialSync
{
    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("gcd.test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"11111111");
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"222");
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"3333");
    });
    
}

//串行队列 异步
// 即使是异步任务 因为串行队列只有一个线程
- (void)serialAsync
{
    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("gcd.test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"11111111");
    });
    
    dispatch_async(serialQueue, ^{
        sleep(3);
        NSLog(@"222");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3333");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
}

// 并行队列 同步执行
// 同步执行 即使可以开多个线程 也是同步执行
- (void)concurrentSync
{
    dispatch_queue_t serialQueue = dispatch_queue_create("gcd.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"11111111");
    });
    
    dispatch_sync(serialQueue, ^{
        sleep(2);
        NSLog(@"222");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"3333");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    NSLog(@"%@",[NSThread currentThread]);
}

// 并行队列异步任务
- (void)concurrentAsync
{
    dispatch_queue_t serialQueue = dispatch_queue_create("gcd.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"11111111");
    });
    
    dispatch_async(serialQueue, ^{
        sleep(2);
        NSLog(@"222");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"3333");
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    NSLog(@"%@",[NSThread currentThread]);
}

/*
 针对上面的总结 同步和异步决定他开不可以开多个线程 但是 并发和串行决定可以开几条线程
 **/


//主队列
// 主队列同步任务会发生死锁
- (void)mainSync
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"111");
    });
    
    NSLog(@"----");
}

// 主队列 异步执行 可以正常执行
- (void)mainAsync
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"111");
    });
    
    NSLog(@"----");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self dispatch_suspendTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
