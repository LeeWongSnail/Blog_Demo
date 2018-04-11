# YYModel 源码解析

## YYModel 类结构

![YYModel类](http://og0h689k8.bkt.clouddn.com/18-4-11/38434041.jpg)


## YYModel 字典转模型过程

![字典转模型过程](http://og0h689k8.bkt.clouddn.com/18-4-11/66856717.jpg)

## 读写安全

YYModel中也用到了一些全局的缓存,如何保证每次对这个缓存的写操作或者取操作的安全性？

```objc
    static CFMutableDictionaryRef classCache;
    static CFMutableDictionaryRef metaCache;
```

信号量

看下面这段代码

```objc
 //这个方法每个类只会走一次
    dispatch_once(&onceToken, ^{
        classCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        metaCache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    
    //这里也是采用信号量的机制来保证操作的安全
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    //class_isMetaClass 判断是否是元类 从缓存中获取classInfo
    YYClassInfo *info = CFDictionaryGetValue(class_isMetaClass(cls) ? metaCache : classCache, (__bridge const void *)(cls));
    //如果渠道信息 且信息需要更新 那么更新信息
    if (info && info->_needUpdate) {
        [info _update];
    }
    dispatch_semaphore_signal(lock);
    
    // 如果缓存中没有类的信息 那么新建
    if (!info) {
        info = [[YYClassInfo alloc] initWithClass:cls];
        if (info) {
            //这里也是利用信号量来保证写操作的安全
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(info.isMeta ? metaCache : classCache, (__bridge const void *)(cls), (__bridge const void *)(info));
            dispatch_semaphore_signal(lock);
        }
    }
```


## 运行时方法

方法 | 作用
------------ | -------------
class_getSuperclass | 获取父类 
class_isMetaClass   | 是否为元类
objc_getMetaClass  | 获取元类
objc_getClass | 获取对象的类
class_copyPropertyList | 获取类的属性列表
class_copyIvarList | 获取实例变量的列表
class_copyMethodList | 获取方法列表
method_getName | 获取方法名
method_getImplementation | 获取方法实现
sel_getName | 获取方法名称
method_getTypeEncoding | 获取方法编码方式
method_copyReturnType | 获取方法返回值的类型
method_getNumberOfArguments | 获取方法参数个数
method_copyArgumentType(method, i) | 获取方法的第几个参数
property_getName | 获取属性名称
property_copyAttributeList | 获取属性的详细信息(下面详解)
objc_msgSend(target,selector,argus) | 调用方法


## property_copyAttributeList


