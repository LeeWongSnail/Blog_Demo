//
//  Person.h
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (void)walk;

- (void)run;

- (void)jump;
@end

NS_ASSUME_NONNULL_END
