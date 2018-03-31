//
//  ViewController.m
//  ProtobufDemo
//
//  Created by LeeWong on 2018/3/30.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "ViewController.h"
#import "ProtobufChatmessage.pbobjc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ChatMessage *message = [[ChatMessage alloc] init];
    message.title = @"Lee";
    message.body = @"Hom";
    
    NSData *data = [message data];
    
    
    NSError *error = nil;
    ChatMessage *msg = [ChatMessage parseFromData:data error:&error];
    if (error) {
        NSLog(@"parseData Error %@",error.localizedDescription);
    } else {
        NSLog(@"parseData Success");
        NSLog(@"ChatMessage:title=%@ body=%@",msg.title,msg.body);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
