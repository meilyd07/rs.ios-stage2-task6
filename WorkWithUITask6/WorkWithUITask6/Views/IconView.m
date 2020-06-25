//
//  IconView.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/19/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "IconView.h"
#import "UIColor+HexColors.h"
#import <QuartzCore/QuartzCore.h>

@implementation IconView

-(instancetype)initWithFrame:(CGRect)frame WithType:(IconViewType)type andColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _color = color;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    switch (self.type) {
        case IconViewCircle:
            [self drawCircle:rect];
            break;
        case IconViewRectangle:
            [self drawRectangle:rect];
            break;
        case IconViewTriangle:
            [self drawTriangle:rect];
            break;
    }
}

- (void)drawCircle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0,0,rect.size.width,rect.size.height));
}

- (void)drawRectangle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, self.color.CGColor);
    
    CGContextFillRect(context, rect);
}

- (void)drawTriangle:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, self.color.CGColor);
    
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextFillPath(context);
}

-(void)animateCircle {
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [zoomAnimation setDuration:0.8];
    [zoomAnimation setRepeatCount:INFINITY];
    [zoomAnimation setFromValue:[NSNumber numberWithFloat:0.9]];
    [zoomAnimation setToValue:[NSNumber numberWithFloat:1.1]];
    [zoomAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[self layer] addAnimation:zoomAnimation forKey:@"zoom"];
}

-(void)animateRectangle {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    theAnimation.duration = 1.0;
    theAnimation.repeatCount = INFINITY;

    theAnimation.fromValue= [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y-7)];
    theAnimation.toValue= [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y+7)];
    [theAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [[self layer] addAnimation:theAnimation forKey:@"animatePosition"];
}

-(void)animateTriangle {
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = 8.0f;
    animation.repeatCount = INFINITY;
    [self.layer addAnimation:animation forKey:@"SpinAnimation"];
}

- (void)animateView {
    switch (self.type) {
        case IconViewCircle:
            [self animateCircle];
            break;
        case IconViewRectangle:
            [self animateRectangle];
            break;
        case IconViewTriangle:
            [self animateTriangle];
            break;
    }
}

@end
