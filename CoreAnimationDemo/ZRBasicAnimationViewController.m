//
//  ZRBasicAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/11.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRBasicAnimationViewController.h"
@interface ZRBasicAnimationViewController ()<CAAnimationDelegate>{
    UIView *animationView;
}
@end

@implementation ZRBasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    animationView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animationView];
    
    [self postitionBasicAnimation];
    //[self opacityBasicAnimation];
    //[self backgroundColorAnimation];
    //[self transformAnimation];
}
//position动画
- (void)postitionBasicAnimation{
    
    CABasicAnimation *basciAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basciAnimation.removedOnCompletion = NO;
    //basciAnimation.fillMode = kCAFillModeForwards;
    basciAnimation.duration = 3;
    basciAnimation.repeatCount = 1;
    basciAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basciAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width - 50,self.view.frame.size.height - 50)];
    //basciAnimation.speed = 3;
    basciAnimation.delegate = self;
    [basciAnimation setValue:basciAnimation.toValue forKey:@"animationKey"];
    [animationView.layer addAnimation:basciAnimation forKey:nil];
}
//opacity动画
- (void)opacityBasicAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 3;
    animation.repeatCount = 200;
    //animation.removedOnCompletion = NO;
    //animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1];
    [animationView.layer addAnimation:animation forKey:nil];
}
//backGroundColor
- (void)backgroundColorAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 3;
    animation.fromValue = (__bridge id)[UIColor orangeColor].CGColor;
    animation.toValue = (__bridge id)[UIColor redColor].CGColor;
    [animationView.layer addAnimation:animation forKey:nil];
}
- (void)transformAnimation{
    //scale rotation translation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.beginTime = CACurrentMediaTime() + 1;
    animation.duration = 3;
    //animation.fromValue = @(0);
    animation.toValue = @(100);
    animation.repeatCount  = 1;
    [animationView.layer addAnimation:animation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSValue *toValue = [anim valueForKey:@"animationKey"];
    NSLog(@"animationKey = %@",toValue);
    animationView.layer.position = [toValue CGPointValue];
    /*
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    animationView.layer.position = [toValue CGPointValue];
    //提交事务
    [CATransaction commit];
     */
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

