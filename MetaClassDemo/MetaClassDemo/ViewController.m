//
//  ViewController.m
//  MetaClassDemo
//
//  Created by LeeWong on 2021/1/1.
//

#import "ViewController.h"
#import "Female.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self instanceTest];
}


- (void)instanceTest {
    Female *f = [Female new];
    
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass([f class]),NSStringFromClass([Person class]),@([f isKindOfClass:[Person class]]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass([f class]),NSStringFromClass([Person class]),@([f isMemberOfClass:[Person class]]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass([f class]),NSStringFromClass([Female class]),@([f isMemberOfClass:[Female class]]));

}


- (void)classMethodJudge {
    Class ccls = [NSObject class];
    Class icls =  [Person class];
    
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isKindOfClass:ccls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isKindOfClass:icls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isKindOfClass:ccls]));
    
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isMemberOfClass:ccls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isMemberOfClass:icls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isMemberOfClass:ccls]));

}

- (void)classMethodJudge2 {
    Class ccls = [NSObject class];
    Class icls =  [Person class];
    Class scls =  [Female class];
    
    [[Female new] isKindOfClass:[Person new]];
    
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isKindOfClass:ccls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isKindOfClass:icls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isKindOfClass:ccls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(scls),NSStringFromClass(icls),@([scls isKindOfClass:icls]));
    
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isMemberOfClass:ccls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isMemberOfClass:icls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isMemberOfClass:ccls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(scls),NSStringFromClass(icls),@([scls isMemberOfClass:icls]));

}

- (void)instanceMethodJudge {
    Class ccls = [[NSObject new] class];
    Class icls =  [[Person new] class];
    
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isKindOfClass:ccls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isKindOfClass:icls]));
    NSLog(@"%@ isKindOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isKindOfClass:ccls]));
    
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(ccls),NSStringFromClass(ccls),@([ccls isMemberOfClass:ccls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(icls),@([icls isMemberOfClass:icls]));
    NSLog(@"%@ isMemberOfClass %@  result %@", NSStringFromClass(icls),NSStringFromClass(ccls),@([icls isMemberOfClass:ccls]));

}


@end
