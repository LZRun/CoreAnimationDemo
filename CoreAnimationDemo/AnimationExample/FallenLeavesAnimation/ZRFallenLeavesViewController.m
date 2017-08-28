//
//  ZRFallenLeavesViewController.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/8/28.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRFallenLeavesViewController.h"

@interface ZRFallenLeavesViewController ()
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
    [self fallenLeavesWithPoint:point];
}

//下落动画
- (void)fallenLeavesWithPoint: (CGPoint)point{
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 6;
    animation.fillMode = kCAFillModeForwards;
    animation.toValue = [NSValue valueWithCGPoint:point];
    [_leafLayer addAnimation:animation forKey:@"positionAnimation"];
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
