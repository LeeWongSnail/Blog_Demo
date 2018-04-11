//
//  User.m
//  YYModel_Note
//
//  Created by LeeWong on 2018/4/10.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "User.h"
#import "YYModel.h"

@implementation User

//modelCustomClassForDictionary

+ (nullable Class)modelCustomClassForDictionary:(NSDictionary *)dictionary
{
    return [LeeUser class];
}

@end


@implementation LeeUser

@end
