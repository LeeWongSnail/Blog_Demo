//
//  UIResponder+LW.h
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (LW)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
