//
//  ZRHomeTableViewController.h
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/10.
//  Copyright © 2017年 Run. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRHomeItem.h"

@interface ZRHomeTableViewController : UITableViewController
/**
 注释
 */
@property (nonatomic,strong) NSArray<ZRHomeItem *> *items;
- (void)configData;
@end
