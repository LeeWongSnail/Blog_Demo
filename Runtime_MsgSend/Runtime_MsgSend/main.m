//
//  main.m
//  Runtime_MsgSend
//
//  Created by LeeWong on 2020/10/31.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


int gototest(void)
{
    int arr[10]={8, 1, 6, 7, 5, 0, 3, 2, 4, 9};
    int i, j, temp, count = 0;

//    goto out;
    //goto out2;

out1:
    for(i = 0; i<9; i++)  //控制排序的趟数
    {
        for(j=0; j<9-i; j++)
        {
            if(arr[j] > arr[j+1])  //控制相比较的数
            {
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }

    }
    for(i = 0; i<10; i++)
    {
        printf("%d ",arr[i]);
    }
    printf("\n");

    count++;
    if (count == 10) {
        //break;
        printf("\n  111111");
        return 0;
    }
    goto out1;

out:
    printf("out\n");
    //return 0;
out2:
    printf("out2\n");
    return 0;
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    gototest();
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

