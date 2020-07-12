//
//  LWCyanView.h
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWCyanView;

@protocol LWCyanViewDelegate <NSObject>

/// 按钮的点击事件
/// @param cyanView cyanView description
- (void)cyanViewButtonDidClick:(LWCyanView *_Nullable)cyanView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LWCyanView : UIView

@property (nonatomic, weak) id <LWCyanViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
