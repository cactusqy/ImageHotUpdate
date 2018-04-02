//
//  FSNavigationController.m
//  FastApp
//
//  Created by tangkunyin on 16/3/7.
//  Copyright © 2016年 www.shuoit.net. All rights reserved.
//
#define HYCRedColor COLOR(224,31,14)     //红色
#define FSWhiteColor COLOR(255, 255, 255)          //纯白
#define SysFontWithSize(s) [UIFont systemFontOfSize:s]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "FSNavigationController.h"
//#import "UIImage+FSUIImage.h"

@implementation FSNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor redColor];
    
    NSDictionary* titleAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:SysFontWithSize(18)};
    [bar setTitleTextAttributes:titleAttributes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:SysFontWithSize(14)};
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    //去除导航栏下方的横线
    [bar setBackgroundImage:[self imageWithColor:[UIColor redColor] size:CGSizeMake(SCREEN_WIDTH, 3)]
                                                  forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[self imageWithColor:[UIColor redColor] size:CGSizeMake(SCREEN_WIDTH, 3)]];
    
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
