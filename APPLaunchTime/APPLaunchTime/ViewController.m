//
//  ViewController.m
//  APPLaunchTime
//
//  Created by LeeWong on 2020/6/27.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSInteger loc = 1;
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (NSInteger index = 1; index < 10; index++) {
//        loc += index;
////        [arrM addObject:@(index)];
//        [self testLog:@(index).stringValue];
////        testPrint();
//    }
//    loc += 1000;
//    [self testLog:nil];
    [self addVCSubView];
}

- (void)testLog:(NSString *)logMessage {
//    NSLog(@"[testLog]------ %@",logMessage);
}


- (void)addVCSubView {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@200);
    }];


    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    [contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.centerY.equalTo(contentView);
        make.top.equalTo(contentView.mas_top).offset(20);
        make.width.height.equalTo(@100);
    }];
}

@end
