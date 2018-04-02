//
//  HomeViewController.m
//  SimpleDemo
//
//  Created by 钱瑶 on 2018/4/2.
//  Copyright © 2018年 钱瑶. All rights reserved.
//

#define PFNFontWithSize(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#import "HomeViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FSNavigationController.h"
#import "UIImage+imageNamed_bundle_.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self addAllChildViewControllers];
}

- (void)addAllChildViewControllers
{
    
    
    
    FirstViewController *othersVC = [[FirstViewController alloc] init];
    [self addChildViewController:othersVC title:@"第一页" image:@"icon_first" selectedImage:@"icon_first_hui"];
    
    
    SecondViewController *uiVC = [[SecondViewController alloc] init];
    [self addChildViewController:uiVC title:@"第二页" image:@"icon_second" selectedImage:@"icon_second_hui"];
    
    
    ThirdViewController *indexVC = [[ThirdViewController alloc] init];
    [self addChildViewController:indexVC title:@"第三页" image:@"icon_third" selectedImage:@"icon_third_hui"];
    
    
}


- (void)addChildViewController:(UIViewController *)childController
                         title:(NSString *)title
                         image:(NSString *)normalImageName
                 selectedImage:(NSString *)selectedImageName
{
    childController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                               image:[[UIImage yf_imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[[UIImage yf_imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    NSDictionary *normalAttr = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:PFNFontWithSize(12)};
    NSDictionary *highlightAttr = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:PFNFontWithSize(12)};
    
    [childController.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:highlightAttr forState:UIControlStateSelected];
    
    childController.title = title;
    FSNavigationController *nav = [[FSNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    /*
     [MBProgressHUD showMessage:[NSString stringWithFormat:@"这是：%@ 演示",viewController.title] completion:^{
     NSLog(@"你刚刚点了：%@",viewController.title);
     }];
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
