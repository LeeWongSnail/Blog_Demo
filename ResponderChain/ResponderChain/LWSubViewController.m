//
//  LWSubViewController.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "LWSubViewController.h"
#import "LWBlueView.h"
#import "UIResponder+LW.h"


@interface LWSubViewController ()

@end

@implementation LWSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    LWBlueView *blueView = [[LWBlueView alloc] initWithFrame:CGRectMake(25, 50, 325, 300)];
    [self.view addSubview:blueView];
}




@end
