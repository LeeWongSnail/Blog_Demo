//
//  ImageView.h
//  CATiledLayerDemo
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView
-(id)initWithFrame:(CGRect)_frame image:(UIImage*)img scale:(CGFloat)scale;
@end
