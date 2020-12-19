//
//  Person.m
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "Person.h"

@interface Person ()
//{
//    NSString *_isName1;
//    NSInteger _isAge1;
//
//}

@end

@implementation Person

//@synthesize name = _name;


- (void)setName:(NSString *)name {
    _name = name;
    NSLog(@"Person setName %@",name);
}
//
//- (NSString *)name {
//    NSLog(@"Person getname %@",_name);
//    return _name;
//}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"Father setNilValueForKey %@",key);
}

//+ (BOOL)accessInstanceVariablesDirectly {
//    NSLog(@"Father accessInstanceVariablesDirectly");
//    return YES;
//}

//- (NSString *)getisNameValue {
//    return _isName1;
//}
//
//- (NSInteger)getisAgeValue {
//    return _isAge1;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"Person setValue %@ forUndefinedKey %@",value,key);
}

@end
