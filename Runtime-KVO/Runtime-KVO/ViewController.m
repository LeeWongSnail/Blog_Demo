//
//  ViewController.m
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/6.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, strong) Person *man;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.man = [[Person alloc] init];
    [self addKVO];
}

- (void)addKVO {
    [self.man addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"self"];
}

- (void)addKVOCrashTest {
    Person *person = [Person new];
    Person *person2 = [Person new];
    [person2 addObserver:person forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"person"];
    person2.name = @"LeeWong";
}

- (void)removeKVO {
    [self.man removeObserver:self forKeyPath:@"name"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.man.name = @"LeeWong";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual:@"name"]) {
        NSLog(@"keyPath %@ object %@ change%@ context %@",keyPath,object,change,context);
    }
}

@end
