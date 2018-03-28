    //
//  ViewController+Lock.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+Lock.h"

@implementation ViewController (Lock)
- (void)deadLockCase1 {
    NSLog(@"1");
    //主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
- (void)deadLockCase2 {
    NSLog(@"1");
    //3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.starming.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}
- (void)deadLockCase4 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        //将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}
- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //回到主线程发现死循环后面就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        NSLog(@"3");
    });
    NSLog(@"4");
    //死循环
    while (1) {
        //
    }
}
@end
