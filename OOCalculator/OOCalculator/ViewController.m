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
            
            NSString *num = [str substringWithRange:NSMakeRange(startIndex, range.location)];
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
    
    //遍历运算符的数组(先考虑两个数字的运算)
    Operator *op = [[Operator alloc] initWithOptStr:self.opts.firstObject];
    
    self.inputTextField.text = [NSString stringWithFormat:@"%f",[op calculateWithValue:[self.nums[0] floatValue] value2:[self.nums[1] floatValue]]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
