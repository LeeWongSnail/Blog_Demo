//
//  IMPTestViewController.m
//  RunTime_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

//
#import "IMPTestViewController.h"
#import <objc/runtime.h>


typedef void (* _IMP)(id,SEL,...);
typedef id (* _VIMP)(id,SEL,...);

@interface IMPTestViewController ()

@end

@implementation IMPTestViewController

//交换方法
//+(void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
//        Method my_viewDidLoad = class_getInstanceMethod(self, @selector(my_viewDidLoad));
//
//        method_exchangeImplementations(viewDidLoad, my_viewDidLoad);
//    });
//}


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        _IMP my_viewDidLoad_IMP = (_IMP)method_getImplementation(viewDidLoad);
        //如果要修改的方法是一个有返回值的方法那么 需要修改 _IMP 改为有返回值类型的
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target,SEL action){
            my_viewDidLoad_IMP(target,@selector(viewDidLoad));
            NSLog(@"%s",__func__);
        }));

    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)my_viewDidLoad
//{
//    [self my_viewDidLoad];
//    NSLog(@"%s",__func__);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
