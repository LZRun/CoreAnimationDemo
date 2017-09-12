//
//  ZRLoadingHUDViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/11.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRLoadingHUDViewController.h"
#import "ZRLoadingHUD.h"

@interface ZRLoadingHUDViewController ()

@end

@implementation ZRLoadingHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZRLoadingHUD *hud = [[ZRLoadingHUD alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    hud.center = self.view.center;
    [self.view addSubview:hud];
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
