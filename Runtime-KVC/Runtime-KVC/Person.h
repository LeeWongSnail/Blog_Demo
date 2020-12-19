//
//  Person.h
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

- (NSString *)getisNameValue;
- (NSInteger)getisAgeValue;
@end

NS_ASSUME_NONNULL_END
