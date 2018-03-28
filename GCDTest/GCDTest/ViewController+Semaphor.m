//
//  ViewController+Semaphor.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+Semaphor.h"

@implementation ViewController (Semaphor)

//信号量
//dispatch_semaphore_create：创建一个信号量（semaphore）
//dispatch_semaphore_signal：信号通知，即让信号量+1
//dispatch_semaphore_wait：等待，直到信号量大于0时，即可操作，同时将信号量-1
- (void)semaphorTest {
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(2);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(3);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, 2);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
    
    NSLog(@"end");
}

@end
