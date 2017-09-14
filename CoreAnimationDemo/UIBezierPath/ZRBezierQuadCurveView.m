//
//  ZRBezierQuadCurveView.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/9/14.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRBezierQuadCurveView.h"

@implementation ZRBezierQuadCurveView

- (void)drawRect:(CGRect)rect {
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint:CGPointMake(0, 300)];
//    [bezierPath addQuadCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint:CGPointMake(rect.size.width / 2, 10)];
//    bezierPath.lineWidth = 1;
//    [[UIColor redColor] setStroke];
//    [bezierPath stroke];
    
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(0, 200)];
    [bezierPath1 addQuadCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint:CGPointMake(rect.size.width / 2 - 30, 0)];
    bezierPath1.lineWidth = 1;
    [[UIColor orangeColor] setStroke];
    [bezierPath1 stroke];
    
    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 moveToPoint:CGPointMake(0, 200)];
    [bezierPath2 addQuadCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint:CGPointMake(rect.size.width / 2, 0)];
    bezierPath2.lineWidth = 1;
    [[UIColor blueColor] setStroke];
    [bezierPath2 stroke];
}


@end
