//
//  UIImage+TBColor.m
//  SaasApp
//
//  Created by ToothBond on 15/11/11.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "UIImage+TBColor.h"

@implementation UIImage (TBColor)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
