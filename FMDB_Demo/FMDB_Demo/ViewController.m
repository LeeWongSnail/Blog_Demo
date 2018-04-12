//
//  ViewController.m
//  FMDB_Demo
//
//  Created by LeeWong on 2018/4/12.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "FMDBService.h"

@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[FMDBService shared] initDataBase];
    
//    [[FMDBService shared] createTable];
    
    //事务
    [[FMDBService shared] insertContentWithTransation];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
