//
//  ImageScrollView.m
//  CATiledLayerDemo
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LeeImageScrollView.h"
#import "LeeTileImageView.h"

@interface LeeImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic, strong) LeeTileImageView *frontTiledView;

@end

@implementation LeeImageScrollView

- (instancetype)initWithFrame:(CGRect)aFrame image:(UIImage *)aImage {
    if((self = [super initWithFrame:aFrame])) {
        // Set up the UIScrollView
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        self.backgroundColor = [UIColor colorWithRed:0.4f green:0.2f blue:0.2f alpha:1.0f];
        
        // 根据图片实际尺寸和屏幕尺寸计算图片视图的尺寸
        self.image = aImage;
        CGRect imageRect = CGRectMake(
                                      0.0f,
                                      0.0f,
                                      CGImageGetWidth(_image.CGImage),
                                      CGImageGetHeight(_image.CGImage));
        _imageScale = self.frame.size.width/imageRect.size.width;
        
        NSLog(@"imageScale: %f",_imageScale);
        imageRect.size = CGSizeMake(
                                    imageRect.size.width*_imageScale,
                                    imageRect.size.height*_imageScale);
        
        //根据图片的缩放计算scrollview的缩放级别
        // 图片相对于视图放大了1/imageScale倍，所以用log2(1/imageScale)得出缩放次数，
        // 然后通过pow得出缩放倍数，至于为什么要加1，
        // 是希望图片在放大到原图比例时，还可以继续放大一次（即2倍），可以看的更清晰
        int level = ceil(log2(1/_imageScale))+1;
        CGFloat zoomOutLevels = 1;
        CGFloat zoomInLevels = pow(2, level);
        
        self.maximumZoomScale =zoomInLevels;
        self.minimumZoomScale = zoomOutLevels;
        
        _frontTiledView = [[LeeTileImageView alloc] initWithFrame:imageRect
                                                               image:_image
                                                               scale:_imageScale];
        [self addSubview:_frontTiledView];
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _frontTiledView;
}

@end
