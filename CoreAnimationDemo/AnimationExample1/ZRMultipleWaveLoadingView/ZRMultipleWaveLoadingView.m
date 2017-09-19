//
//  ZRMultipleWaveLoadingView.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/19.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRMultipleWaveLoadingView.h"
#import "ZRMultipleWavePathMaker.h"

@interface ZRMultipleWaveLoadingView (){
    ///上层x方向偏移量
    CGFloat _topXOffset;
    ///下层x方向偏移量
    CGFloat _bottomXOffset;
    ///y方向偏移量
    CGFloat _yOffset;
    
}
@property (nonatomic,strong) CADisplayLink *displayLink;
@property (nonatomic,strong) CAShapeLayer *topWaveLayer;
@property (nonatomic,strong) CAShapeLayer *bottomWaveLayer;
@property (nonatomic,strong) UILabel *progressLabel;
/**
 波浪路径制造
 */
@property (nonatomic,strong) ZRMultipleWavePathMaker *pathMaker;
@end
@implementation ZRMultipleWaveLoadingView

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, 150, 150)];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)configView{
    self.layer.cornerRadius = self.height / 2;
    self.layer.masksToBounds = YES;
    [self setDefaultValues];
    [self configPathMaker];
    [self configWaveLayer];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeBottomInitialPhase)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setDefaultValues{
    _topXOffset = 0;
    _bottomXOffset = self.width /  4;
    _yOffset = 0;
    self.progress = 0;
}

- (void)configPathMaker{

}
- (void)configWaveLayer{
    UIColor *darkBlue = [UIColor colorWithRed:26 / 255.0 green:106 / 255.0 blue:239 / 255.0 alpha:1];
    self.bottomWaveLayer = [CAShapeLayer layer];
    _bottomWaveLayer.frame = self.bounds;
    _bottomWaveLayer.fillColor = darkBlue.CGColor;
    _bottomWaveLayer.strokeColor = darkBlue.CGColor;
    [self.layer addSublayer:_bottomWaveLayer];
    
    UIColor *blue = [UIColor colorWithRed:25/255.0 green:188 / 255.0 blue:255 / 255.0 alpha:0.75];
    self.topWaveLayer = [CAShapeLayer layer];
    _topWaveLayer.frame = self.bounds;
    _topWaveLayer.fillColor = blue.CGColor;
    _topWaveLayer.strokeColor = blue.CGColor;
    [self.layer addSublayer:_topWaveLayer];
}

- (void)changeBottomInitialPhase{
    
}

@end
