//
//  FMDBService.h
//  FMDB_Demo
//
//  Created by LeeWong on 2018/4/12.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBService : NSObject
+ (id)shared;

//初始化数据库
- (void)initDataBase;


//创建表
- (void)createTable;

//插入数据
- (void)insertContent;

//查询数据
- (void)queryContent;

//更新数据
- (void)updateContent;

//查询数据
- (void)deleteContent;

// 事务
- (void)insertContentWithTransation;
@end
