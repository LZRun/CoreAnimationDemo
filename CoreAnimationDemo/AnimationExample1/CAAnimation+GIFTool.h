//
//  UIImage+GIFTool.h
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/12.
//  Copyright © 2017年 Run. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAAnimation (GIFTool)

+ (CAAnimation *)gifAnimaitonWithImageURL: (NSURL *)url;
@end
