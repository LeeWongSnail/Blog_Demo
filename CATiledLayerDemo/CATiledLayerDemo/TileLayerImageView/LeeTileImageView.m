//
//  ImageView.m
//  CATiledLayerDemo
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LeeTileImageView.h"

@interface LeeTileImageView()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CGFloat imageScale;
@end

@implementation LeeTileImageView

+ (Class)layerClass {
    return [CATiledLayer class];
}

-(id)initWithFrame:(CGRect)_frame image:(UIImage*)img scale:(CGFloat)scale {
    if ((self = [super initWithFrame:_frame])) {
        self.image = img;
        _imageRect = CGRectMake(0.0f, 0.0f,
                               CGImageGetWidth(_image.CGImage),
                               CGImageGetHeight(_image.CGImage));
        _imageScale = scale;
        CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
        //根据图片的缩放计算scrollview的缩放次数
        // 图片相对于视图放大了1/imageScale倍，所以用log2(1/imageScale)得出缩放次数，
        // 然后通过pow得出缩放倍数，至于为什么要加1，
        // 是希望图片在放大到原图比例时，还可以继续放大一次（即2倍），可以看的更清晰
        int lev = ceil(log2(1/scale))+1;
        tiledLayer.levelsOfDetail = 1;
        tiledLayer.levelsOfDetailBias = lev;
        //        tiledLayer.tileSize  此处tilesize使用默认的256x256即可
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    //将视图frame映射到实际图片的frame
    CGRect rec = CGRectMake(
                            rect.origin.x / _imageScale,
                            rect.origin.y / _imageScale,
                            rect.size.width / _imageScale,
                            rect.size.height / _imageScale
                            );
    //截取指定图片区域，重绘
    CGImageRef cropImg = CGImageCreateWithImageInRect(self.image.CGImage, rec);
    UIImage *tileImg = [UIImage imageWithCGImage:cropImg];
    [tileImg drawInRect:rect];

}

@end
