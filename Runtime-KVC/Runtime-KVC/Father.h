//
//  Father.h
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "Person.h"

@class Son;

NS_ASSUME_NONNULL_BEGIN

@interface Father : Person
@property (nonatomic, copy) NSArray <Son *> *children;
@end

NS_ASSUME_NONNULL_END
