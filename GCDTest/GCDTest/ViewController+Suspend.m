//
//  ViewController+Suspend.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+Suspend.h"

@implementation ViewController (Suspend)

- (void)dispatch_suspendTest
{
    dispatch_queue_t queue = dispatch_queue_create("me.tutuge.test.gcd", DISPATCH_QUEUE_SERIAL);
    //提交第一个block，延时5秒打印。
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"After 5 seconds...");
    });
    //提交第二个block，也是延时5秒打印
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"After 5 seconds again...");
    });
    //延时一秒
    NSLog(@"sleep 1 second...");
    [NSThread sleepForTimeInterval:1];
    //挂起队列
    NSLog(@"suspend...");
    dispatch_suspend(queue);
    //延时10秒
    NSLog(@"sleep 10 second...");
    [NSThread sleepForTimeInterval:10];
    //恢复队列
    NSLog(@"resume...");
    dispatch_resume(queue);
}


@end
