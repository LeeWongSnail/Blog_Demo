//
//  ViewController.m
//  ObjectStructure
//
//  Created by LeeWong on 2021/1/2.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *p = [Person new];
    Person *p1 = [Person new];
    
    NSLog(@"%@",[p personDescription]);
    
}


@end
