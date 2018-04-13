//
//  Son+Test.m
//  Load&Initialize
//
//  Created by LeeWong on 2018/4/13.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "Son+Test.h"

@implementation Son (Test)
+ (void)load
{
    NSLog(@"Son Category %s",__func__);
}
@end

@implementation GrandSon (Test)
+ (void)load
{
    NSLog(@"GrandSon Category %s",__func__);
}
@end
