//
//  Person.m
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/6.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithChildren:(NSMutableArray *)children {
    if (self = [super init]) {
        _children = children;
    }
    return self;
}

- (instancetype)init {
    return [self initWithChildren:[NSMutableArray array]];
}


- (NSString *)personDescription {
    return [NSString stringWithFormat:@"My name is %@,I'm %@ years old",self.name,@(self.age)];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"personDescription"]) {
        keyPaths = [keyPaths setByAddingObjectsFromArray:@[@"name",@"age"]];
    }
    return keyPaths;
}

//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    BOOL automatic = [super automaticallyNotifiesObserversForKey:key];
//    if ([key isEqualToString:@"name"]) {
//        automatic = NO;
//    }
//    return automatic;
//}

//- (void)setName:(NSString *)name {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(personObjectNamePropertyChangeFrom:newName:)]) {
//        [self.delegate personObjectNamePropertyChangeFrom:_name newName:name];
//    }
//    _name = name;
//}

//- (void)setName:(NSString *)name {
//    [self willChangeValueForKey:@"name"];
//    _name = name;
//    [self didChangeValueForKey:@"name"];
//}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"Person willChangeValueForKey %@",key);
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"Person didChangeValueForKey %@",key);
}


- (void)insertChildren:(NSArray *)array atIndexes:(NSIndexSet *)indexes {
    [self.children insertObjects:array atIndexes:indexes];
}

- (void)insertObject:(id)object inChildrenAtIndex:(NSUInteger)index {
    [self.children insertObject:object atIndex:index];
}

- (void)removeChildrenAtIndexes:(NSIndexSet *)indexes {
    [self.children removeObjectsAtIndexes:indexes];
}

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index {
    [self.children removeObjectAtIndex:index];
}

- (void)willChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super willChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"Person willChange:changeKind %@ valuesAtIndexes:indexes= %@ forKey:key = %@",@(changeKind),indexes,key);
}

- (void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super didChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"Person didChange:changeKind %@ valuesAtIndexes:indexes= %@ forKey:key = %@",@(changeKind),indexes,key);
}

- (NSUInteger)countOfChildren {
    NSLog(@"Person countOfChildren %@",@(self.children.count));
    return self.children.count;
}

@end
