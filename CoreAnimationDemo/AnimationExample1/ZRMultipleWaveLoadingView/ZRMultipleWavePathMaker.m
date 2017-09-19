//
//  ZRMultipleWavePathMaker.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/9/19.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRMultipleWavePathMaker.h"

@implementation ZRMultipleWavePathMaker

- (instancetype)initWithLimitSize: (CGSize)limitSize waveHeight: (CGFloat)waveHeight{
    self = [super init];
    if (self) {
        self.limitSize = limitSize;
        self.waveHeight = waveHeight;
    }
    return self;
}

- (void)setXOffset:(CGFloat)xOffset{
    if (_xOffset != xOffset) {
        _xOffset = xOffset;
    }
}

- ()

@end
