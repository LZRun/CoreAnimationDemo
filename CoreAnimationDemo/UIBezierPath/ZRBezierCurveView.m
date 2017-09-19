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
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGFloat curveHeight = 50;
    CGFloat yOffset = 300;
    CGFloat xOffset = width / 4 - 20;

    CGFloat y = height - (curveHeight * sin(xOffset / width * M_PI * 2) + curveHeight + yOffset);

    CGPoint firstPoint = CGPointMake(0, y);
    CGPoint secondPoint = CGPointMake(width / 4, height - yOffset - curveHeight * 2);
    CGPoint thirdPoint = CGPointMake(width * 3 / 4, height -  yOffset);
    CGPoint fourthPoint = CGPointMake(width, y);

    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint:secondPoint];
    [bezierPath1 addLineToPoint:firstPoint];
    [bezierPath1 addCurveToPoint:fourthPoint controlPoint1:secondPoint controlPoint2:thirdPoint];
    [bezierPath1 addLineToPoint:thirdPoint];
    bezierPath1.lineWidth = .5;
    [[UIColor orangeColor] setStroke];
    [bezierPath1 stroke];
    
    
//    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
//    [bezierPath1 moveToPoint:CGPointMake(rect.size.width / 2, 0)];
//    [bezierPath1 addLineToPoint:CGPointMake(0, 200)];
//    [bezierPath1 addCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint1:CGPointMake(rect.size.width / 2, 0) controlPoint2:CGPointMake(rect.size.width / 2, 400)];
//    [bezierPath1 addLineToPoint:CGPointMake(rect.size.width / 2, 400)];
//    bezierPath1.lineWidth = 1;
//    [[UIColor orangeColor] setStroke];
//    [bezierPath1 stroke];
//
//    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
//    [bezierPath2 moveToPoint:CGPointMake(rect.size.width / 2, 0)];
//    [bezierPath2 addLineToPoint:CGPointMake(0, 200)];
//    [bezierPath2 addCurveToPoint:CGPointMake(rect.size.width, 200) controlPoint1:CGPointMake(rect.size.width / 2, 0) controlPoint2:CGPointMake(rect.size.width / 2, 400 + 50)];
//    [bezierPath2 addLineToPoint:CGPointMake(rect.size.width / 2, 400 + 50)];
//    bezierPath2.lineWidth = 1;
//    [[UIColor redColor] setStroke];
//    [bezierPath2 stroke];
    
}


@end
