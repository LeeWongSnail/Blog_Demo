//
//  NSObject+Swizzle.m
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (void)methodswizzlingWithClass:(Class)cls orgSEL:(SEL)orgSEL targetSEL:(SEL)targetSEL {
    Method orgMethod = class_getInstanceMethod(cls, orgSEL);
    Method tgtMethod = class_getInstanceMethod(cls, targetSEL);
    method_exchangeImplementations(orgMethod, tgtMethod);
}
//
//+ (void)methodswizzlingWithClass:(Class)cls orgSEL:(SEL)orgSEL targetSEL:(SEL)targetSEL {
//    if (nil == cls) {
//        NSLog(@"methodswizzlingWithClass: nil class");
//        return;
//    }
//
//    Method orgMethod = class_getInstanceMethod(cls, orgSEL);
//    Method tgtMethod = class_getInstanceMethod(cls, targetSEL);
//
//    // 1.当原方法未实现，添加方法，并设置IMP为空实现
//    if (nil == orgMethod) {
//        class_addMethod(cls, orgSEL, method_getImplementation(tgtMethod), method_getTypeEncoding(tgtMethod));
//        method_setImplementation(tgtMethod,
//                                 imp_implementationWithBlock(^(id self, SEL _cmd) {
//            NSLog(@"methodswizzlingWithClass: %@, orgMethod is nil", cls);
//        }));
//        return;
//    }
//
//    // 2.在当前类添加原方法，添加失败，说明当前类实现了该方法
//    BOOL didAddMethod = class_addMethod(cls,
//                                        orgSEL,
//                                        method_getImplementation(orgMethod),
//                                        method_getTypeEncoding(orgMethod));
//    if (didAddMethod) {
//        // 添加成功，当前类未实现，父类实现了orgSEL
//        // 此时不必做方法交换，直接将tgtMethod的IMP替换为父类orgMethod的IMP即可
//        class_replaceMethod(cls,
//                            targetSEL,
//                            method_getImplementation(orgMethod),
//                            method_getTypeEncoding(orgMethod));
//    } else {
//        // 正常情况，直接交换
//        method_exchangeImplementations(orgMethod, tgtMethod);
//    }
//}

@end
