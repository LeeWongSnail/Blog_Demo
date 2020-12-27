//
//  Father.m
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "Father.h"

@interface Father ()
@end

@implementation Father

- (instancetype)init {
    if (self = [super init]) {
        _children = [NSMutableArray array];
        [self addObserver];
    }
    return self;
}

- (void)addObserver {
    [self addObserver:self forKeyPath:@"children" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)removeObserver {
    [self removeObserver:self forKeyPath:@"children"];
}

- (void)dealloc {
    [self removeObserver];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"children"]) {
        NSLog(@"%@",change);
    }
}

- (void)willChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super willChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"willChange: valuesAtIndexes: forKey:%@",key);
}

- (void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super didChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"didChange: valuesAtIndexes: forKey:%@",key);
}

#pragma mark -

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index {
    NSLog(@"removeObjectFromChildrenAtIndex %@",@(index));
    [self.children removeObjectAtIndex:index];
}

- (void)insertObject:(NSString *)object inChildrenAtIndex:(NSUInteger)index {
    NSLog(@"insertObject: %@inChildrenAtIndex: %@",object,@(index));
    [self.children insertObject:object atIndex:index];
}

- (void)setChildren:(NSMutableArray *)children {
    _children = children;
    NSLog(@"setChildren %@",@(children.count));
}
//
//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
//}

@end
