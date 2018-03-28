//
//  ViewController.m
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "NSInvocationOperationModel.h"
#import "NSInvocationBlockOperationModel.h"
@interface ViewController ()

@end

@implementation ViewController

//队列中operation的依赖关系
- (void)operationDependencyTest
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 test");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2 test");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3 test");
    }];
    
    //op1依赖于op2
    [op1 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

// 设置队列中operation的优先级
- (void)QueuePriorityTest
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 test");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2 test");
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3 test");
    }];
//    NSOperationQueuePriorityVeryLow = -8L,
//    NSOperationQueuePriorityLow = -4L,
//    NSOperationQueuePriorityNormal = 0,
//    NSOperationQueuePriorityHigh = 4,
//    NSOperationQueuePriorityVeryHigh = 8
    [op1 setQueuePriority:NSOperationQueuePriorityHigh];
    [op3 setQueuePriority:NSOperationQueuePriorityLow];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

// 设置completionBlock
- (void)completionBlockTest
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 test");
    }];
    
    NSBlockOperation* op2 = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation* myWeakOp = op2;
    myWeakOp = [NSBlockOperation blockOperationWithBlock:^{
        sleep(5);
        // 如果要可以取消需要自己加判断
        if ([myWeakOp isCancelled]) {
            return ;
        }
        NSLog(@"op2 test");
    }];
    
    [op2 setCompletionBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
        //回调的线程跟触发KVO isFinished的在一个线程不一定是主线程 如果不是主线程 而且在这个回调里
        // 做了更新UI的操作需要在主线程更新
        if (![NSThread isMainThread]) {
            NSLog(@"not main thread update ui in main thread");
        }
        //即使任务呗取消了 也会走CompletionBlock 只不过可以通过cancelled属性判断
        if (myWeakOp.cancelled) {
            NSLog(@"op2 cancelled");
        }
        NSLog(@"op2 complete");
    }];
  
    __weak typeof(op1) weakOp1 = op1;
    [op1 setCompletionBlock:^{
        NSLog(@"op1 complete");
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    sleep(1);
    [queue cancelAllOperations];
    NSLog(@"op2 cancel");
 
}


// 将operation加入到NSOperationQueue的几种方式
- (void)executeOperationUsingOperationQueue {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    //NSInvocationOperation 创建并加入到NSOperationQueue中
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(taskMethod) object:nil];
    [operationQueue addOperation:invocationOperation];
    
    //通过NSBlockOperation创建operation
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"Finish executing blockOperation1");
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(3);
        NSLog(@"Finish executing blockOperation2");
    }];
    
    //将blockOperation1 blockOperation2 加入到队列中 并且设置 只有等待operationQueue 都执行完成才可以
    // 执行后面的
    [operationQueue addOperations:@[ blockOperation1, blockOperation2 ] waitUntilFinished:YES];
    NSLog(@"blockOperation1 blockOperation2 taskMethod all finished");
    [operationQueue addOperationWithBlock:^{
        sleep(3);
        NSLog(@"Finish executing block");
    }];
    
    //等待operationQueue中所有的operation都执行完了 才会执行后面的
    [operationQueue waitUntilAllOperationsAreFinished];
    NSLog(@"test end");
}

- (void)taskMethod {
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}


//将最大并发线程数设置为1 基本上相当于一个串行的队列 但是不保证FIFO
- (void)maxConcurrentOperationCount
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperationWithBlock:^{
        NSLog(@"1111");
    }];
    
    [queue addOperationWithBlock:^{
        sleep(1);
        NSLog(@"222");
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"333");
    }];
}

// 暂停一个队列的执行 
- (void)operationSuspend
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperationWithBlock:^{
        NSLog(@"1111");
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"222");
    }];
    sleep(1);
    [queue setSuspended:YES];
    [queue addOperationWithBlock:^{
        NSLog(@"333");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self operationSuspend];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
