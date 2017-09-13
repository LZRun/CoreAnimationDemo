//
//  ZRWaveLoadingViewController.m
//  CoreAnimationDemo
//
//  Created by Run on 2017/9/13.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRWaveLoadingViewController.h"
#import "ZRWaveLoadingView.h"

@interface ZRWaveLoadingViewController ()

@end

@implementation ZRWaveLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZRWaveLoadingView *loadingView = [[ZRWaveLoadingView alloc]init];
    loadingView.center = self.view.center;
    [self.view addSubview:loadingView];
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
