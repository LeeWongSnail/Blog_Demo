//
//  Operator.h
//  OOCalculator
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSDictionary<NSString *, NSString *> *leeCalculateLevelDic(){
    
    return @{@"+":@"1",
             @"-":@"1",
             @"*":@"2",
             @"/":@"2"
             };
}


@interface Operator : NSObject

- (instancetype)initWithOptStr:(NSString *)aOpt;


- (CGFloat)calculateWithValue:(CGFloat)value1 value2:(CGFloat)value2;



+ (NSInteger)indexOfMostValueableOperator:(NSArray *)opts;

@end
