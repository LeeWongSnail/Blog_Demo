//
//  NSInvocationBlockOperationModel.m
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "NSInvocationBlockOperationModel.h"

@implementation NSInvocationBlockOperationModel
- (NSBlockOperation *)blockOperation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Start executing block1, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(3);
        NSLog(@"Finish executing block1");
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"Start executing block2, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(5);
        NSLog(@"Finish executing block2");
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"Start executing block3, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        sleep(4);
        NSLog(@"Finish executing block3");
    }];
    
    return blockOperation;
}
@end
