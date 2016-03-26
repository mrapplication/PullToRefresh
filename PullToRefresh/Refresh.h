//
//  Refresh.h
//  PullToRefresh
//
//  Created by Milad Shokrkhah on 3/26/16.
//  Copyright © 2016 com.mrapplication. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Refresh : UIView

@property (nonatomic, strong) CAShapeLayer *animationLayerStrokePath;
@property (nonatomic, strong) CAShapeLayer *animationLayerCirclePath;

@property (nonatomic, strong) UIBezierPath *strokePath;
@property (nonatomic, strong) UIBezierPath *circlePath;

- (void)drawRefreshShapes;
- (void)animateRefreshShapes;

@end
