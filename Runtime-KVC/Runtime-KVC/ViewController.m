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
@property (nonatomic, strong) Son *son;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self advanceKVCDistinctMethod];
}

- (void)advanceKVCDistinctMethod {
    Person *p1 = [Person new];
    p1.age = 10;

    Person *p2 = [Person new];
    p2.age = 20;

    Person *p3 = [Person new];
    p3.age = 20;

    Person *p4 = [Person new];
    p4.age = 30;

    NSArray *pArray = @[p1,p2,p3,p4];

    NSArray *distinctUnionOfObjectsArray=[pArray valueForKeyPath:@"@distinctUnionOfObjects.age"];
    NSLog(@"distinctUnionOfObjects:%@",distinctUnionOfObjectsArray);

    NSArray *unionOfObjectsArray=[pArray valueForKeyPath:@"@unionOfObjects.age"];
    NSLog(@"unionOfObjects:%@",unionOfObjectsArray);
}

- (void)advanceKVCMethod {
    Person *p1 = [Person new];
    p1.age = 10;

    Person *p2 = [Person new];
    p2.age = 20;

    Person *p3 = [Person new];
    p3.age = 20;

    Person *p4 = [Person new];
    p4.age = 30;

    NSArray *pArray = @[p1,p2,p3,p4];

    NSNumber *ageSum = [pArray valueForKeyPath:@"@sum.age"];
    NSLog(@"年龄的总和为 %@",ageSum);

    NSNumber *average = [pArray valueForKeyPath:@"@avg.age"];
    NSLog(@"年龄的平均值为 %@",average);

    NSNumber *count = [pArray valueForKeyPath:@"@count"];
    NSLog(@"年龄的个数 %@",count);

    NSNumber *max = [pArray valueForKeyPath:@"@max.age"];
    NSLog(@"年龄最大的为 %@",max);

    NSNumber *min = [pArray valueForKeyPath:@"@min.age"];
    NSLog(@"年龄最小的为 %@",min);
}

#pragma mark -

- (void)mutableArrayValueForKey {
    self.father = [Father new];
//    [self.father.children addObject:@"son1"];
//    NSLog(@"befor ---- children = %p  children class %@",self.father.children,[self.father.children class]);
    id arrM = [self.father mutableArrayValueForKey:@"children"];
    NSLog(@"%p,%@",arrM,[arrM class]);
    
    [[self.father mutableArrayValueForKey:@"children"] addObject:@"farmer"];
    NSLog(@"%p",[self.father methodForSelector:@selector(addObject:)]);
    NSLog(@"%p",[self.father methodForSelector:@selector(insertObject:atIndex:)]);
//    NSLog(@"after ---- children = %p  children class %@",self.father.children,[self.father.children class]);
//    [[self.father mutableArrayValueForKey:@"children"] addObject:@"air"];
//    NSLog(@"after ---- children = %p  children class %@",self.father.children,[self.father.children class]);
}

#pragma mark valueForKey:

- (void)valueForKeyTestStep1 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep1 result %@ result class %@",result,[result class]);
}

- (void)valueForKeyTestStep2 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep2 result %@ result class %@",result,[result class]);
}

- (void)valueForKeyTestStep3 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep3 result %@ result class %@",result,[result class]);
}

- (void)valueForKeyTestStep4 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep4 result %@ result class %@",result,[result class]);
}

- (void)valueForKeyTestStep5 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep5 result %@ result class %@",result,[result class]);
}

- (void)valueForKeyTestStep6 {
    self.son = [Son new];
    id result = [self.son valueForKey:@"school"];
    NSLog(@"valueForKeyTestStep6 result %@ result class %@",result,[result class]);
}


#pragma mark - SetValue:forKey
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
//    self.father.children = @[son1,son2];

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
