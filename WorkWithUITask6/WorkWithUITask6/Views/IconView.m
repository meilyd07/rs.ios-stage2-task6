//
//  IconView.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/19/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "IconView.h"
#import "UIColor+HexColors.h"

@interface IconView()
@property (nonatomic, assign) IconViewType type;
@property (nonatomic, strong) UIColor *color;
@end

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

@end
