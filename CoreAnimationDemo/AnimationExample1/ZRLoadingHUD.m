//
//  ZRLoadingHUD.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/11.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRLoadingHUD.h"

@implementation ZRLoadingHUD
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat bigRadius = width * 0.9 / 2;
    CGFloat smallRadius = width * 0.7 / 2;
  
    [[UIColor whiteColor] setFill];
    [[UIColor redColor] setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2 - bigRadius, height / 2 - bigRadius, bigRadius * 2, bigRadius * 2) cornerRadius:bigRadius];
    path.lineWidth = 1;
    [path stroke];
    [path fill];
    
    [[UIColor blackColor] setFill];
    [[UIColor redColor] setStroke];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2 - smallRadius, height / 2 - smallRadius, smallRadius * 2, smallRadius * 2) cornerRadius:smallRadius];
    path1.lineWidth = 1;
    [path1 stroke];
    [path1 fill];
}


@end
