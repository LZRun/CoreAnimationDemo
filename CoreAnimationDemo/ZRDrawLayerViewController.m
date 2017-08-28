//
//  ZRDrawLayerViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/28.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRDrawLayerViewController.h"
#define PHOTO_HEIGHT 150
@interface ZRDrawLayerViewController ()<CALayerDelegate>

@end

@implementation ZRDrawLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self configLayer];
    // Do any additional setup after loading the view.
}
- (void)configLayer{
    //自定义图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position=CGPointMake(160, 200);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=PHOTO_HEIGHT/2;
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds=YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
//    layer.shadowColor=[UIColor grayColor].CGColor;
//    layer.shadowOffset=CGSizeMake(2,2);
//    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;
    //设置图层代理
    layer.delegate=self;
    //可以直接设置contents显示内容
    //layer.contents = (__bridge id)[UIImage imageNamed:@"B667F648-EB30-4B56-8A57-518DEBACA6AA"].CGImage;
    //添加图层到根图层
    [self.view.layer addSublayer:layer];
    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);
    UIImage *image = [UIImage imageNamed:@"B667F648-EB30-4B56-8A57-518DEBACA6AA"];
    CGContextDrawImage(ctx, CGRectMake(0, 0,PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
    CGContextRestoreGState(ctx);
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
