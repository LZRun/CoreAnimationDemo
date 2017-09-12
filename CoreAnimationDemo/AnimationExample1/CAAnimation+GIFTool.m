//
//  UIImage+GIFTool.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/12.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "CAAnimation+GIFTool.h"

@implementation CAAnimation (GIFTool)
+ (CAAnimation *)gifAnimaitonWithImageURL: (NSURL *)url{
    NSMutableArray *images = [NSMutableArray array];
    //每一帧之间的延时
    NSMutableArray *delayTimes = [NSMutableArray array];
    //总时间
    CGFloat totalTime = 0.f;
    //获取图片信息
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url,NULL);
    size_t count = CGImageSourceGetCount(imageSource);
    for (size_t i = 0; i < count; i ++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        [images addObject:CFBridgingRelease(imageRef)];
        
        NSDictionary *property = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL));
        NSLog(@"%@",property);
        NSNumber *delayTime = property[(NSString *)kCGImagePropertyGIFDictionary][(NSString *)kCGImagePropertyGIFDelayTime];
        [delayTimes addObject:delayTime];
        totalTime += [delayTime floatValue];
    }
    
    //时间占比
    NSMutableArray *delayRates = [NSMutableArray array];//[NSMutableArray arrayWithObject:@0];
    //当前总时间
    CGFloat currentTime = 0.f;
    for (NSNumber *delayTime in delayTimes) {
        currentTime += [delayTime floatValue];
        [delayRates addObject: @(currentTime / totalTime)];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.values = images;
    animation.duration = totalTime;
    animation.keyTimes = delayRates;
    animation.repeatCount = HUGE_VALF;
    
    return animation;
}
@end
