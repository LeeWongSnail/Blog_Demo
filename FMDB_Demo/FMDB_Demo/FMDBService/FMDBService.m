//
//  FMDBService.m
//  FMDB_Demo
//
//  Created by LeeWong on 2018/4/12.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "FMDBService.h"
#import "FMDB.h"

@interface FMDBService()
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation FMDBService

+ (id)shared
{
    static FMDBService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - DB相关的操作
//初始化数据库相关的内容
- (void)initDataBase
{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"demo.sqlite"];
    self.db = [FMDatabase databaseWithPath:dbpath];
    
    // 创建，最好放在一个单例的类中
    self.queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
}

- (BOOL)openDatabase
{
   return [self.db open];
}


- (BOOL)closeDatabase
{
    return [self.db close];
}

# pragma mark - Table相关操作
//创建表
- (void)createTable{
    if ([self.db open]) {
        NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer)";
        
        BOOL res = [self.db executeStatements:sqlCreateTable];
        if (!res) {
            NSLog(@"建表失败！");
        } else {
            NSLog(@"建表成功！");
        }
        [self.db close];
    }
}

//插入数据
- (void)insertContent
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       BOOL suc = [db executeUpdate:@"INSERT INTO t_user(name,age) VALUES (?,?)", @"Jack",@(20)]
       && [db executeUpdate:@"INSERT INTO t_user1(name,age) VALUES (?,?)", @"Rose",@(19)]
       && [db executeUpdate:@"INSERT INTO t_user(name,age) VALUES (?,?)", @"Jim",@(18)];
        
        if (suc) {
            NSLog(@"成功");
        } else {
            NSLog(@"失败");
        }
    }];
}


- (void)insertContentWithTransation
{
    [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        @try {
            [db executeUpdate:@"INSERT INTO t_user(name,age) VALUES (?,?)", @"Jack",@(20)];
            [db executeUpdate:@"INSERT INTO t_user(name,age) VALUES (?,?)", @"Rose",@(19)];
            [db executeUpdate:@"INSERT INTO t_user(name,age) VALUES (?,?)", @"Jim",@(18)];
        }
        @catch (NSException *e) {
            NSLog(@"%@",e);
        }
        
        @finally {
            NSLog(@"finally");
        }
        
    }];
}


//查询
- (void)queryContent
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_user"];
        while ([rs next]) {
            NSLog(@"%@",[rs objectForColumn:@"name"]);
        }
        
    }];
}

//更新数据
- (void)updateContent
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        // 开启事务
        [db executeUpdate:@"begin transaction;"];//等价于[db beginTransaction];
        
        [db executeUpdate:@"update t_user set age = ? where name = ?;", @21, @"jack"];
        [db executeUpdate:@"update t_user set age = ? where name = ?;", @25, @"Jim"];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_user"];
        while ([rs next]) {
            NSLog(@"name=%@ age=%tu",[rs objectForColumn:@"name"],[rs intForColumn:@"age"]);
        }
        
        // 提交事务
        [db executeUpdate:@"commit transaction;"];//等价于[db commit];
    }];
}

//删除
- (void)deleteContent
{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        // 开启事务
        [db executeUpdate:@"begin transaction;"];//等价于[db beginTransaction];
        
        [db executeUpdate:@"delete from t_user where name = ?",@"Jack"];
        
        FMResultSet *rs = [db executeQuery:@"select * from t_user"];
        while ([rs next]) {
            NSLog(@"name=%@ age=%tu",[rs objectForColumn:@"name"],[rs intForColumn:@"age"]);
        }
        
        // 提交事务
        [db executeUpdate:@"commit transaction;"];//等价于[db commit];
    }];
}

@end
