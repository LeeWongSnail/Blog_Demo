//
//  Student.m
//  Runtime-KVO
//
//  Created by LeeWong on 2021/6/13.
//

#import "Student.h"

@interface Student ()
@property (nonatomic, copy) NSString *aaaaa;
@end

@implementation Student

- (void)modifyClassName:(NSString *)name {
    self.aaaaa = name;
}

@end
