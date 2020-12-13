//
//  Person.h
//  Runtime-KVO
//
//  Created by LeeWong on 2020/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PersonKVODelegate <NSObject>
@optional
- (void)personObjectNamePropertyChangeFrom:(NSString *)oldName newName:(NSString *)newName;

@end

@interface Person : NSObject
@property (nonatomic, weak) id <PersonKVODelegate> delegate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (NSString *)personDescription;

@property (nonatomic, strong) NSMutableArray *children;

- (instancetype)initWithChildren:(NSMutableArray *)children;

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)index;
- (void)removeChildrenAtIndexes:(NSIndexSet *)indexes;
- (void)insertObject:(id)object inChildrenAtIndex:(NSUInteger)index;
- (void)insertChildren:(NSArray *)array atIndexes:(NSIndexSet *)indexes;

- (NSUInteger)countOfChildren;

@end

NS_ASSUME_NONNULL_END
