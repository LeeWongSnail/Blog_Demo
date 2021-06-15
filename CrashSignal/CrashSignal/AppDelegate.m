//
//  AppDelegate.m
//  CrashSignal
//
//  Created by LeeWong on 2021/6/15.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static void handleSignal( int sig ) {
    NSLog(@"---");
}

/**
 一、OC异常处理函数

 @param exception exception
 */
static void uncaught_exception_handler (NSException *exception) {
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",
                               name,
                               reason,
                               stackArray];
    NSLog(@"%@", exceptionInfo);
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    [tmpArr insertObject:reason atIndex:0];
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]
                    atomically:YES
                      encoding:NSUTF8StringEncoding
                         error:nil];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSString *content = [NSString stringWithFormat:@"==异常错误报告==\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",
                         name,
                         reason,
                         [stackArray componentsJoinedByString:@"\n"]];
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:test@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *mailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
    //NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // OC层中未被捕获的异常，通过注册NSUncaughtExceptionHandler捕获异常信息
     NSSetUncaughtExceptionHandler(&uncaught_exception_handler);
     // 内存访问错误，重复释放等错误就无能为力了，因为这种错误它抛出的是Signal，所以必须要专门做Signal处理
     // OC中层不能转换的Mach异常，利用Unix标准的signal机制，注册SIGABRT, SIGBUS, SIGSEGV等信号发生时的处理函数。
     signal(SIGSEGV,handleSignal);
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
