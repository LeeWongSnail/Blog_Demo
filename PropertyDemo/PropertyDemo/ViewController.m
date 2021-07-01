//
//  ViewController.m
//  PropertyDemo
//
//  Created by LeeWong on 2021/5/31.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *name;
@end


@implementation ViewController

//@synthesize name = _MyName;
@synthesize name;
//@dynamic name;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    name = @"LeeWong";
//    Person *p = [Person new];
    NSLog(@"%@",self.name);
//    extern NSString * ULAPIManagerPasswordErrorNotification;
//    NSLog(@"------------------- %@",ULAPIManagerPasswordErrorNotification);
//    personDemo();
    
}


@end
