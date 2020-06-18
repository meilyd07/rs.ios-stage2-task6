//
//  UIColor+HexColors.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/18/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "UIColor+HexColors.h"

@implementation UIColor (HexColors)

+ (UIColor *) colorWithHex:(int)value {
    int redPart = (value >> 16)  & 0xff;
    int greenPart = (value >> 8) & 0xff;
    int bluePart = value & 0xff;
    
    if ((redPart >= 0) && (redPart <= 255) &&
        (greenPart >= 0) && (greenPart <= 255) &&
        (bluePart >= 0) && (bluePart <= 255)
        )
    {
        return [UIColor colorWithRed:(redPart/255.0) green:(greenPart/255.0) blue:(bluePart/255.0) alpha:1];
    } else {
        return nil;
    }
}

+ (UIColor *)customRed {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0xEE686A];
    }
    return color;
}

+ (UIColor *)customBlack {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0x101010];
    }
    return color;
}

+ (UIColor *)customBlue {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0x29C2D1];
    }
    return color;
}

+ (UIColor *)customGreen {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0x34C1A1];
    }
    return color;
}

+ (UIColor *)customYellow {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0xF9CC78];
    }
    return color;
}

+ (UIColor *)customYellowHighlighted {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0xFDF4E3];
    }
    return color;
}

+ (UIColor *)customGrey {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0x707070];
    }
    return color;
}

+ (UIColor *)customWhite {
    static UIColor* color = nil;
    if (color == nil)
    {
        color = [UIColor colorWithHex:0xFFFFFF];
    }
    return color;
}
@end
