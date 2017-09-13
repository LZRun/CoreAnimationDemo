//
//  ZRAnimationLoadingHUD.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/13.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRAnimationLoadingHUD.h"

@interface ZRAnimationLoadingHUD ()

@property (nonatomic,strong) CAShapeLayer *animationLayer;

@end

@implementation ZRAnimationLoadingHUD

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, 300, 300)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat bigRadius = width * 0.9 / 2;
    
    [[UIColor whiteColor] setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width / 2 - bigRadius, height / 2 - bigRadius, bigRadius * 2, bigRadius * 2) cornerRadius:bigRadius];
    [path fill];
}

- (void)configView{
    self.backgroundColor = [UIColor blackColor];
    [self.layer addSublayer:self.animationLayer];
    _progress = 0;
}

- (void)configPath{
    CGFloat smallRadius = self.width * 0.4;
    CGPoint position = _animationLayer.position;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(position.x, position.y - smallRadius)];
    [path addLineToPoint:position];
    //求弧线上的点的左边值
    CGFloat angle = self.startAngle + M_PI_2;
    CGFloat x = sin(angle) * smallRadius;
    CGFloat y = cos(angle) * smallRadius;
    [path addLineToPoint:CGPointMake(position.x + x,position.y - y)];
    [path addArcWithCenter:position radius:smallRadius startAngle:self.startAngle endAngle:- M_PI_2 clockwise:YES];
    _animationLayer.path = path.CGPath;
}

- (CGFloat)startAngle{
    //值为0~1之间，类似下载的处理
    //- M_PI_2 + M_PI * 2 * _progress;
    //对于值可以无穷大，无限旋转,类似网络加载的处理
    return - M_PI_2 + M_PI * 2 * (_progress - (NSInteger)(_progress));
}

#pragma mark -
- (CAShapeLayer *)animationLayer{
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.bounds = self.bounds;
        _animationLayer.position = self.center;
        _animationLayer.fillColor = [UIColor blackColor].CGColor;
    }
    return _animationLayer;
}

- (void)setProgress:(CGFloat)progress{
    if (_progress != progress) {
        _progress = progress;
        [self configPath];
    }
}

@end
