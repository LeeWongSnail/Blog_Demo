//
//  ViewController.m
//  OOCalculator
//
//  Created by LeeWong on 2018/5/22.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "Operator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, strong) Operator *operator;

//输入的所有运算符(暂时不考虑()括起来的)
@property (nonatomic, strong) NSArray *opts;

//表达式中所有的数字 根据运算符分开
@property (nonatomic, strong) NSArray *nums;


@end

@implementation ViewController


- (void)separtString
{
    NSString *parten = @"[+-]";
    
    NSError* error = NULL;
    
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:nil error:&error];
    
    NSArray* match = [reg matchesInString:self.inputTextField.text options:NSMatchingCompleted range:NSMakeRange(0, [self.inputTextField.text length])];
    
    
    NSMutableArray *opts = [NSMutableArray array];
    NSMutableArray *nums = [NSMutableArray array];
    
    NSString *str = self.inputTextField.text;
    NSInteger startIndex = 0;
    if (match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            
            //range表示的是运算符号出现的位置
            
            NSString *num = [str substringWithRange:NSMakeRange(startIndex, range.location-startIndex)];
            [nums addObject:num];
            
            NSString *opt = [str substringWithRange:range];
            [opts addObject:opt];
            
            startIndex = range.length + range.location;
            
        }
    }
    
    [nums addObject:[str substringWithRange:NSMakeRange(startIndex, str.length-startIndex)]];
    
    self.opts = [opts copy];
    self.nums = [nums copy];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (IBAction)calculatorDidClick:(UIButton *)sender {
    //将给定的字符串分成两个数组 运算符数组和运算数的数组
    [self separtString];
    
    //遍历这个运算符数组 知道数组为空
    CGFloat res = 0;
    while (self.opts.count > 0) {
        //找到所有运算符中优先级最高的
        NSInteger index = [Operator indexOfMostValueableOperator:self.opts];
        Operator *op = [[Operator alloc] initWithOptStr:self.opts[index]];
        //第index个运算符 对应第index和index+1个数字
        CGFloat num1 = [self.nums[index] floatValue];
        CGFloat num2 = [self.nums[index + 1] floatValue];
        
        //取出两个对应的数之后,对这两个数进行计算
        res = [op calculateWithValue:num1 value2:num2];
        
        //删除这个运算符
        NSMutableArray *tempOpt = [NSMutableArray arrayWithArray:self.opts];
        [tempOpt removeObjectAtIndex:index];
        self.opts = [tempOpt copy];
        
        //删除对应的两个数 插入新的数
        NSMutableArray *tempNum = [NSMutableArray arrayWithArray:self.nums];
        if (tempNum.count > 2) {
            [tempNum replaceObjectAtIndex:index+1 withObject:[NSString stringWithFormat:@"%f",res]];
            [tempNum removeObjectAtIndex:index];
        }
        self.nums = [tempNum copy];
    }
    
    self.inputTextField.text = [NSString stringWithFormat:@"%f",res];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
