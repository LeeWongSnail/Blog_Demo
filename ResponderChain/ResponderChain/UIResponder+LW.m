//
//  UIResponder+LW.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "UIResponder+LW.h"

@implementation UIResponder (LW)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSString *newName = [NSString stringWithFormat:@"%@--%@",NSStringFromClass(self.class),eventName];
    [[self nextResponder] routerEventWithName:newName userInfo:userInfo];
}
@end
