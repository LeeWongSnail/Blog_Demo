//
//  ViewController.m
//  TaggedPointerDemo
//
//  Created by LeeWong on 2020/8/8.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
//#import <objc/objc-internal.h>

@interface ViewController ()
@property (nonatomic, strong) NSObject *obj1;
@property (nonatomic, strong) NSObject *obj2;
@property(nonatomic, weak) NSObject *weakRefObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    NSMutableString *mutableStr = [NSMutableString string];
//    NSString *immutable = nil;
//    #define _OBJC_TAG_MASK (1UL<<63)
//
//    for (NSInteger index = 0; index < 12; index++) {
//        [mutableStr appendFormat:@"a"];
//        immutable = [mutableStr copy];
//        NSLog(@"%p %@ %@", immutable, immutable, immutable.class);
//    }
//    [self stringValue];
}

//- (void)stringValue {
//    NSString *str1 = [NSString stringWithFormat:@"1"];
//    NSString *str2 = [NSString stringWithFormat:@"2"];
//
//    uintptr_t value1 = objc_getTaggedPointerValue((__bridge void *)str1);
//    uintptr_t value2 = objc_getTaggedPointerValue((__bridge void *)str2);
//    NSLog(@"%lx", value1);
//    NSLog(@"%lx", value2);
//}


- (void)testisa {
    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"1. obj isa_t = %p", *(void **)(__bridge void*)obj);
    _obj1 = obj;
    NSObject *tmpObj = obj;
    NSLog(@"2. obj isa_t = %p", *(void **)(__bridge void*)obj);

    _weakRefObj = _obj1;
    NSLog(@"3. obj isa_t = %p", *(void **)(__bridge void*)_obj1);
    NSObject *attachObj = [[NSObject alloc] init];
    objc_setAssociatedObject(_obj1, "attachKey", attachObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"4. obj isa_t = %p", *(void **)(__bridge void*)_obj1);
}


- (void)test {
    NSNumber *number1 = @(0x1);
    NSNumber *number2 = @(0x20);
    NSNumber *number3 = @(0x3F);
    NSNumber *numberFFFF = @(0xFFFFFFFFFFEFE);
    NSNumber *maxNum = @(MAXFLOAT);
    NSLog(@"number1 pointer is %p class is %@", number1, number1.class);
    NSLog(@"number2 pointer is %p class is %@", number2, number2.class);
    NSLog(@"number3 pointer is %p class is %@", number3, number3.class);
    NSLog(@"numberffff pointer is %p class is %@", numberFFFF, numberFFFF.class);
    NSLog(@"maxNum pointer is %p class is %@", maxNum, maxNum.class);
}


@end
