//
//  PersonArray.m
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/12.
//

#import "PersonArray.h"

@implementation PersonArray

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"PersonArray willChangeValueForKey:");
}

- (void)willChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super willChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"PersonArray willChange:valuesAtIndexes:forKey:");
}

- (void)willChangeValueForKey:(NSString *)key withSetMutation:(NSKeyValueSetMutationKind)mutationKind usingObjects:(NSSet *)objects {
    [super willChangeValueForKey:key withSetMutation:mutationKind usingObjects:objects];
    NSLog(@"PersonArray willChangeValueForKey:withSetMutation:usingObjects:");
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"PersonArray didChangeValueForKey:");
}

- (void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key {
    [super didChange:changeKind valuesAtIndexes:indexes forKey:key];
    NSLog(@"PersonArray didChange:valuesAtIndexes:forKey:");
}

- (void)didChangeValueForKey:(NSString *)key withSetMutation:(NSKeyValueSetMutationKind)mutationKind usingObjects:(NSSet *)objects {
    [super didChangeValueForKey:key withSetMutation:mutationKind usingObjects:objects];
    NSLog(@"PersonArray didChangeValueForKey:withSetMutation:usingObjects:");
}

@end
