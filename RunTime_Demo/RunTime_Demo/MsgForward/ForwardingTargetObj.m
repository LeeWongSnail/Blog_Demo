//
//  ForwardingTargetObj.m
//  RunTime_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ForwardingTargetObj.h"
#import "Animal.h"

@implementation ForwardingTargetObj



-(id)forwardingTargetForSelector:(SEL)aSelector
{
    NSString *selectorName = NSStringFromSelector(aSelector);
    if ([selectorName isEqualToString:@"forward"]) {
        Animal *ani = [[Animal alloc] init];
        return ani;
    }
    return [super forwardingTargetForSelector:aSelector];
}


@end
