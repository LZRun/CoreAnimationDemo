//
//  ZRBezierPathViewController.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/9/14.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRBezierPathViewController.h"
#import "ZRBezierQuadCurveView.h"
#import "ZRBezierCurveView.h"
@interface ZRBezierPathViewController ()

@end

@implementation ZRBezierPathViewController
- (void)loadView{
    //self.view = [[ZRBezierQuadCurveView alloc] init];
    self.view = [[ZRBezierCurveView alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
