//
//  ThirdViewController.m
//  SimpleDemo
//
//  Created by 钱瑶 on 2018/4/2.
//  Copyright © 2018年 钱瑶. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIImage+imageNamed_bundle_.h"
@interface ThirdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sampleImageView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage * image = [UIImage yf_imageNamed:@"image_third"];
    self.sampleImageView.image = image;
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
