//
//  Person.m
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import "Person.h"
#import "NSObject+Swizzle.h"

@implementation Person

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodswizzlingWithClass:self
                                orgSEL:@selector(walk)
                             targetSEL:@selector(run)];
    });
}

- (void)walk {
    NSLog(@"walk");
}

- (void)run {
    NSLog(@"run");
}

- (void)jump {
    NSLog(@"jump");
}
@end
