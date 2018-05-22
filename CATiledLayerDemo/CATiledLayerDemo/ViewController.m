//
//  ViewController.m
//  CATiledLayerDemo
//
//  Created by LeeWong on 2018/5/21.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "LeeImageScrollView.h"
@interface ViewController ()
@property (strong, nonatomic) LeeImageScrollView *imageScrollView;
@property (nonatomic, strong) UIImage *largeImage;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imageURL = @"https://test-imagecache.oss-cn-shanghai.aliyuncs.com/%E4%B8%AD%E5%9B%BD%E5%9C%B0%E5%9B%BE11935x8554.jpg";
    //这里直接卡在主线程 等到图片下载完成之后在去显示UI的两种加载按钮
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    self.largeImage = [UIImage imageWithData:data];
    
    
}

- (IBAction)tileLoad:(UIButton *)sender {
    [self.imageView removeFromSuperview];
    [self.imageScrollView removeFromSuperview];
    self.imageScrollView = [[LeeImageScrollView alloc] initWithFrame:self.view.bounds
                                                               image:self.largeImage];
    
    [self.view addSubview:self.imageScrollView];
}



- (IBAction)normalLoad:(UIButton *)sender {
    [self.imageView removeFromSuperview];
    [self.imageScrollView removeFromSuperview];
    self.imageView = [[UIImageView alloc] initWithImage:self.largeImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    self.imageView.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
