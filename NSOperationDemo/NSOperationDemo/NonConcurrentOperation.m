//
//  NonConcurrentOperation.m
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "NonConcurrentOperation.h"

@interface NonConcurrentOperation ()

@property (strong, nonatomic) id data;

@end
@implementation NonConcurrentOperation
- (id)initWithData:(id)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

/// 支持取消操作
- (void)main {
    @try {
        if (self.isCancelled) return;
        
        NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.data, [NSThread mainThread], [NSThread currentThread]);
        
        for (NSUInteger i = 0; i < 3; i++) {
            if (self.isCancelled) return;
            
            sleep(1);
            
            NSLog(@"Loop %@", @(i + 1));
        }
        
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}
@end
