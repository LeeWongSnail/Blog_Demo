//
//  Person.m
//  RunTime_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "resolveInstanceObj.h"
#import <objc/runtime.h>
#import "Animal.h"

@implementation resolveInstanceObj

//让你有机会提供一个函数实现。如果你添加了函数，那运行时系统就会重新启动一次消息发送的过程，否则 ，运行时就会移到下一步，消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"eatGrass"]) {
        class_addMethod([self class], sel, (IMP)resolveMethod,"v@:");
        return YES;
    }

    
    return [super resolveInstanceMethod:sel];
}

void resolveMethod(id self, SEL _cmd) {
    NSLog(@"我被调用了");
}




@end
