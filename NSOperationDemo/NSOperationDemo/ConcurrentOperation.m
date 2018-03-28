//
//  ConcurrentOperation.m
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ConcurrentOperation.h"

@implementation ConcurrentOperation
//用 @synthesize 关键字手动合成了两个实例变量 _executing 和 _finished ，
//然后分别在重写的 isExecuting 和 isFinished 方法中返回了这两个实例变量
//通过查看 NSOperation 类的头文件可以发现，executing 和 finished 属性都被声明成了只读的 readonly 。
//所以我们在 NSOperation 子类中就没有办法直接通过 setter 方法来自动触发 KVO 通知，
//这也是为什么我们需要在接下来的代码中手动触发 KVO 通知的原因。
@synthesize executing = _executing;
@synthesize finished  = _finished;

- (id)init {
    self = [super init];
    if (self) {
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

//是否为并发
- (BOOL)isConcurrent {
    return YES;
}

//是否正在执行
- (BOOL)isExecuting {
    return _executing;
}

// 是否完成
- (BOOL)isFinished {
    return _finished;
}

- (void)start {
//    在真正开始执行任务前，我们通过检查 isCancelled 方法的返回值来判断 operation 是否已经被 cancel ，如果是就直接返回了
//    即使一个 operation 是被 cancel 掉了，我们仍然需要手动触发 isFinished 的 KVO 通知。
//    因为当一个 operation 依赖其他 operation 时，它会观察所有其他 operation 的 isFinished 的值的变化，
//    只有当它依赖的所有 operation 的 isFinished 的值为 YES 时，这个 operation 才能够开始执行。
//    因此，如果一个我们自定义的 operation 被取消了但却没有手动触发 isFinished 的 KVO 通知的话，
//    那么所有依赖它的 operation 都不会执行
    if (self.isCancelled) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
//    为 main 方法分离了一个新的线程 这是 operation 能够并发执行的关键所在
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
}

//在任务执行完毕后，我们需要手动触动 isExecuting 和 isFinished 的 KVO 通知。
- (void)main {
    @try {
        NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);
        
        sleep(3);
        
        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];
        
        [self willChangeValueForKey:@"isFinished"];
        _finished  = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

@end
