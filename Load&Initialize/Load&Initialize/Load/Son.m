//
//  Son.m
//  Load&Initialize
//
//  Created by LeeWong on 2018/4/13.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "Son.h"

@implementation Son

+ (void)load
{
    NSLog(@"%s",__func__);
}
@end


@implementation GrandSon

+ (void)load
{
    NSLog(@"%s",__func__);
}
@end
