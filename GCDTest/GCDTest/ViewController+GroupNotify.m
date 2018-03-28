//
//  ViewController+GroupNotify.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+GroupNotify.h"

@implementation ViewController (GroupNotify)

// 全局队列 在sleep中的任务可能在 1 2 3都执行完成之后才被加入队列 这时候notify不会等待
- (void)asyncGroup
{
    NSLog(@"---");
    // 1. 调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 2. 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    // 3. 将任务添加到队列和调度组
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务 1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 3 %@", [NSThread currentThread]);
    });
    
    // 4. 监听所有任务完成
    dispatch_group_notify(group, q, ^{
        NSLog(@"OVER %@", [NSThread currentThread]);
    });
    
//    sleep(5);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 4 %@", [NSThread currentThread]);
    });
    // 5. 判断异步
    NSLog(@"come here");
}

// 所有的任务会以此执行 最后调用notify方法
- (void)mainGroup
{
    NSLog(@"---");
    // 1. 调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 2. 队列
    dispatch_queue_t q = dispatch_get_main_queue();
    
    // 3. 将任务添加到队列和调度组
    dispatch_group_async(group, q, ^{
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"任务 1 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 2 %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 3 %@", [NSThread currentThread]);
    });
    
    // 4. 监听所有任务完成
    dispatch_group_notify(group, q, ^{
        NSLog(@"OVER %@", [NSThread currentThread]);
    });
    
    sleep(5);
    dispatch_group_async(group, q, ^{
        NSLog(@"任务 4 %@", [NSThread currentThread]);
    });
    // 5. 判断异步
    NSLog(@"come here");
}

- (void)dispatchGroupWaitDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    //在group中添加队列的block
    dispatch_group_async(group, concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*USEC_PER_SEC);
    dispatch_group_wait(group, time);
    NSLog(@"go on");
}

//dispatch_group_notify
- (void)dispatchGroupNotifyDemo {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        sleep(2);
        NSLog(@"1");
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    NSLog(@"can continue");
    
}
@end
