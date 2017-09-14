//
//  ZRBezierCurveView.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/9/14.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRBezierCurveView.h"

@implementation ZRBezierCurveView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:CGPointMake(0, 200)];
    [bezierPath1 addCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint1:CGPointMake(rect.size.width / 4, 0) controlPoint2:CGPointMake(rect.size.width / 4 * 3, 400)];
    bezierPath1.lineWidth = 1;
    [[UIColor orangeColor] setStroke];
    [bezierPath1 stroke];
    
    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 moveToPoint:CGPointMake(0, 200)];
    [bezierPath2 addCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint1:CGPointMake(rect.size.width / 4, 0) controlPoint2:CGPointMake(rect.size.width / 4 * 3 - 50, 400)];
    bezierPath2.lineWidth = 1;
    [[UIColor redColor] setStroke];
    [bezierPath2 stroke];
    
}


@end
