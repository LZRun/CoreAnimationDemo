//
//  ZRSpringAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/31.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRSpringAnimationViewController.h"

@interface ZRSpringAnimationViewController ()

/**
 阻尼 0 - 1
 */
@property (nonatomic) CGFloat damping;
/**
 初始速度
 */
@property (nonatomic,assign) CGFloat velocity;
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
@property (weak, nonatomic) IBOutlet UILabel *velocityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dampingLabel;

@end

@implementation ZRSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _velocity = 0.5;
    _damping = 0.5;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)velocityChanged:(UISlider *)sender {
    _velocity = sender.value;
    _velocityLabel.text = [NSString stringWithFormat:@"%.2f",_velocity];
}
- (IBAction)dampingChanged:(UISlider *)sender {
    _damping = sender.value;
    _dampingLabel.text = [NSString stringWithFormat:@"%.2f",_damping];
}
- (IBAction)beiginAnimation:(id)sender {
    [self pringAnimation];
}

- (void)pringAnimation{
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    //animation.fromValue = [NSValue valueWithCGPoint:_ballImageView.center];
    //animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_ballImageView.centerX, _ballImageView.centerY + 300)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.5)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.mass = 1;
    animation.stiffness = 100;
    animation.damping = 10 * _damping;
    animation.initialVelocity = _velocity;
    //animation.autoreverses = YES;
    animation.duration = animation.settlingDuration;
    [_ballImageView.layer addAnimation:animation forKey:nil];
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
