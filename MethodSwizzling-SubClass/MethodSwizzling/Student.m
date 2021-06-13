//
//  Student.m
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import "Student.h"
#import "NSObject+Swizzle.h"
@implementation Student

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodswizzlingWithClass:self
                                orgSEL:@selector(jump)
                             targetSEL:@selector(study)];
    });
}

- (void)study {
    NSLog(@"study");
}

@end
