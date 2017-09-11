//
//  ZRKeyframeAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/14.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRKeyframeAnimationViewController.h"

@interface ZRAnimationView : UIView

@end

@implementation ZRAnimationView
- (void)drawRect:(CGRect)rect{

    CGFloat centerX = rect.size.width / 2;
    CGFloat centerY = rect.size.height / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX / 2,centerY) radius:centerX / 2 startAngle:M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(centerX * 3 /2 , centerY) radius:centerX / 2  startAngle:M_PI endAngle:0 clockwise:NO];
    path.lineWidth = 1;
    [[UIColor orangeColor] setStroke];
    [path stroke];
}

@end
@interface ZRKeyframeAnimationViewController (){

    ZRAnimationView *animationView;
}

@end

@implementation ZRKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    animationView = [[ZRAnimationView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animationView];
    
    //[self postionAnimation];
    [self breaklineAnimation];
    // Do any additional setup after loading the view.
}

- (void)postionAnimation{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(100, 100)],[NSValue valueWithCGPoint:CGPointMake(200, 100)],[NSValue valueWithCGPoint:CGPointMake(200, 200)],[NSValue valueWithCGPoint:CGPointMake(100,200)]];
    animation.keyTimes = @[@0,@0.1,@0.9,@1];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 3;
    animation.repeatCount = MAXFLOAT;
    animation.calculationMode = kCAAnimationCubic;
    //animation.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)].CGPath;
    [animationView.layer addAnimation:animation forKey:@"keyframe"];
}

- (void)breaklineAnimation{

    CGFloat centerX = self.view.frame.size.width / 2;
    CGFloat centerY = 200;
    animationView.frame = CGRectMake(0, 100, 100, 100);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX / 2,centerY) radius:centerX / 2 startAngle:M_PI endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(centerX * 3 /2 , centerY) radius:centerX / 2  startAngle:M_PI endAngle:0 clockwise:NO];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 3;
    animation.repeatCount = MAXFLOAT;
    //animation.calculationMode = kCAAnimationCubicPaced;
    animation.path = path.CGPath;
    animation.keyTimes = @[@0,@0.1,@0.5,@0.5,@0.9,@1];
    [animationView.layer addAnimation:animation forKey:@"keyframe"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
