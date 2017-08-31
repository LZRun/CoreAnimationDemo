//
//  ZRFallenLeavesViewController.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/8/28.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRFallenLeavesViewController.h"

@interface ZRFallenLeavesViewController ()<CAAnimationDelegate>
@property (nonatomic,strong) CALayer *leafLayer;
@end

@implementation ZRFallenLeavesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"EECACBBF-AFFC-4109-A22F-8E479751B05C"];
    UIGraphicsBeginImageContext(CGSizeMake(self.view.width, self.view.height - 64));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(contextRef, 1, -1);
    CGContextTranslateCTM(contextRef, 0, -(self.view.height - 64));
    CGContextDrawImage(contextRef, CGRectMake(0, 0, self.view.width, self.view.height - 64), image.CGImage);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIImage *leafImage = [UIImage imageNamed:@"B0BA5EFB-663B-4460-92BD-9E1CC5A93693"];
    self.leafLayer = [CALayer layer];
    _leafLayer.bounds = CGRectMake(0, 0, leafImage.size.width, leafImage.size.height);
    _leafLayer.position = CGPointMake(50, 150);
    _leafLayer.contents = (id)leafImage.CGImage;
    [self.view.layer addSublayer:_leafLayer];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CAAnimation *animation = [_leafLayer animationForKey:@"positionKeyFrameAnimation"];
    if (animation) {
        if (_leafLayer.speed == 0) {
            [self resumeAnimation];
        }else{
            [self pauseAnimation];
        }
    }else{
        //[self fallenLeavesWithPoint:point];
        [self fallenLeavesKeyFrameWithPoint:point];
        [self fallenLeavesRotation];
    }
}
#pragma mark - animationMethods
//Basic下落动画
- (void)fallenLeavesWithPoint: (CGPoint)point{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 6;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.delegate = self;
    [_leafLayer addAnimation:animation forKey:@"positionAnimation"];
}

- (void)fallenLeavesKeyFrameWithPoint: (CGPoint)point{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 6;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _leafLayer.position.x, _leafLayer.position.y);
    //绘制二次贝塞尔曲线(原理)
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);
    animation.path = path;
    CGPathRelease(path);
    [_leafLayer addAnimation:animation forKey:@"positionKeyFrameAnimation"];
}

//旋转动画
- (void)fallenLeavesRotation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(M_PI_2);
    animation.toValue = @(M_PI_2 * 3);
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.removedOnCompletion = NO;
    animation.duration = 3;
    [_leafLayer addAnimation:animation forKey:@"transform_rotation_z"];
}

//暂停动画
- (void)pauseAnimation{
    //获取指定图层的动画的媒体时间,后面参数用于指定子图层
    CFTimeInterval timeInterval = [_leafLayer convertTime:CACurrentMediaTime() toLayer:nil];
    //设置动画偏移量，保证暂停到动画已经执行到的位置
    _leafLayer.timeOffset = timeInterval;
    //速度设置为0，暂停动画
    _leafLayer.speed = 0;
}
//恢复动画
- (void)resumeAnimation{
    //获取暂停的时间,（我对此的理解是当前媒体时间减去动画所用时间设置为开始时间，则当前媒体时间和当前的动画状态匹配上，使得能够让动画恢复的更连贯）
    CFTimeInterval beginTime = CACurrentMediaTime() - _leafLayer.timeOffset;
    //timeOffset恢复到初始位置
    _leafLayer.timeOffset = 0;
    //设置动画开始时间
    _leafLayer.beginTime = beginTime;
    //设置动画速度，开始动画
    _leafLayer.speed = 1;
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self pauseAnimation];
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
