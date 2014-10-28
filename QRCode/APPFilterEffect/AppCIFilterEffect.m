//
//  AppCIFilterEffect.m
//  QRCode
//
//  Created by 蔡杰 on 14-10-28.
//  Copyright (c) 2014年 蔡杰. All rights reserved.
//

#import "AppCIFilterEffect.h"


@interface AppCIFilterEffect ()

@property (nonatomic, strong, readwrite) UIImage *filterImage;

@property (nonatomic, strong, readwrite) UIImage *QRCodeImage;

@end

@implementation AppCIFilterEffect


-(instancetype)initWithImage:(UIImage *)image fileterName:(NSString *)name{
    
    self = [super init];
    
    if (self) {
        
        //将UIImage 转换为CIImage
        CIImage *ciImage = [[CIImage alloc]initWithImage:image];
        
        //创建滤镜
        CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey,ciImage, nil];
        
        [filter setDefaults];
        
        //绘制上下文
        CIContext *context = [CIContext contextWithOptions:nil];
        
        //渲染并输出CIImage
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        CGImageRelease(cgImage);
        
        
    }
    
    return self;
    
}

-(instancetype)initWithQRCodeString:(NSString *)string width:(CGFloat)width{
    
    
    
    if (self = [super init]) {
        
        CIFilter *fileter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        [fileter setDefaults];
        
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        [fileter setValue:data forKey:@"inputMessage"];
        
        CIImage *outputImage = [fileter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CGImageRef cgImage =[context createCGImage:outputImage fromRect:[outputImage extent]];
        
        UIImage *image = [UIImage imageWithCGImage:cgImage
                                             scale:0.1
                                       orientation:UIImageOrientationUp];
        
     
        // 不失真的放大
        UIImage *resized = [self resizeImage:image
                                 withQuality:kCGInterpolationNone
                                        rate:5.0];
        
        // 缩放到固定的宽度(高度与宽度一致)
        _QRCodeImage = [self scaleWithFixedWidth:width image:resized];
        
        CGImageRelease(cgImage);
        
        
    
    }
    
    return self;
}

- (UIImage *)scaleWithFixedWidth:(CGFloat)width image:(UIImage *)image
{
    float newHeight = image.size.height * (width / image.size.width);
    CGSize size = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

- (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}


@end
