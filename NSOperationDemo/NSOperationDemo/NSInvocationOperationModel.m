//
//  NSInvocationOperationModel.m
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "NSInvocationOperationModel.h"

@implementation NSInvocationOperationModel

- (NSInvocationOperation *)invocationOperationWithData:(id)data {
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(myTaskMethod1:) object:data];
}

- (void)myTaskMethod1:(id)data {
    NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), data, [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}


//我们可以根据上下文动态地调用 object 的不同 selector 。比如说，我们可以根据用户的输入动态地执行不同的 selector ：
- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInput {
    NSInvocationOperation *invocationOperation = [self invocationOperationWithData:data];
    
    if (userInput.length == 0) {
        invocationOperation.invocation.selector = @selector(myTaskMethod2:);
    }
    
    return invocationOperation;
}

- (void)myTaskMethod2:(id)data {
    NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), data, [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
}
@end
