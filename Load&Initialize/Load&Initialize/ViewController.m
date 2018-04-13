//
//  ViewController.m
//  Load&Initialize
//
//  Created by LeeWong on 2018/4/13.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "Son.h"
#import "Student.h"
#import "Teacher.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Student *son = [[Student alloc] init];
    Teacher *tea = [[Teacher alloc] init];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
