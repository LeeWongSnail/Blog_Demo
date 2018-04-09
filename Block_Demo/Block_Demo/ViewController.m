//
//  ViewController.m
//  Block_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

//Block不允许修改外部变量的值，这里所说的外部变量的值，指的是栈中指针的内存地址。栈区是红灯区，堆区才是绿灯区。
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//修改了a的值但是并没有修改b的值 因为 block中的修改是讲变量从栈区拷贝到堆区 然后在做修改
- (void)varibleLocation
{
    __block NSInteger a = 0;
    NSInteger b = a;
    NSLog(@"1----%p",&a);   //栈区
    void (^foo)(void) = ^{
        a = 1;
        NSLog(@"2---%p",&a);    //堆区
    };
    NSLog(@"3---%p",&a);     //堆区
    foo();
    NSLog(@"4---%p",&a);     //堆区
    
    NSLog(@"b value %tu",b);

}


// 对象类型
//block会对对象类型的指针进行copy，copy到堆中，但并不会改变该指针所指向的堆中的地址，
//所以在上面的示例代码中，block体内修改的实际是a指向的堆中的内容
- (void)blockModifyVar
{
    NSMutableString *a = [NSMutableString stringWithString:@"Tom"];
    NSLog(@"\n 定以前：------------------------------------\n\
          a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
    void (^foo)(void) = ^{
        //可以修改a的属性的值
        a.string = @"Jerry";
        NSLog(@"\n block内部：------------------------------------\n\
              a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
//        a = [NSMutableString stringWithString:@"William"];
    };
    foo();
    NSLog(@"\n 定以后：------------------------------------\n\
          a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self blockModifyVar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
