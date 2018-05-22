//
//  ViewController.m
//  CATiledLayerDemo
//
//  Created by LeeWong on 2018/5/21.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ImageScrollView.h"
@interface ViewController ()
@property (strong, nonatomic) ImageScrollView *imageScrollView;
@property (nonatomic, strong) UIImage *largeImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *imageURL = @"https://test-imagecache.oss-cn-shanghai.aliyuncs.com/%E4%B8%AD%E5%9B%BD%E5%9C%B0%E5%9B%BE11935x8554.jpg";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    [self.imageScrollView removeFromSuperview];
    self.largeImage = [UIImage imageWithData:data];
    
    self.imageScrollView = [[ImageScrollView alloc] initWithFrame:self.view.bounds
                                                            image:self.largeImage];
    
    [self.view addSubview:self.imageScrollView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
