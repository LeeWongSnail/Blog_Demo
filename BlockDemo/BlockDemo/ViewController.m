//
//  ViewController.m
//  BlockDemo
//
//  Created by LeeWong on 2021/6/7.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *currentName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableString *strM = [[NSMutableString alloc] initWithString:@"Lee"];
    self.currentName = [strM copy];
    [self stackBlock];
}

#pragma mark - block type

- (void)stackBlock {
    int a = 1;
    NSLog(@"%@",^{
        NSLog(@"调用block%d",a);}
    );
}

#pragma mark - __block 的使用
- (void)modifyProperty {
    NSLog(@"%p",self.currentName);
    void (^myBlock)(void) = ^(void){
        self.currentName = @"LeeWong";
    };
    myBlock();
    NSLog(@"%p",self.currentName);
}

- (void)modifyObjectProperty {
    NSMutableString *strM = [[NSMutableString alloc] initWithString:@"aaa"];
    Person *p = [Person new];
    p.name = @"Lee";
    NSLog(@"1------------strM %@ strM address %p  p.name %@  p address %p",strM,strM,p.name,p);
    void (^myBlock)(void) = ^(void){
        [strM appendString:@"bbb"];
        p.name = @"LeeWong";
        NSLog(@"2------------strM %@ strM address %p p.name %@ p address %p",strM,strM,p.name,p);
    };
    myBlock();
    NSLog(@"3------------strM %@ strM address %p  p.name %@ p address %p",strM,strM,p.name,p);

}

- (void)modifyVarible {
    __block NSString *string = @"ccccccc";
    NSLog(@"%@---%p",string,string);
    void (^myBlock)(void) = ^(void){
        string = @"ddddd";
        NSLog(@"%@---%p",string,string);
    };
    myBlock();
    NSLog(@"%@---%p",string,string);
}

- (void)pureUse {
    NSString *string = @"ccccccc";
    NSLog(@"%@---%p",string,string);
    void (^myBlock)(void) = ^(void){
        NSLog(@"%@---%p",string,string);
    };
    myBlock();
    NSLog(@"%@---%p",string,string);
}


@end
