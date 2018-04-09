//
//  methodSignatureObj.m
//  RunTime_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "methodSignatureObj.h"
#import "Animal.h"

@implementation methodSignatureObj

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if([Animal instancesRespondToSelector:aSelector])
        {
            signature = [Animal instanceMethodSignatureForSelector:aSelector];
        }
        
    }
    return signature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
//    if ([methodSignatureObj instancesRespondToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:[[methodSignatureObj alloc] init]];
//    } else {
//        [super forwardInvocation:anInvocation];
//    }
    
    
    NSString *selName = NSStringFromSelector(anInvocation.selector);
    if ([selName isEqualToString:@"sign"]) {
        [anInvocation setSelector:@selector(signTest:)];
        [anInvocation invokeWithTarget:[methodSignatureObj new]];
    }
    
}

- (void)signTest:(NSString *)a {
    NSLog(@"%s",__func__);
}


@end
