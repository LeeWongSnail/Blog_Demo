//
//  Person.m
//  ObjectStructure
//
//  Created by LeeWong on 2021/1/2.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        _name = @"LeeWong";
        _age = 20;
        _house = [House new];
        _experiences =@[@"Sina",@"Art"];
    }
    return self;
}


- (NSString *)personDescription {
    return [NSString stringWithFormat:@"self = %p name = %p , age = %p house = %p experience = %p",self,&(_name),&(_age),&(_house),&(_experiences)];
}

@end
