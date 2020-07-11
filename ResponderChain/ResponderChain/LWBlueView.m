//
//  LWBlueView.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "LWBlueView.h"
#import "LWBlackView.h"
#import "LWGreenView.h"

@implementation LWBlueView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


- (void)buildUI {
    LWGreenView *greenView = [[LWGreenView alloc] initWithFrame:CGRectMake(25, 50, 300, 200)];
    [self addSubview:greenView];

    LWBlackView *blackView = [[LWBlackView alloc] initWithFrame:CGRectMake(25, 260, 300, 20)];
    [self addSubview:blackView];
}
@end
