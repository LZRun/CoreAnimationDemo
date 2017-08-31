//
//  ZRUIViewAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/31.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRUIViewAnimationViewController.h"

@interface ZRUIViewAnimationViewController (){
    UIView *animaitionView;
}
/**
 注释
 */
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ZRUIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //3EBDD01D-8D5A-4CA7-8A7C-CDD2AA6F6256"
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100,60, 43)];
    _imageView.image = [UIImage imageNamed:@"u=436038687,427321753&fm=26&gp=0"];
    [self.view addSubview:_imageView];
    
    [self keyframeAnimation];
    /*
    //转场动画视图
    animaitionView = [[UIView alloc]initWithFrame:_imageView.frame];
    animaitionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animaitionView];
    [self.view sendSubviewToBack:animaitionView];
     */
    // Do any additional setup after loading the view.
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    [self pringAnimationWithPoint:point];
    [self transitionAnimation];
}
//弹性动画
- (void)pringAnimationWithPoint: (CGPoint)point{
    NSLog(@"y : %f, distance : %f",point.y,point.y - _imageView.centerY);
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center = point;
    } completion:nil];
}
//关键帧动画
- (void)keyframeAnimation{
    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewAnimationOptionCurveLinear| UIViewAnimationOptionAllowUserInteraction animations:^{
        //第二帧（第一帧为开始位置）,frameStartTime:开始时间比例既 5s * 0 = 0s frameDuration: 时间比例  既 5s * 0.5 = 2.5s
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            NSLog(@"1: %f",_imageView.y);
            _imageView.y += 100;
        }];
        //第三帧
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            NSLog(@"2: %f",_imageView.y);
            _imageView.y += 100;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            NSLog(@"3: %f",_imageView.y);
            _imageView.y += 100;
        }];
    } completion:^(BOOL finished) {
        NSLog(@"end: %f",_imageView.y);
    }];
}

//转场动画
- (void)transitionAnimation{
    UIViewAnimationOptions options;
    UIImage *image;
    if (_imageView.tag == 0) {
        image = [UIImage imageNamed:@"B667F648-EB30-4B56-8A57-518DEBACA6AA"];
        options = UIViewAnimationOptionTransitionFlipFromLeft;
        _imageView.tag = 1;
    }else{
        image = [UIImage imageNamed:@"u=436038687,427321753&fm=26&gp=0"];
        options = UIViewAnimationOptionTransitionFlipFromRight;
        _imageView.tag = 0;
    }
    [UIView transitionWithView:_imageView duration:3 options:options animations:^{
        _imageView.image = image;
    } completion:NULL];
    /*
    UIViewAnimationOptions options;
    UIView *fromView;
    UIView *toView;
    if (self.view.subviews.lastObject == animaitionView) {
        options = UIViewAnimationOptionTransitionFlipFromLeft;
        fromView = animaitionView;
        toView = _imageView;
    }else{
        options = UIViewAnimationOptionTransitionFlipFromRight;
        fromView = _imageView;
        toView = animaitionView;
    }
    [self.view sendSubviewToBack:fromView];
    [UIView transitionFromView:fromView toView:toView duration:3 options:options completion:NULL];
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
