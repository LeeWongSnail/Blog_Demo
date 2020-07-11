//
//  ViewController.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "UIResponder+LW.h"
#import "LWSubViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LWSubViewController *vc = [[LWSubViewController alloc] init];
    [self.view addSubview:vc.view];
    vc.view.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 400);
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSLog(@"event name %@  info%@",eventName,userInfo);
}

@end
