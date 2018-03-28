//
//  ViewController+setPriority.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+setPriority.h"

@implementation ViewController (setPriority)

//dispatch_set_target_queue(dispatch_object_t object, dispatch_queue_t queue);
//dispatch_set_target_queue 函数有两个作用：第一，变更队列的执行优先级；第二，目标队列可以成为原队列的执行阶层。
//第一个参数是要执行变更的队列（不能指定主队列和全局队列）
//第二个参数是目标队列（指定全局队列）

- (void)configPriority
{
    //优先级变更的串行队列，初始是默认优先级 NULL 默认是串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.gcd.setTargetQueue.serialQueue", NULL);
    
    //优先级不变的串行队列（参照），初始是默认优先级
    dispatch_queue_t serialDefaultQueue = dispatch_queue_create("com.gcd.setTargetQueue.serialDefaultQueue", NULL);
    
    //变更前
    dispatch_async(serialQueue, ^{
        NSLog(@"1");
    });
    dispatch_async(serialDefaultQueue, ^{
        NSLog(@"2");
    });
    
    //获取优先级为后台优先级的全局队列
    dispatch_queue_t globalDefaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //变更优先级
    dispatch_set_target_queue(serialQueue, globalDefaultQueue);
    
    //变更后 serialQueue 最低的优先级
    dispatch_async(serialQueue, ^{
        NSLog(@"1");
    });
    dispatch_async(serialDefaultQueue, ^{
        NSLog(@"2");
    });
}

//三、设置执行阶层
// 将并发执行的多个队列的异步任务 转换为同步执行的任务
- (void)ConfigExeLevel
{
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue1", NULL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue2", NULL);
    dispatch_queue_t serialQueue3 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue3", NULL);
    dispatch_queue_t serialQueue4 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue4", NULL);
    dispatch_queue_t serialQueue5 = dispatch_queue_create("com.gcd.setTargetQueue2.serialQueue5", NULL);
    
    
    dispatch_async(serialQueue1, ^{
        NSLog(@"1");
    });
    dispatch_async(serialQueue2, ^{
        NSLog(@"2");
    });
    dispatch_async(serialQueue3, ^{
        NSLog(@"3");
    });
    dispatch_async(serialQueue4, ^{
        NSLog(@"4");
    });
    dispatch_async(serialQueue5, ^{
        NSLog(@"5");
    });
    
    //保证上面的内容都执行完了
    sleep(2);
    
    NSLog(@"--------------------这是分割线---------------------");
    //创建目标串行队列
    dispatch_queue_t targetSerialQueue = dispatch_queue_create("com.gcd.setTargetQueue2.targetSerialQueue", NULL);
    //设置执行阶层
    dispatch_set_target_queue(serialQueue1, targetSerialQueue);
    dispatch_set_target_queue(serialQueue2, targetSerialQueue);
    dispatch_set_target_queue(serialQueue3, targetSerialQueue);
    dispatch_set_target_queue(serialQueue4, targetSerialQueue);
    dispatch_set_target_queue(serialQueue5, targetSerialQueue);
    
    dispatch_async(serialQueue1, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"1");
    });
    dispatch_async(serialQueue2, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"2");
    });
    dispatch_async(serialQueue3, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"3");
    });
    dispatch_async(serialQueue4, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"4");
    });
    dispatch_async(serialQueue5, ^{
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"5");
    });
}

@end
