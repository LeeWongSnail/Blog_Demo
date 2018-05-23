//
//  Operator.h
//  OOCalculator
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Operator : NSObject

- (instancetype)initWithOptStr:(NSString *)aOpt;


- (CGFloat)calculateWithValue:(CGFloat)value1 value2:(CGFloat)value2;


@end
