//
//  ViewController.m
//  GetFileFromFolder
//
//  Created by LeeWong on 2020/10/13.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    NSString *path = @"/Users/leewong/Downloads/internationbabay/image2";
    [self showAllFileWithPath:[NSURL fileURLWithPath:path].path];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)showAllFileWithPath:(NSString *) path {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSError *error;
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:&error];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self showAllFileWithPath:subPath];
            }
        }else{
            NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
            NSLog(@"%@",fileName);
        }
    }else{
        NSLog(@"this path is not exist!");
    }
}


@end
