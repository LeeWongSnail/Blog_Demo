//
//  ViewController.m
//  isKindOfOrisMemberOf
//
//  Created by LeeWong on 2021/6/13.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // objCls 是NSObject的类
    Class objCls = [NSObject class];
    // 遍历objCls的父类看是否是NSObject类型的 因为类方法isKindOfClass是查找元类 因此 NSObject的类的元类的父类是NSObject 所以输出为1
    BOOL ret1 = [(id)objCls isKindOfClass:[NSObject class]];
    //isKindOfClass 不查询父类 直接对比NSObject 类和 NSObject的元类 返回肯定为0
    BOOL ret2 = [(id)objCls isMemberOfClass:[NSObject class]];
    NSLog(@"\nret1 = %d\nret2 = %d", ret1, ret2);
    
    //pCls是Person类
    Class pCls = [Person class];
    // pCls的元类的父类是NSObject的元类->NSOBject类 因此这里不是Person类
    BOOL ret3 = [(id)pCls isKindOfClass:[Person class]];
    // pCls元类 != Person类 0
    BOOL ret4 = [(id)pCls isMemberOfClass:[Person class]];
    NSLog(@"\nret3 = %d\nret4 = %d", ret3, ret4);
    
    // obj是NSObject的对象
    NSObject *obj = [[NSObject alloc] init];
    // 这里isKindOfClass是调用的对象方法 这里是1
    BOOL ret5 = [obj isKindOfClass:[NSObject class]];
    // isMemberOfClass 也是对象方法 返回1
    BOOL ret6 = [obj isMemberOfClass:[NSObject class]];
    NSLog(@"\nret5 = %d\nret6 = %d", ret5, ret6);
    
    //person是Person类的对象
    Person *person = [[Person alloc] init];
    // 
    BOOL ret7 = [person isKindOfClass:[Person class]];
    BOOL ret8 = [person isMemberOfClass:[Person class]];
    NSLog(@"\nret7 = %d\nret8 = %d", ret7, ret8);
}


@end
