//
//  ViewController.m
//  iOSLock
//
//  Created by LeeWong on 2021/6/10.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self async_barrier_gcd];
}


- (void)async_barrier_gcd {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.brrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务1 -- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"任务2 -- %@",[NSThread currentThread]);
    });
    
    // 栅栏函数，修改同步栅栏和异步栅栏，观察“栅栏结束”的打印位置
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i < 4; i++) {
            NSLog(@"任务3 --- log:%d -- %@",i,[NSThread currentThread]);
        }
    });
    
    // 在这里执行一个输出
    NSLog(@"栅栏结束");
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务4 -- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"任务5 -- %@",[NSThread currentThread]);
    });

}

- (void)sync_barrier_gcd {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.brrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务1 -- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"任务2 -- %@",[NSThread currentThread]);
    });
    
    // 栅栏函数，修改同步栅栏和异步栅栏，观察“栅栏结束”的打印位置
    dispatch_barrier_sync(queue, ^{
        for (int i = 0; i < 4; i++) {
            NSLog(@"任务3 --- log:%d -- %@",i,[NSThread currentThread]);
        }
    });
    
    // 在这里执行一个输出
    NSLog(@"栅栏结束");
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"任务4 -- %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"任务5 -- %@",[NSThread currentThread]);
    });

}

- (void)readWriteBlock {
    __block pthread_rwlock_t rwlock;
    pthread_rwlock_init(&rwlock, NULL);
    NSMutableArray *arrayM = [NSMutableArray array];
    
    void(^WrightBlock)(NSString *) = ^ (NSString *str) {
        pthread_rwlock_wrlock(&rwlock);
        NSLog(@"开启写操作");
        [arrayM addObject:str];
        sleep(2);
        pthread_rwlock_unlock(&rwlock);
    };
    
    void(^ReadBlock)(void) = ^ {
        pthread_rwlock_rdlock(&rwlock);
        NSLog(@"开启读操作");
        sleep(1);
        NSLog(@"读取数据:%@",arrayM);
        pthread_rwlock_unlock(&rwlock);
    };
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            WrightBlock([NSString stringWithFormat:@"%d",i]);
        });
    }
    
    for (int i = 0; i < 5; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            ReadBlock();
        });
    }

}

- (void)semaphore_multi {
    // 创建信号量并初始值为5，最大并发量5
    dispatch_semaphore_t semaphore =  dispatch_semaphore_create(5);
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     for (int i = 0;i < 100 ; i ++) {
         dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
         dispatch_async(queue, ^{
             NSLog(@"i = %d  %@",i,[NSThread currentThread]);
             //此处模拟一个 异步下载图片的操作
             sleep(arc4random()%6);
             dispatch_semaphore_signal(semaphore);
         });
     }

}

- (void)semaphoreLock {
    // 创建信号量并初始化信号量的值为0
     dispatch_semaphore_t semaphone = dispatch_semaphore_create(0);
     
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{     // 线程1
         sleep(2);
         NSLog(@"async1.... %@",[NSThread currentThread]);
         // 主线程因为执行 wait而等待 无法在主线程中执行signal
         dispatch_async(dispatch_get_main_queue(), ^{
             NSLog(@"回到主线程");
             dispatch_semaphore_signal(semaphone);//信号量+1
         });

//         dispatch_semaphore_signal(semaphone);//信号量+1
     });
    // 是否阻塞
    NSLog(@"-----------");
     dispatch_semaphore_wait(semaphone, DISPATCH_TIME_FOREVER);//信号量减1

     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         // 线程2
         sleep(2);
         NSLog(@"async2.... %@",[NSThread currentThread]);
         dispatch_semaphore_signal(semaphone);//信号量+1
     });

}

- (void)conditionLock3 {
    __block pthread_mutex_t mutex;
    __block pthread_cond_t condition;
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&condition, NULL);
    NSMutableArray *arrayM = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        for (int i = 0; i < 6; i++) {
            sleep(1);
            [arrayM addObject:@(i)];
            NSLog(@"异步下载第 %d 张图片",i);
            if (arrayM.count == 4) {
                //pthread_cond_broadcast(&condition);
                pthread_cond_signal(&condition);
            }
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        pthread_cond_wait(&condition, &mutex);
        NSLog(@"已经获取到4张图片");
        pthread_mutex_unlock(&mutex);
    });
}


- (void)conditionLock_downloadimage {
    NSConditionLock *conditionLock = [[NSConditionLock alloc] init];
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger condition = 4;// 条件
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lock];
        for (int i = 0; i < 6; i++) {
            sleep(1);
            [arrayM addObject:@(i)];
            NSLog(@"异步下载第 %d 张图片",i);
            if (arrayM.count == 4) {// 当下载四张图片就回到主线程刷新
                [conditionLock unlockWithCondition:condition];
            }
        }
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [conditionLock lockWhenCondition:condition];
        NSLog(@"已经下载4张图片%@",arrayM);
        [conditionLock unlock];
    });
}


- (void)conditionLock_food {
    NSCondition *conditionLock = [[NSCondition alloc] init];
    __block NSString *food;
    // 消费者1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lock];
        if (!food) {// 没有现成的菜（判断是否满足线程阻塞条件）
            NSLog(@"等待上菜");
            [conditionLock wait];// 没有菜，等着吧！（满足条件，阻塞线程）
        }
        // 菜做好了，可以用餐！（线程畅通，继续执行）
        NSLog(@"开始用餐：%@",food);
        food = nil;
        [conditionLock unlock];
    });
    // 消费者2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lock];
        if (!food) {
            NSLog(@"等待上菜2");
            [conditionLock wait];
        }
        NSLog(@"开始用餐2：%@",food);
        [conditionLock unlock];
    });

    // 生产者
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lock];
        NSLog(@"厨师做菜中...");
        sleep(5);
        food = @"四菜一汤";
        NSLog(@"厨师做好了菜：%@",food);
//        [conditionLock signal];
        [conditionLock broadcast];
        [conditionLock unlock];
    });
}


- (void)pthreadrecursiveLock {
    __block pthread_mutex_t recursiveMutex;
    pthread_mutexattr_t recursiveMutexattr;
    pthread_mutexattr_init(&recursiveMutexattr);
    pthread_mutexattr_settype(&recursiveMutexattr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&recursiveMutex, &recursiveMutexattr);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int  value) {
            pthread_mutex_lock(&recursiveMutex);
            // 这里要设置递归结束的条件或次数，不然会无限递归下去
            if (value > 0) {
                NSLog(@"处理中...");
                sleep(1);
                RecursiveBlock(--value);
            }
            NSLog(@"处理完成!");
            pthread_mutex_unlock(&recursiveMutex);
        };
        RecursiveBlock(4);
    });
}


- (void)nsrecursiveLock {
    NSRecursiveLock *recursiveLock = [[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int  value) {
            [recursiveLock lock];
            // 这里要设置递归结束的条件或次数，不然会无限递归下去
            if (value > 0) {
                NSLog(@"处理中...");
                sleep(1);
                RecursiveBlock(--value);
            }
            NSLog(@"处理完成!");
            [recursiveLock unlock];
        };
        RecursiveBlock(4);
    });
}


- (void)mutexLockTest {
  // 初始化互斥锁
    __block pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    // 或者
    // __block pthread_mutex_t mutex;
    // pthread_mutex_init(&mutex, NULL);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        sleep(5);
        NSLog(@"----- thread1 %@",[NSThread currentThread]);
        pthread_mutex_unlock(&mutex);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        sleep(2);
        NSLog(@"----- thread2 %@",[NSThread currentThread]);
        pthread_mutex_unlock(&mutex);
    });
}


- (void)NSTryLockTest {
    NSLock *lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"---thread1 000");
        BOOL lockOn = [lock tryLock];
        NSLog(@"---thread1 1111 %@",@(lockOn));
        sleep(6);
        [lock unlock];
    });
    NSLog(@"------------");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"---thread2 000");
        [lock lock];
        NSLog(@"---thread2 111");
        sleep(3);
        [lock unlock];
    });
}

- (void)NSLockTest {
    NSLock *lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        NSLog(@"---thread1");
        sleep(6);
        [lock unlock];
        [lock unlock];
    });
    
    NSLog(@"------------");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];;
        NSLog(@"---thread2");
        sleep(3);
        [lock unlock];
    });
}

@end
