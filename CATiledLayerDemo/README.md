
## 普通方式

```objc
self.imageView = [[UIImageView alloc] initWithImage:self.largeImage];
self.imageView.contentMode = UIViewContentModeScaleAspectFit;
[self.view addSubview:self.imageView];
self.imageView.frame = self.view.bounds;
```

![](http://og0h689k8.bkt.clouddn.com/18-5-22/13951255.jpg)

## 使用TileLayer


```objc
self.imageScrollView = [[LeeImageScrollView alloc] initWithFrame:self.view.bounds
                                                               image:self.largeImage];
    
[self.view addSubview:self.imageScrollView];
```

![](http://og0h689k8.bkt.clouddn.com/18-5-22/48524456.jpg)



