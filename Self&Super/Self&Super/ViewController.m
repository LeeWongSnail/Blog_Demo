//
//  ViewController.m
//  Self&Super
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ChenPerson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //父类会调用子类重载自己的方法 
    ChenPerson *p = [[ChenPerson alloc] init];
    p.lastName = @"wang";
    NSLog(@"%@",p.lastName);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
