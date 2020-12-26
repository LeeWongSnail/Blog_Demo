//
//  Son.m
//  Runtime-KVC
//
//  Created by LeeWong on 2020/12/19.
//

#import "Son.h"

@interface Son () {
//    NSString *_isSchool;
}


@end

@implementation Son

#pragma mark - valueForKey
// 优先级由高到低
//- (NSString *)getSchool {
//    return @"Beijiing";
//}
//
//- (NSString *)school {
//    return @"Shanghai";
//}
//
//- (NSString *)isSchool {
//    return @"HongKong";
//}
//

#pragma mark - NSKeyValueOrderedSet

//- (NSInteger)countOfSchool {
//    NSLog(@"countOfSchool");
//    return 2;
//}
//
//- (NSInteger)indexInSchoolOfObject:(NSString *)school {
//    NSLog(@"indexInSchoolOfObject %@",school);
//    return 1;
//}
//
//- (NSString *)objectInSchoolAtIndex:(NSInteger)index {
//    NSLog(@"objectInSchoolAtIndex %@",@(index));
//    if (index % 2 == 0) {
//        return @"Beijing";
//    } else {
//        return @"HongKong";
//    }
//}

#pragma mark - NSKeyValueOrderedSet

//-countOf<Key> and -objectIn<Key>AtIndex:

//- (NSInteger)countOfSchool {
//    NSLog(@"countOfSchool");
//    return 3;
//}
//
//- (NSString *)objectInSchoolAtIndex:(NSInteger)index {
//    NSLog(@"objectInSchoolAtIndex %@",@(index));
//    if (index % 2 == 0) {
//        return @"Beijing";
//    } else {
//        return @"HongKong";
//    }
//}

#pragma mark - NSKeyValueSet

//-countOf<Key>, -enumeratorOf<Key>, and -memberOf<Key>:

//- (NSInteger)countOfSchool {
//    NSLog(@"countOfSchool");
//    return 2;
//}
//
//- (NSEnumerator<id> *)enumeratorOfSchool {
//    NSLog(@"objectInSchoolAtIndex ");
//    NSSet *schools = [NSSet setWithArray:@[@"Beijing",@"Hongkong"]];
//    return [schools objectEnumerator];
//}
//
//- (void)memberOfSchool:(NSString *)school {
//    NSLog(@"memberOfSchool %@",school);
////    return YES;
//}

#pragma mark - 查找实例变量

//- (instancetype)init {
//    if (self = [super init]) {
//        _isSchool = @"Beijing";
//    }
//    return self;
//}
//
//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
//}

#pragma mark -

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"valueForUndefinedKey %@",key);
    return @"Beijing";
}

@end
