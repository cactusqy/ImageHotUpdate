//
//  UIImage+imageNamed_bundle_.h
//  ios_assets_hot_update_2
//
//  Created by 颜风 on 2016/9/23.
//  Copyright © 2016年 iOS122. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageNamed_bundle_)
/* load img smart .*/
+ (UIImage *)yf_imageNamed:(NSString *)imgName;

/* smart update for patch */
+ (void)yf_updatePatchFrom:(NSString *) pathInfoUrlStr;
@end
