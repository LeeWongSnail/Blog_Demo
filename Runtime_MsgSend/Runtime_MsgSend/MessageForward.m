//
//  MessageForward.m
//  Runtime_MsgSend
//
//  Created by LeeWong on 2020/11/15.
//

#import "MessageForward.h"
#import <objc/runtime.h>

@implementation MessageForward

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if ([NSStringFromSelector(sel) isEqualToString:@"testMethod"]) {
//        Method testmethod = class_getInstanceMethod(self, @selector(test));
//        IMP testIMP = method_getImplementation(testmethod);
//        class_addMethod(self, sel, testIMP, method_getTypeEncoding(testmethod));
//        return YES;
//    }
//    return NO;
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"testMethod"]) {
        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return signature;
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([NSStringFromSelector(anInvocation.selector) isEqualToString:@"testMethod"]) {
        [self test];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)test {
    NSLog(@"MessageForward %s",__func__);
}

@end
