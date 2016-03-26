//
//  Refresh.m
//  PullToRefresh
//
//  Created by Milad Shokrkhah on 3/26/16.
//  Copyright © 2016 com.mrapplication. All rights reserved.
//

#import "Refresh.h"

@implementation Refresh

- (void)drawRefreshShapes {
    
    // Calculate middle screen and position
    CGFloat middlePostitonX = [[UIScreen mainScreen] bounds].size.width / 2.0;
    CGPoint position = CGPointMake(middlePostitonX, 30);
    
    // BezierPath path (Stroke)
    self.strokePath = UIBezierPath.bezierPath;
    [self.strokePath moveToPoint:CGPointMake(84, 54)];
    [self.strokePath addCurveToPoint: CGPointMake(70, 40) controlPoint1: CGPointMake(84, 46.27) controlPoint2: CGPointMake(77.73, 40)];
    [self.strokePath addCurveToPoint: CGPointMake(56, 54) controlPoint1: CGPointMake(62.27, 40) controlPoint2: CGPointMake(56, 46.27)];
    [self.strokePath addCurveToPoint: CGPointMake(70, 68) controlPoint1: CGPointMake(56, 61.73) controlPoint2: CGPointMake(62.27, 68)];
    [self.strokePath addCurveToPoint: CGPointMake(84, 54) controlPoint1: CGPointMake(77.73, 68) controlPoint2: CGPointMake(84, 61.73)];
    [self.strokePath closePath];
    [self.strokePath stroke];
    
    // AnimaionLayer for stroke path
    self.animationLayerStrokePath = [CAShapeLayer new];
    self.animationLayerStrokePath.path = self.strokePath.CGPath;
    self.animationLayerStrokePath.fillColor = nil;
    self.animationLayerStrokePath.strokeColor = [UIColor lightGrayColor].CGColor;
    self.animationLayerStrokePath.lineWidth = 2.0;
    self.animationLayerStrokePath.strokeEnd = 0;
    self.animationLayerStrokePath.masksToBounds = YES;
    self.animationLayerStrokePath.anchorPoint = CGPointMake(0.5, 0.5);
    self.animationLayerStrokePath.position = position;
    self.animationLayerStrokePath.bounds = CGPathGetPathBoundingBox(CGPathCreateCopyByStrokingPath(self.animationLayerStrokePath.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4));
    
    // BezierPath path (Circle)
    CGRect circleFrame = CGRectMake(0, 0, 24, 24);
    self.circlePath = [UIBezierPath bezierPathWithOvalInRect:circleFrame];
    
    // AnimaionLayer for circle path
    self.animationLayerCirclePath = [CAShapeLayer new];
    self.animationLayerCirclePath.path = self.circlePath.CGPath;
    self.animationLayerCirclePath.fillColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0].CGColor;
    self.animationLayerCirclePath.masksToBounds = YES;
    self.animationLayerCirclePath.position = position;
    self.animationLayerCirclePath.bounds = CGPathGetPathBoundingBox(CGPathCreateCopyByStrokingPath(self.animationLayerCirclePath.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4));
}

- (void)animateRefreshShapes {
    
    // Animation
    CABasicAnimation *stroke = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stroke.fromValue = [NSNumber numberWithInt:0];
    stroke.toValue = [NSNumber numberWithInt:1.0];
    stroke.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    stroke.duration = 1.5;
    [self.animationLayerStrokePath addAnimation:stroke forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    colorsAnimation.values = [NSArray arrayWithObjects:
                              (id)[UIColor whiteColor].CGColor,
                              (id)[UIColor lightGrayColor].CGColor,
                              (id)[UIColor whiteColor].CGColor,
                              (id)[UIColor colorWithRed:41/255.0f green:85/255.0f blue:115/255.0f alpha:1.0].CGColor, nil];
    colorsAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.25],
                                [NSNumber numberWithFloat:0.5],
                                [NSNumber numberWithFloat:0.75],
                                [NSNumber numberWithFloat:1.0], nil];
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = 1.5f;
    [self.animationLayerStrokePath addAnimation:colorsAnimation forKey:@"strokeColor"];
}

@end
