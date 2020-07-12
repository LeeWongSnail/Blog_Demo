//
//  LWBrownView.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "LWBrownView.h"
#import "UIResponder+LW.h"

@implementation LWBrownView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSLog(@"LWBlackView event name %@  info%@",eventName,userInfo);
}

@end
