//
//  FirstViewController.m
//  SimpleDemo
//
//  Created by 钱瑶 on 2018/4/2.
//  Copyright © 2018年 钱瑶. All rights reserved.
//

#import "FirstViewController.h"
#import "UIImage+imageNamed_bundle_.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *sampleImageView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage * image = [UIImage yf_imageNamed:@"image_first"];
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
