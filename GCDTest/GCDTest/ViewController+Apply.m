//
//  ViewController+Apply.m
//  GCDTest
//
//  Created by LeeWong on 2018/3/27.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController+Apply.h"

@implementation ViewController (Apply)

- (void)applyTest
{
    for (size_t y = 0; y < 10; ++y) {
        for (size_t x = 0; x < 10; ++x) {
            // Do something with x and y here
        }
    }
    //因为可以并行执行，所以使用dispatch_apply可以运行的更快
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.starming.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, concurrentQueue, ^(size_t i) {
        NSLog(@"%zu",i);
    });
    NSLog(@"The end"); //这里有个需要注意的是，dispatch_apply这个是会阻塞主线程的。这个log打印会在dispatch_apply都结束后才开始执行
}

@end
