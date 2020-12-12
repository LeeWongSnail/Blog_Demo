//
//  Person.m
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/6.
//

#import "Person.h"

@implementation Person

//- (void)setName:(NSString *)name {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(personObjectNamePropertyChangeFrom:newName:)]) {
//        [self.delegate personObjectNamePropertyChangeFrom:_name newName:name];
//    }
//    _name = name;
//}

- (void)setName:(NSString *)name {
    [self willChangeValueForKey:name];
    _name = name;
    [self didChangeValueForKey:name];
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"Person willChangeValueForKey %@",key);
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"Person didChangeValueForKey %@",key);
}

@end
