//
//  NSInvocationOperationModel.h
//  NSOperationDemo
//
//  Created by LeeWong on 2018/3/28.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocationOperationModel : NSInvocationOperation

- (NSInvocationOperation *)invocationOperationWithData:(id)data;
- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInput;

@end
