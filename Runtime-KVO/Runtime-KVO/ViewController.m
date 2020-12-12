//
//  ViewController.m
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/6.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonArray.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) Person *man;
@property (nonatomic, strong) PersonArray *personArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.man = [[Person alloc] init];
    [self arrayKVO];
}

- (void)arrayKVO {
    self.personArray = [@[@"1"] mutableCopy];
    [self.personArray addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"aaa"];
    [self.personArray addObject:@"2"];
}

- (void)kvoClassChange {
//    [self printClassInfo];
    [self addKVO];
    [self printKVOClassChain];
//    [self removeKVO];
//    [self printClassInfo];
}

- (void)printKVOClassChain {
    NSLog(@"---------------------------------");
    Class cls = object_getClass(self.man);
    while (cls) {
        NSLog(@"claas %@ 's supercls %@",cls,class_getSuperclass(cls));
        cls = class_getSuperclass(cls);
    }

    NSLog(@"---------------------------------");
}

- (void)printClassInfo {
    NSLog(@"---------------------------------");
//    NSLog(@"class %@",NSStringFromClass([self.man class]));
    Class cls = object_getClass(self.man);
    NSLog(@"isa class %@",cls);
//    NSLog(@"isa class supercls %@",class_getSuperclass(cls));
    NSLog(@"---------------------------class method list ");
    NSUInteger methodCount = 0;
    Method * methodList = class_copyMethodList(object_getClass(self.man), &methodCount);
    for(NSUInteger i = 0; i < methodCount; i++) {
        NSLog(@"%@",NSStringFromSelector(method_getName(methodList[i])));
    }


}

- (void)addKVO {
    [self.man addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"self"];
}

- (void)removeKVO {
    [self.man removeObserver:self forKeyPath:@"name"];
}

- (void)addKVOCrashTest {
    Person *person = [Person new];
    Person *person2 = [Person new];
    [person2 addObserver:person forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"person"];
    person2.name = @"LeeWong";
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    self.man.name = @"LeeWong";

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"name"]) {
        NSLog(@"keyPath %@ object %@ change%@ context %@",keyPath,object,change,context);
    }
}

@end
