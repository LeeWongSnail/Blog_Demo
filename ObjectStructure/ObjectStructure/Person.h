//
//  Person.h
//  ObjectStructure
//
//  Created by LeeWong on 2021/1/2.
//

#import <Foundation/Foundation.h>
#import "House.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSInteger age;

@property (nonatomic,copy) NSArray *experiences;

@property (nonatomic,strong) House *house;


- (NSString *)personDescription;

@end

NS_ASSUME_NONNULL_END
