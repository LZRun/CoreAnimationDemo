//
//  ZRPhotoBrowserViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/29.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRPhotoBrowserViewController.h"

@interface ZRPhotoBrowserViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation ZRPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _imageView.image = self.images[_currentIndex];
    [self.view addSubview:_imageView];

    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rigteGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
    rigteGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rigteGesture];
    // Do any additional setup after loading the view.
}

- (void)swipeGestureAction: (UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self transitionAnimaitonOfDirectionIsRight:YES];
    }else{
        [self transitionAnimaitonOfDirectionIsRight:NO];
    }
}

- (void)transitionAnimaitonOfDirectionIsRight: (BOOL)isRight{
    CATransition *animaition = [CATransition animation];
    animaition.type = @"cube";
    animaition.subtype = isRight ? kCATransitionFromLeft : kCATransitionFromRight;
    animaition.duration = 2;
    [_imageView.layer addAnimation:animaition forKey:@"transitionAnimationKey"];
    if (isRight) _currentIndex = (_currentIndex - 1 + _images.count) % _images.count;
    else _currentIndex = (_currentIndex + 1) % _images.count;
    _imageView.image = _images[_currentIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)images{
    if (!_images) {
        NSArray *imagsNams = @[@"B667F648-EB30-4B56-8A57-518DEBACA6AA",@"u=436038687,427321753&fm=26&gp=0",@"u=1675504891,2127529254&fm=26&gp=0",@"EECACBBF-AFFC-4109-A22F-8E479751B05C"];
        NSMutableArray *images = [NSMutableArray array];
        for (NSString *imageName in imagsNams) {
            [images addObject: [UIImage imageNamed:imageName]];
        }
        _images = images;
    }
    return _images;
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
