//
//  Person.h
//  ObjectLifeTime
//
//  Created by LeeWong on 2020/11/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;


@end

NS_ASSUME_NONNULL_END
