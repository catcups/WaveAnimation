//
//  ViewController.m
//  WaveAnimation
//
//  Created by pc on 2017/9/18.
//  Copyright © 2017年 QH. All rights reserved.
//

#import "ViewController.h"
//cocoa
@import QuartzCore;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRippleAnimation];
}

- (void)setupRippleAnimation
{
    CGFloat width = 4;
    CGRect pathFrame = CGRectMake(0,0, width, width);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(60, 60, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = 6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.view.layer addSublayer:[self creatShapeLayerByPath:path andColor:[UIColor colorWithRed:251/255.0 green:20/255.0 blue:20/255.0 alpha:1] addAnimation:animation]];
    
    animation.beginTime = CACurrentMediaTime() + 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.layer addSublayer:[self creatShapeLayerByPath:path andColor:[UIColor colorWithRed:200/255.0 green:20/255.0 blue:20/255.0 alpha:1] addAnimation:animation]];
    });
}

- (CAShapeLayer *)creatShapeLayerByPath:(UIBezierPath *)path andColor:(UIColor *)color addAnimation:(CAAnimationGroup *)animation {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = path.bounds;
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = 0.2;
    [shapeLayer addAnimation:animation forKey:nil];
    return shapeLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
