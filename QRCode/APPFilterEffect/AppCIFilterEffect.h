//
//  AppCIFilterEffect.h
//  QRCode
//
//  Created by 蔡杰 on 14-10-28.
//  Copyright (c) 2014年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 CILinearToSRGBToneCurve
 CIPhotoEffectChrome
 CIPhotoEffectFade
 CIPhotoEffectInstant
 CIPhotoEffectMono
 CIPhotoEffectNoir
 CIPhotoEffectProcess
 CIPhotoEffectTonal
 CIPhotoEffectTransfer
 CISRGBToneCurveToLinear
 CIVignetteEffect
 
 */


@interface AppCIFilterEffect : NSObject

@property(strong,readonly,nonatomic)UIImage *fileterImage;

-(instancetype)initWithImage:(UIImage*)image fileterName:(NSString*)name;

@property(strong,readonly,nonatomic)UIImage *QRCodeImage;
- (instancetype)initWithQRCodeString:(NSString *)string width:(CGFloat)width;


@end
