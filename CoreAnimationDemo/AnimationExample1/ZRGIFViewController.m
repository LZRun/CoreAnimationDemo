//
//  ZRGIFViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/12.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRGIFViewController.h"
#import "CAAnimation+GIFTool.h"

@interface ZRGIFViewController ()
@property (weak, nonatomic) IBOutlet UIView *gifView;

@end

@implementation ZRGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[[NSBundle mainBundle] pathForResource:@"aaa" ofType:@"gif"];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"aaa.gif"];
    CAAnimation *animaiton = [CAAnimation gifAnimaitonWithImageURL:[NSURL fileURLWithPath:path]];
    [_gifView.layer addAnimation:animaiton forKey:nil];
}
- (IBAction)operateAction:(id)sender {
    if (_gifView.layer.speed == 1) {
        CFTimeInterval timeOffSet = [_gifView.layer convertTime:CACurrentMediaTime() toLayer:nil];
        _gifView.layer.timeOffset = timeOffSet;
        _gifView.layer.speed = 0;
    }else{
        CFTimeInterval beginTime = CACurrentMediaTime() - _gifView.layer.timeOffset;
        _gifView.layer.timeOffset = 0;
        _gifView.layer.beginTime = beginTime;
        _gifView.layer.speed = 1;
    }
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
