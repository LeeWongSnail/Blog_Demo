//
//  Father.m
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "Father.h"

@interface Father ()
@property (nonatomic, strong) NSMutableDictionary *children;
@end

@implementation Father

- (instancetype)init {
    if (self = [super init]) {
        _children = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index {
    NSLog(@"removeObjectFromChildrenAtIndex %@",@(index));
    [self.children setValue:nil forKey:@(index).stringValue];
}

- (void)insertObject:(NSString *)object inChildrenAtIndex:(NSUInteger)index {
    NSLog(@"insertObject: %@inChildrenAtIndex: %@",object,@(index));
    [self.children setValue:object forKey:@(index).stringValue];
}

@end
