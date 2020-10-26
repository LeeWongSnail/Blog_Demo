//
//  ViewController.m
//  MethodSwizzlzeDemo
//
//  Created by LeeWong on 2020/10/25.
//

#import "ViewController.h"
#import "Animal.h"
#import "Person.h"
#import "Tiger.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

//        [self swizzleMethod:[Person class] swizzCls:[Tiger class] orgSel:@selector(speak) swizzSel:@selector(yall)];
        [self swizzleMethod:[Tiger class] swizzCls:[Person class] orgSel:@selector(walk) swizzSel:@selector(speak)];
//        [self swizzleMethod:[self class] orgSel:@selector(originTest) swizzSel:@selector(viewDidLoad)];
//        [self exchangeImp];
    });
}

+ (BOOL)swizzleMethod:(Class)originClass swizzCls:(Class)swizzClass orgSel:(SEL)origSel swizzSel:(SEL)swizzSel {
    Method origMethod = class_getInstanceMethod(originClass, origSel);
    Method altMethod = class_getInstanceMethod(swizzClass, swizzSel);
    NSLog(@"swizzleMethod origMethod %@",NSStringFromSelector(method_getName(origMethod)));
    NSLog(@"swizzleMethod altMethod %@",NSStringFromSelector(method_getName(altMethod)));

    BOOL didAddMethod = class_addMethod(originClass,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));

    NSLog(@"swizzleMethod didAddMethod %@",@(didAddMethod));
    if (didAddMethod) {
        class_replaceMethod(swizzClass,swizzSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }

    return YES;
}

+ (BOOL)swizzleMethod:(Class)class orgSel:(SEL)origSel swizzSel:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method altMethod = class_getInstanceMethod(class, altSel);
    NSLog(@"swizzleMethod origMethod %@",NSStringFromSelector(method_getName(origMethod)));
    NSLog(@"swizzleMethod altMethod %@",NSStringFromSelector(method_getName(altMethod)));

    BOOL didAddMethod = class_addMethod(class,origSel,
                                        method_getImplementation(altMethod),
                                        method_getTypeEncoding(altMethod));
    NSLog(@"swizzleMethod didAddMethod %@",@(didAddMethod));
    if (didAddMethod) {
        class_replaceMethod(class,altSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, altMethod);
    }

    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testExchangeTwoClsTwoMethod];
//    [self performSelector:@selector(test)];
//    [self originTest];
}

- (void)originTest {
    NSLog(@"originTest");
}

//- (void)lw_viewWillAppear:(BOOL)animated {
//    NSLog(@"lw_viewWillAppear");
////    [self lw_viewWillAppear:animated];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear 1111");
}

- (void)testExchangeTwoClsTwoMethod {
    Person *p = [[Person alloc] init];
    [p speak];
    NSLog(@"-----");
    Tiger *t = [[Tiger alloc] init];
    [t performSelector:@selector(speak)];
}

@end
