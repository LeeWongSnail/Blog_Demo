//
//  ViewController.m
//  Runtime_MsgSend
//
//  Created by LeeWong on 2020/10/31.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self exeIMP];
}

- (BOOL)canSayHi:(NSString *)name {
    NSLog(@"can say hi to %@",name);
    return YES;
}

+ (BOOL)canSayHi:(NSString *)name {
    NSLog(@"can say hi to %@",name);
    return YES;
}

- (void)test {
    NSLog(@"test");
}

- (void)exeIMP {
    Method method = class_getInstanceMethod([self class], @selector(test));
    IMP imp = method_getImplementation(method);
    imp();
}

+ (void)initialize {

}


- (void)getMethodStructure {
    Method method = class_getInstanceMethod([self class], @selector(canSayHi:));
    NSLog(@"method sel %@",NSStringFromSelector(method_getName(method)));
    NSLog(@"method types %@",[NSString stringWithFormat:@"%s",method_getTypeEncoding(method)]);
    NSLog(@"method imp %p",method_getImplementation(method));

    Method method1 = class_getClassMethod([self class], @selector(canSayHi:));
    NSLog(@"method sel %@",NSStringFromSelector(method_getName(method1)));
    NSLog(@"method types %@",[NSString stringWithFormat:@"%s",method_getTypeEncoding(method1)]);
    NSLog(@"method imp %p",method_getImplementation(method1));

    BOOL isEqual = sel_isEqual(method_getName(method), method_getName(method1));
    NSLog(@"isEqual %@",@(isEqual));
}

- (void)getClassMethodStructure {
    Method method = class_getClassMethod([self class], @selector(canSayHi:));
    NSLog(@"method sel %@",NSStringFromSelector(method_getName(method)));
    NSLog(@"method types %@",[NSString stringWithFormat:@"%s",method_getTypeEncoding(method)]);
    NSLog(@"method imp %p",method_getImplementation(method));
}

@end
