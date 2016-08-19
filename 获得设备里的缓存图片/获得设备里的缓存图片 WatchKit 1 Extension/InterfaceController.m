//
//  InterfaceController.m
//  获得设备里的缓存图片 WatchKit 1 Extension
//
//  Created by Anthony on 16/8/19.
//  Copyright © 2016年 SLZeng. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *showImage;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    // iOS
    UIDevice *device = [UIDevice currentDevice];
    
    // watch OS
    WKInterfaceDevice *interfaceDevice = [WKInterfaceDevice currentDevice];
    
    // 添加缓存图片 （过程中可能会添加失败）2
    [interfaceDevice addCachedImage:[UIImage imageNamed:@"ad_00"] name:@"Zeng01"];
    [interfaceDevice addCachedImage:[UIImage imageNamed:@"ad_01"] name:@"Zeng02"];
    
    /**
     *  会先判断图片是否子啊缓存区内，如果在，直接取出来使用
     *  如果不在缓存区，就创建一个名字为 ad_00 的图片
     *  每一个watch App 的缓存区最大不超过20M
     *  如果超过了20M，那么就一次从最开始的缓存图片开始删除，用来存放新的缓存图片
     */
    [self.showImage setImageNamed:@"ad_00"];
    
    
    // 从缓存区删除缓存图片
    [interfaceDevice removeCachedImageWithName:@"zeng02"];
    
    NSLog(@"所有的缓存图片 = %@", interfaceDevice.cachedImages);
    
    /**
     *  获取屏幕的大小
     *
     *  在42mm 的手表下  屏幕大小是 : 宽:156 高: 195   312 X 390 资源图片的像素
     *  在38mm 的手表下  屏幕大小是 :  宽:  136  高: 170    272 X 340 资源图片的像素
     */
    NSLog(@"当前屏幕的大小为 = %@, 当前屏幕可以缩放的比例 = %f", NSStringFromCGRect(interfaceDevice.screenBounds), interfaceDevice.screenScale);
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end


