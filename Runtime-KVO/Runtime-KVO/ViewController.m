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
#import "Student.h"

@interface ViewController ()
@property (nonatomic, strong) Person *man;
@property (nonatomic, strong) PersonArray *personArray;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy, readonly) NSString *roProperty;


@property (nonatomic, strong) Student *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = [NSMutableArray array];
    self.man = [[Person alloc] initWithChildren:self.array];
    self.stu = [Student new];
    [self addReadOnlyProperty];
    [self.stu modifyClassName:@"Class Two"];
}

#pragma mark - readOnly
- (void)addReadOnlyProperty {
    [self addObserver:self forKeyPath:@"roProperty" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark Array
- (void)observeReadOnlyProperty {
    [self.stu addObserver:self forKeyPath:@"className" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
- (void)observeArraCountDirectly {
    [self.array addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)keyValueChangeKindKey {
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:nil];
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}




#pragma mark - KVO

- (void)printKVOObserverInfo {
    [self.man addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@""];
    [self.man addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@""];
    id info = self.man.observationInfo;
    NSLog(@"%@", [info description]);
}

- (void)addPersonNameKVO {
    [self.man addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@""];
    self.man.name = @"LeeWong";
}

- (void)addPersonInfoDescrption {
    [self.man addObserver:self forKeyPath:@"personDescription" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@""];
    self.man.name = @"LeeWong";
    self.man.age = 30;
}

- (void)arrayKVO {
    self.personArray = [@[@"1"] mutableCopy];
    [self addObserver:self forKeyPath:@"personArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"aaa"];
    [self.personArray addObject:@"2"];
}

- (void)personChildrenKVO {
    NSLog(@"111children class %@ object %p",object_getClass(self.man),self.man);
    [self.man addObserver:self forKeyPath:@"children" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"aaa"];
    NSLog(@"222children class %@ object %p",object_getClass(self.man),self.man);
    [self.man insertObject:@"111" inChildrenAtIndex:0];
    NSLog(@"333children class %@ object %p",object_getClass(self.man),self.man);
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
    NSLog(@"observeValueForKeyPath for keyPath %@",keyPath);
    if ([keyPath isEqual:@"name"]) {
        NSLog(@"keyPath %@ object %@ change%@ context %@",keyPath,object,change,context);
    }
}



@end
