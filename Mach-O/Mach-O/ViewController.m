//
//  ViewController.m
//  Mach-O
//
//  Created by LeeWong on 2020/8/30.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "KeyDef.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *lw_property;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)lw_publicMethod {
    NSLog(@"this is custom log");
}

- (void)lw_privateMethod {
    NSLog(@"%@",lw_constsecretKey);
}

+ (void)lw_classMethod {
    
}

@end
