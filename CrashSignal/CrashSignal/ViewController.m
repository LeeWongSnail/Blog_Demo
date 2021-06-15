//
//  ViewController.m
//  CrashSignal
//
//  Created by LeeWong on 2021/6/15.
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
    [p speak];
}

@end
