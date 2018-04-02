//
//  UIImage+imageNamed_bundle_.m
//  ios_assets_hot_update_2
//
//  Created by 颜风 on 2016/9/23.
//  Copyright © 2016年 iOS122. All rights reserved.
//

#import "UIImage+imageNamed_bundle_.h"

@implementation UIImage (imageNamed_bundle_)
+ (UIImage *)imageNamed:(NSString *)imgName bundle:(NSString *)bundleName
{
    bundleName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    imgName = [NSString stringWithFormat:@"%@@3x",imgName];
    
    NSString * bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent: bundleName];
    NSBundle * mainBundle = [NSBundle bundleWithPath:bundlePath];
    NSString * imgPath = [mainBundle pathForResource:imgName ofType:@"png"];
    
    UIImage * image;
    static NSString * model;
    
    if (!model) {
        model = [[UIDevice currentDevice]model];
    }
    
    if ([model isEqualToString:@"iPad"]) {
        NSData *imageData = [NSData dataWithContentsOfFile: imgPath];
        image = [UIImage imageWithData:imageData scale:2.0];
    }else{
        image = [UIImage imageWithContentsOfFile: imgPath];
    }
    return  image;
}
@end
