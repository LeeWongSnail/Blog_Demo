//
//  Student.h
//  Runtime-KVO
//
//  Created by LeeWong on 2021/6/13.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person
@property (nonatomic, copy, readonly) NSString *className;

- (void)modifyClassName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
