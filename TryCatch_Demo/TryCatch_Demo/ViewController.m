//
//  ViewController.m
//  TryCatch_Demo
//
//  Created by LeeWong on 2018/4/12.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/NSException.h>

@interface ViewController ()

@end

@implementation ViewController

//捕获异常
- (void)catchException
{
    NSArray* array = [[NSArray alloc] init];
    
    @try
    {
        // Attempt access to an empty array
        NSLog(@"Object: %@", [array objectAtIndex:0]);
        
    }
    //虽然支持捕捉特定类型的NSException 但是 异常的类型确只有NSException这一种 奇怪
    @catch (NSException *exception)
    {
        // Print exception information
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        return;
    }
    
    @finally
    {
        // Cleanup, in both success and fail cases
        NSLog( @"In finally block");
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
