//
//  UIViewController+Exchange.m
//  MethodSwizzlzeDemo
//
//  Created by LeeWong on 2020/10/25.
//

#import "UIViewController+Exchange.h"
#import <objc/runtime.h>

@implementation UIViewController (Exchange)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [self exchangeImp];
    });
}

+ (void)exchangeImp {
//    Class aClass = object_getClass(self);
    Class aClass = [self class];
    NSLog(@"exchangeImp class %@",NSStringFromClass(aClass));
    SEL originalSelector = @selector(originMethod);
    SEL swizzledSelector = @selector(swizzleMethod);

    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);

    NSLog(@"exchangeImp originalMethod %@",NSStringFromSelector(method_getName(originalMethod)));
    NSLog(@"exchangeImp swizzledMethod %@",NSStringFromSelector(method_getName(swizzledMethod)));

    IMP result = class_replaceMethod(aClass, originalSelector,method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    NSLog(@"result is %p", result);
}

- (void)originMethod {
    NSLog(@"orignMethod");
}

- (void)swizzleMethod {
    NSLog(@"swizzleMethod");
}

@end
