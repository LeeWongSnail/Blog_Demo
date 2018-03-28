//
//  ViewController+Barrier.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+Barrier.h"

@implementation ViewController (Barrier)

/*
 dispatch_barrier_async 将阻塞当前队列中的任务 只有在dispatch_barrier_async之前进入的任务执行完毕之后才会去执行
 这个队列中后面的代码
 注意 不会影响非这个队列中的代码 NLog的任务不会受影响
 **/
- (void)asyncBarrierTest
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    NSLog(@"-----");
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
}

//并行队列 同步任务
- (void)syncBarrierTest
{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
    NSLog(@"-----");
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-3");
    });
    dispatch_sync(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
}

/*
 上面两个syncBarrierTest asyncBarrierTest 并行队列上同步或者异步只是决定在队列中 两个任务的执行顺序 不影响整体执行顺序
 同步和异步的执行结果都是 先 12 后 34 区别是 同步的时候 顺序肯定是 1 2 3 4 异步可能是 2 1 4 3
 **/
@end
