//
//  NSObject+Swizzle.h
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)
+ (void)methodswizzlingWithClass:(Class)cls orgSEL:(SEL)orgSEL targetSEL:(SEL)targetSEL;
@end

NS_ASSUME_NONNULL_END
