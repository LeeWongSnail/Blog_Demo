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

+ (NSInteger)indexOfMostValueableOperator:(NSArray *)opts
{
    if (opts.count == 0) {
        return -1;
    }
    __block NSInteger index = -1;
    __block NSInteger level = 0;
    [opts enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //通过比较找到优先级最高的
        if ([leeCalculateLevelDic()[obj] integerValue] > level) {
            index = idx;
            level = [leeCalculateLevelDic()[obj] integerValue];
        }
    }];
    
    return index;
}

- (NSArray *)sortCalculateOperator:(NSArray *)opts
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    
    
    return [arrM copy];
}

@end
