//
//  ViewController.m
//  NormalCrash
//
//  Created by LeeWong on 2021/6/17.
//

#import "ViewController.h"
#import "Person.h"

typedef void(^BlockExecDemoBlock)(void);

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) BlockExecDemoBlock block;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [NSMutableArray array];
    [self blockExec];
}


- (void)blockExec {
    self.block();
}

- (void)setValueOrSetObject {
//    NSDictionary *dict = [NSDictionary dictionary];
//    [dict setValue:nil forKey:@"aaa"];
    
//    Person *p = [Person new];
//    p.name = @"LeeWong";
//    NSLog(@"before %@",p.name);
//    [p setValue:nil forKey:@"name"];
//    NSLog(@"after %@",p.name);
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:nil forKey:@"aaa"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self enumerateWhieModify];
}

- (void)enumerateWhieModify {
    for (NSInteger index = 0; index < 10; index++) {
        [self.array addObject:@(index)];
    }
//    for (NSInteger index = 0; index < 3; index++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self.array removeObjectAtIndex:index];
//        });
//    }
    
//    for (NSInteger index = 0; index < self.array.count; index++) {
//        NSLog(@"%@",self.array[index]);
//        [self.array addObject:@"aa"];
//    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL delete = NO;
        for (id obj in [self.array copy]) {
            NSLog(@"%@",obj);
            if (delete) {
                [self.array removeObject:obj];
            }
            delete = !delete;
        }
    });
    
//    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@",obj);
//        [self.array addObject:@"aa"];
//    }];
    
    
}

- (void)mutiThreadModify {
    for (NSInteger index = 0; index < 10; index++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.array addObject:@(index)];
        });
    }
    
    for (NSInteger index = 0; index < 10; index++) {
        NSLog(@"--------");
        [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@",obj);
        }];
    }
}



@end
