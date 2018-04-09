//
//  Person.h
//  RunTime_Demo
//
//  Created by LeeWong on 2018/4/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)eatGrass;
@end
