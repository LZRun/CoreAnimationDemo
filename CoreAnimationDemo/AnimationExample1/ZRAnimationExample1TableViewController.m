//
//  ZRAnimationExample1TableViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/12.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRAnimationExample1TableViewController.h"

@interface ZRAnimationExample1TableViewController ()

@end

@implementation ZRAnimationExample1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configData{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"GIF" viewControllerName:@"ZRGIFViewController"]];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"LoadingHUD" viewControllerName:@"ZRLoadingHUDViewController"]];
    self.items = items;
}
@end
