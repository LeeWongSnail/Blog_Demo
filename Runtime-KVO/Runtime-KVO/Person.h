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
@end

NS_ASSUME_NONNULL_END
