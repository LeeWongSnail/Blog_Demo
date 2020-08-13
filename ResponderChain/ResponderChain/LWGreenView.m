//
//  LWGreenView.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "LWGreenView.h"
#import "LWPurpleView.h"
#import "UIResponder+LW.h"
#import "LWCyanView.h"

@implementation LWGreenView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)buildUI {
    LWPurpleView *greenView = [[LWPurpleView alloc] initWithFrame:CGRectMake(25, 10, 250, 80)];
    [self addSubview:greenView];

    LWCyanView *cyanView = [[LWCyanView alloc] initWithFrame:CGRectMake(25, 110, 250, 80)];
    [self addSubview:cyanView];
}

@end
