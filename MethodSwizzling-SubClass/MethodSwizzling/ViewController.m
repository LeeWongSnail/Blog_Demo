//
//  ViewController.m
//  MethodSwizzling
//
//  Created by LeeWong on 2021/6/13.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Person *person = [[Person alloc] init];
    [person walk];
    Student *std = [[Student alloc] init];
    [std study];
    [person jump];
    
    
}


@end
