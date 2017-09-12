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
        self.progress = 0;
        isPlay = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playOrSuspendTapeGestureAction)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat bigRadius = width * 0.9 / 2;
    CGFloat smallRadius = width * 0.7 / 2;
  
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2 - bigRadius, height / 2 - bigRadius, bigRadius * 2, bigRadius * 2) cornerRadius:bigRadius];
    [path stroke];
    [path fill];
    
    [[UIColor blackColor] setFill];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2 - smallRadius, height / 2 - smallRadius, smallRadius * 2, smallRadius * 2) cornerRadius:smallRadius];
    [path1 stroke];
    [path1 fill];
    
    if (!isPlay) {
        [[UIColor whiteColor] setFill];
        CGFloat minimumRadius = smallRadius / 3;
        CGPoint center = CGPointMake(width / 2, height / 2);
        CGFloat changeAngle = self.endAngle + M_PI_2;
        CGFloat x = sin(changeAngle) * smallRadius;
        CGFloat y = cos(changeAngle) * smallRadius;
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        [path2 moveToPoint:CGPointMake(center.x, center.y - minimumRadius)];
        [path2 addArcWithCenter:center radius:minimumRadius startAngle:- M_PI_2 endAngle:self.endAngle clockwise:YES];
        [path2 addLineToPoint:CGPointMake(center.x + x, center.y - y)];
        [path2 addArcWithCenter:center radius:smallRadius startAngle:self.endAngle endAngle:- M_PI_2 clockwise:NO];
        [path2 addLineToPoint:CGPointMake(center.x, center.y - minimumRadius)];
        [path2 stroke];
        [path2 fill];
        
        CGFloat lineWith = 5;
        CGFloat lineHeight = 10;
        CGFloat centerSpace = 3;
        UIBezierPath *path3 = [UIBezierPath bezierPath];
        path3.lineWidth = lineWith;
        [path3 moveToPoint:CGPointMake(center.x - lineWith - centerSpace, center.y - lineHeight / 2)];
        [path3 addLineToPoint:CGPointMake(path3.currentPoint.x, path3.currentPoint.y + lineHeight)];
        [path3 moveToPoint: CGPointMake(center.x + centerSpace, center.y - lineHeight / 2)];
        [path3 addLineToPoint:CGPointMake(path3.currentPoint.x, path3.currentPoint.y + lineHeight)];
        [[UIColor whiteColor] setStroke];
        [path3 stroke];
    }else{
        [[UIColor whiteColor] setFill];
        CGPoint center = CGPointMake(width / 2, height / 2);
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        [path2 moveToPoint:center];
        [path2 addLineToPoint:CGPointMake(width / 2, height / 2 - smallRadius)];
        [path2 addArcWithCenter:center radius:smallRadius startAngle:- M_PI_2 endAngle:self.endAngle clockwise:YES];
        [path2 addLineToPoint:center];
        [path2 stroke];
        [path2 fill];
    }
    
}

- (void)playOrSuspendTapeGestureAction{
    isPlay = !isPlay;
    if (_playOrSuspendHandler) {
        _playOrSuspendHandler(isPlay);
    }
    [self setNeedsDisplay];
}

- (CGFloat)endAngle{
    return - M_PI_2 + M_PI * 2 * _progress;
}

- (void)setProgress:(CGFloat)progress{
    if (_progress != progress) {
        progress = MIN(MAX(progress, 0), 1);
        _progress = progress;
        [self setNeedsDisplay];
    }
    
}
@end
