# FMDB


## 数据库的创建

```objc
NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"demo.sqlite"];
    self.db = [FMDatabase databaseWithPath:dbpath];
```

其实,可以直接使用

```
self.queue = [FMDatabaseQueue initWithPath:dbpath flags:0 vfs:nil];
```

内部自先创建一个全局的db实例 然后在去创建对应的queue

## 读写的线程安全

```objc
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
```


`- (void)inDatabase:(void (^)(FMDatabase *db))block`这个方法做了什么呢？
为什么将操作放到这个block中就可以保证线程安全呢？

下面看一下这个方法都做了什么

```objc
- (void)inDatabase:(void (^)(FMDatabase *db))block {
#ifndef NDEBUG
    /* Get the currently executing queue (which should probably be nil, but in theory could be another DB queue
     * and then check it against self to make sure we're not about to deadlock. */
    //获取指定的串行队列
    FMDatabaseQueue *currentSyncQueue = (__bridge id)dispatch_get_specific(kDispatchQueueSpecificKey);
    //判断当前是否在自定的队列中 如果不是那么断言触发提示
    assert(currentSyncQueue != self && "inDatabase: was called reentrantly on the same queue, which would lead to a deadlock");
#endif
    //ARC下忽略这个
    FMDBRetain(self);
    
    //在这个串行队列中 同步的去执行block中的内容
    dispatch_sync(_queue, ^() {
        
        FMDatabase *db = [self database];
        
        block(db);
        //判断当前是否有已经打开的结果集 
        if ([db hasOpenResultSets]) {
            NSLog(@"Warning: there is at least one open result set around after performing [FMDatabaseQueue inDatabase:]");
            
#if defined(DEBUG) && DEBUG
            NSSet *openSetCopy = FMDBReturnAutoreleased([[db valueForKey:@"_openResultSets"] copy]);
            for (NSValue *rsInWrappedInATastyValueMeal in openSetCopy) {
                FMResultSet *rs = (FMResultSet *)[rsInWrappedInATastyValueMeal pointerValue];
                NSLog(@"query: '%@'", [rs query]);
            }
#endif
        }
    });
    
    FMDBRelease(self);
}
```

由此可以看出 这个方法之所以可以实现 线程的安全 是因为他将所有的block操作都放到了一个`串行队列中同步执行`。这就意味着 这个队列中的所有的操作都必须`一个挨着一个`的执行 且`不可以开其他的线程`。

## 事务的使用

### 定义

数据库事务(Database Transaction) ，是指作为单个逻辑工作单元执行的一系列操作，要么完全地执行，要么完全地不执行。 事务处理可以确保除非事务性单元内的所有操作都成功完成，否则不会永久更新面向数据的资源。通过将一组相关操作组合为一个要么全部成功要么全部失败的单元，可以简化错误恢复并使应用程序更加可靠。一个逻辑工作单元要成为事务，必须满足所谓的ACID（原子性、一致性、隔离性和持久性）属性。事务是数据库运行中的逻辑工作单位，由DBMS中的事务管理子系统负责事务的处理。

### 操作

```objc
- (void)insertContentWithTransation
{
    // 可以直接通过inTransaction 表示下列操作为事务操作 
    // 也可以手动添加 begin transaction 和 commit transaction 的方式
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
```

看一下 inTransaction 这个方法的内部实现

```objc
- (void)beginTransaction:(FMDBTransaction)transaction withBlock:(void (^)(FMDatabase *db, BOOL *rollback))block {
    FMDBRetain(self);
    dispatch_sync(_queue, ^() { 
        
        BOOL shouldRollback = NO;
        //这里根据transaction的类型 执行了对应的beginTransaction
        switch (transaction) {
            case FMDBTransactionExclusive:
                [[self database] beginTransaction];
                break;
            case FMDBTransactionDeferred:
                [[self database] beginDeferredTransaction];
                break;
            case FMDBTransactionImmediate:
                [[self database] beginImmediateTransaction];
                break;
        }
        
        //执行block中的内容 如果需要回滚需要外部设置shouldRollback变量的值
        block([self database], &shouldRollback);
        
        //是否需要回滚 
        if (shouldRollback) {
            [[self database] rollback];
        }
        else {
            [[self database] commit];
        }
    });
    
    FMDBRelease(self);
}
```

## 增 删 改 查

### 增

```objc
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
```

### 删

```objc
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
```

### 改

```objc
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
```

### 查

```objc
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
```


