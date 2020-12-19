//
//  ViewController.m
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "ViewController.h"
#import "Person.h"
#import "Father.h"
#import "Son.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) Person *p;
@property (nonatomic, strong) Father *father;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setValueForUndefineKeyTest];
}


- (void)setValueForUndefineKeyTest {
    self.father = [Father new];
    [self.father setValue:@"LeeWong" forKey:@"name1"];

    [self.father setValue:@(10) forKey:@"age1"];
}

- (void)setValueForKeyTest {
    self.father = [Father new];
    [self.father setValue:@"LeeWong" forKey:@"name1"];
    NSLog(@"setValueForKeyTest getisNameValue %@",[self.father getisNameValue]);

    [self.father setValue:@(10) forKey:@"age1"];
    NSLog(@"setValueForKeyTest getisAgeValue %@",@([self.father getisAgeValue]));
}


- (void)kvoSetMethodCallTest {
    self.father = [Father new];
    [self.father setValue:@"LeeWong" forKey:@"name"];

    NSLog(@"kvoSetMethodCallTest father name %@",[self.father valueForKey:@"name"]);
}


- (void)kvoObjectClassChangeTest {
    self.father = [Father new];

    Son *son1 = [Son new];
    Son *son2 = [Son new];
    self.father.name = @"LeeWong";
    self.father.children = @[son1,son2];

    NSLog(@"Father 的children 类型是%@",[[self.father valueForKey:@"children"] class]);
    NSLog(@"Father 的children 类型是%@",object_getClass([self.father valueForKey:@"children"]));

    NSLog(@"Father 的name 类型是 %@",[[self.father valueForKey:@"name"] class]);
    NSLog(@"Father 的name 类型是 %@",object_getClass([self.father valueForKey:@"name"]));

}


- (void)kvcValueForKeyTest {
    self.p = [Person new];

    self.p.name = @"LeeWong";
    self.p.age = 30;

    NSLog(@"Person age = %@",self.p.name);
    NSLog(@"Person name = %@",@(self.p.age));
}

- (void)kvcSetValueForKey {
    self.p = [Person new];

    [self.p setValue:@"LeeWong" forKey:@"name"];
    [self.p setValue:@(30) forKey:@"age"];

    NSLog(@"Person age = %@",[self.p valueForKey:@"age"]);
    NSLog(@"Person name = %@",[self.p valueForKey:@"name"]);
}

@end
