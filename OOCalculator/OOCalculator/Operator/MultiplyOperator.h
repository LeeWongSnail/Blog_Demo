//
//  MultiplyOperator.h
//  OOCalculator
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "Operator.h"

@interface MultiplyOperator : Operator

- (CGFloat)calculateWithValue:(CGFloat)value1 value2:(CGFloat)value2;
@end
