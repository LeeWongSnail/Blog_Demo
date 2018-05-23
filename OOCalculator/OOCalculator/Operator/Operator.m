//
//  Operator.m
//  OOCalculator
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "Operator.h"
#import "AddOperator.h"
#import "MinusOperator.h"
#import "MultiplyOperator.h"
#import "DivisionOperator.h"


static NSDictionary<NSString *, NSString *> *leeCalculateDic(){
    
    return @{@"+":@"AddOperator",
             @"-":@"MinusOperator",
             @"*":@"MultiplyOperator",
             @"/":@"DivisionOperator"
             };
}

@interface Operator ()


@end

@implementation Operator

- (instancetype)initWithOptStr:(NSString *)aOpt
{
    if (aOpt.length == 0) {
        return nil;
    }
    
    NSString *cls = leeCalculateDic()[aOpt];
    
    id obj = [NSClassFromString(cls) new];
    
    return obj;
}

@end
