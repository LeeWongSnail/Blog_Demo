//
//  UIViewController+Exchange.h
//  MethodSwizzlzeDemo
//
//  Created by LeeWong on 2020/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Exchange)
- (void)originMethod;
- (void)swizzleMethod;
@end

NS_ASSUME_NONNULL_END
