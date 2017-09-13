//
//  ZRWaveLoading.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/9/13.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRWaveLoadingView.h"

@interface ZRWaveLoadingView (){
    //当前初相
    CGFloat _initialPhase;
    //当前偏距
    CGFloat _yOffset;
}

@property (nonatomic,strong) CADisplayLink *displayLink;
@property (nonatomic,strong) CAShapeLayer *bottomWaseLayer;
@property (nonatomic,strong) CAShapeLayer *topWaseLayser;
@property (nonatomic,strong) UILabel *progressLabel;
@end
@implementation ZRWaveLoadingView

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, 300, 300)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_displayLink invalidate];
    }
}

- (void)configView{

    self.backgroundColor = [UIColor redColor];
    self.layer.mask = [self maskLayer];
    [self creatBottomWase];
    //[self creatTopWase];
    _yOffset = self.height;
    [self addSubview:self.progressLabel];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeBottomInitialPhase)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
//下层波浪
- (void)creatBottomWase{
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.bounds = self.bounds;
    shapLayer.position = self.center;
    shapLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:shapLayer];
    self.bottomWaseLayer = shapLayer;
}
//上层波浪
- (void)creatTopWase{
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.bounds = self.bounds;
    shapLayer.position = self.center;
    shapLayer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:shapLayer];
    self.topWaseLayser = shapLayer;
}
- (void)changeBottomInitialPhase{
    _initialPhase += 0.1;
    if (_yOffset <= 0) {
        _progressLabel.text = @"100%";
        _yOffset = self.height;
    }
    _yOffset -= 0.1;
    _progressLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)((self.height - _yOffset) / self.height * 100)];
    _bottomWaseLayer.path = [self wavePathWithYffset:_yOffset initialPhase:_initialPhase].CGPath;
    //_topWaseLayser.path = [self wavePathWithYffset:_yOffset - 5 initialPhase:_initialPhase + 5].CGPath;
}
- (CAShapeLayer *)maskLayer{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.width / 2];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    return maskLayer;
}

/**
 创建正弦函数路径

 @param yOffset 偏距
 @param initialPhase 初相
 @return 路径
 */
- (UIBezierPath *)wavePathWithYffset: (CGFloat)yOffset initialPhase:(CGFloat)initialPhase{
    //振幅
    CGFloat amplitude = 10;
    //角速度,控制正弦周期
    CGFloat palstence = 0.03;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint firstPoint;
    for (double x = 0; x < self.width; x ++) {
        CGPoint point = CGPointMake(x,amplitude * sin(palstence * x + initialPhase) + yOffset);
        if (x == 0) {
            firstPoint = point;
            [bezierPath moveToPoint:point];
        }else{
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath addArcWithCenter:CGPointMake(self.width / 2, self.height / 2) radius:self.width / 2 startAngle:0 endAngle:M_PI clockwise:YES];
    
    return bezierPath;
}

- (UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _progressLabel.centerX = self.centerX;
        _progressLabel.centerY = self.centerY;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _progressLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
