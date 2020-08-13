//
//  LWPurpleView.m
//  ResponderChain
//
//  Created by LeeWong on 2020/7/11.
//  Copyright © 2020 LeeWong. All rights reserved.
//

#import "LWPurpleView.h"
#import "UIResponder+LW.h"
#import "LWButton.h"

@implementation LWPurpleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}


- (void)buildUI {
    LWButton *button = [LWButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"点击测试事件传递" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 15, 150, 50);
    [self addSubview:button];

    NSURL *url = [NSURL URLWithString:@"A://B/C?id=1"];
    NSLog(@"%@",[url pathComponents].firstObject);

    [button addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonDidClick {
    [self routerEventWithName:@":LWButton DidClick" userInfo:@{@"test":@"test"}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSLog(@"event name %@  info%@",eventName,userInfo);
}

@end
