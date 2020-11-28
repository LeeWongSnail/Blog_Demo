//
//  ViewController.m
//  ObjectLifeTime
//
//  Created by LeeWong on 2020/11/28.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *str = [[NSString alloc] init];

    NSString *str = [NSString new];

    NSMutableString *str = [NSMutableString string];

    
}


@end
