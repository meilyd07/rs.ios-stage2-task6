//
//  IconView.h
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/19/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, IconViewType) {
    IconViewCircle = 0,
    IconViewRectangle = 1,
    IconViewTriangle = 2
};


@interface IconView : UIView
@property (nonatomic, assign) IconViewType type;
@property (nonatomic, strong) UIColor *color;
-(instancetype)initWithFrame:(CGRect)frame WithType:(IconViewType)type andColor:(UIColor *)color;
- (void)animateView;
@end

NS_ASSUME_NONNULL_END
