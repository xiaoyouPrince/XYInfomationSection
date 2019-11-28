//
//  UIView+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UIView+XYAdd.h"

/// 一个渐变色View，内部封装了一个 CAGradientLayer
@interface XYGradientView : UIView
/** 内部强引用的一个渐变layer */
@property(nonatomic , strong)  CAGradientLayer *gradientLayer;
/** 渐变色数组 */
@property(nonatomic , strong)     NSArray<UIColor *> *gradientColors;
@end
@implementation XYGradientView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.gradientLayer = [CAGradientLayer new];
        self.gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(1, 0);
        self.gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [self.layer addSublayer:_gradientLayer];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setGradientColors:(NSArray<UIColor *> *)colors
{
    if (colors.count > 1) { // 至少是两种颜色
        
        NSMutableArray *CGColors = @[].mutableCopy;
        for (UIColor *color in colors) {
            [CGColors addObject:(id)[color CGColor]];
        }
        
        CAGradientLayer *gradientLayer = self.gradientLayer;
        gradientLayer.frame = self.layer.bounds;
        [gradientLayer setColors:CGColors];//渐变数组
    }
}

@end


@implementation UIView (XYAdd)


#pragma mark --- frame相关
- (void)setXy_x:(CGFloat)xy_x
{
    CGRect frame = self.frame;
    frame.origin.x = xy_x;
    self.frame = frame;
}

- (CGFloat)xy_x
{
    return self.frame.origin.x;
}

- (void)setXy_y:(CGFloat)xy_y
{
    CGRect frame = self.frame;
    frame.origin.y = xy_y;
    self.frame = frame;
}

- (CGFloat)xy_y
{
    return self.frame.origin.y;
}

- (void)setXy_centerX:(CGFloat)xy_centerX
{
    CGPoint center = self.center;
    center.x = xy_centerX;
    self.center = center;
}

- (CGFloat)xy_centerX
{
    return self.center.x;
}

- (void)setXy_centerY:(CGFloat)xy_centerY
{
    CGPoint center = self.center;
    center.y = xy_centerY;
    self.center = center;
}


- (CGFloat)xy_centerY
{
    return self.center.y;
}

- (void)setXy_width:(CGFloat)xy_width
{
    CGRect frame = self.frame;
    frame.size.width = xy_width;
    self.frame = frame;
}

- (CGFloat)xy_width
{
    return self.frame.size.width;
}

- (void)setXy_height:(CGFloat)xy_height
{
    CGRect frame = self.frame;
    frame.size.height = xy_height;
    self.frame = frame;
}

- (CGFloat)xy_height
{
    return self.frame.size.height;
}

- (CGFloat)xy_top
{
    return self.xy_y;
}

- (void)setXy_top:(CGFloat)xy_top
{
    [self setXy_y:xy_top];
}


- (CGFloat)xy_left
{
    return self.xy_x;
}

- (void)setXy_left:(CGFloat)xy_left
{
    [self setXy_x:xy_left];
}

- (CGFloat)xy_right
{
    return self.xy_x + self.xy_width;
}

- (void)setXy_right:(CGFloat)xy_right
{
    [self setXy_x:xy_right - self.xy_width];
}


- (CGFloat)xy_bottom
{
    return self.xy_y + self.xy_height;
}

- (void)setXy_bottom:(CGFloat)xy_bottom
{
    [self setXy_y:xy_bottom - self.xy_height];
}


- (void)setXy_origin:(CGPoint)xy_origin
{
    CGRect frame = self.frame;
    frame.origin = xy_origin;
    self.frame = frame;
}

- (CGPoint)xy_origin
{
    return self.frame.origin;
}

- (void)setXy_size:(CGSize)xy_size
{
    CGRect frame = self.frame;
    frame.size = xy_size;
    self.frame = frame;
}

- (CGSize)xy_size
{
    return self.frame.size;
}
#pragma mark --- frame相关

+ (instancetype)xy_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)xy_setGradientColors:(NSArray <UIColor *> *)colors{
    
    if (colors.count > 1) { // 至少是两种颜色
        
        
        XYGradientView *gradientView = nil;
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:XYGradientView.class]) {
                gradientView = (XYGradientView *)subView;
            }
        }
        if (gradientView == nil) {
            gradientView = [[XYGradientView alloc] initWithFrame:self.bounds];
            [self insertSubview:gradientView atIndex:0];
        }
        
        [gradientView setGradientColors:colors];
        
        
        
        return;
        
//        NSMutableArray *CGColors = @[].mutableCopy;
//        for (UIColor *color in colors) {
//            [CGColors addObject:(id)[color CGColor]];
//        }
//
//        CAGradientLayer *gradientLayer = nil;
//        for (CALayer *subLayer in self.layer.sublayers) {
//            if ([subLayer isKindOfClass:CAGradientLayer.class]) {
//                gradientLayer = (CAGradientLayer *)subLayer;
//            }
//        }
//        if (gradientLayer == nil) {
//            gradientLayer = [CAGradientLayer new];
//            [self.layer addSublayer:gradientLayer];
//        }
//        gradientLayer.frame = self.layer.bounds;
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//        [gradientLayer setColors:CGColors];//渐变数组
    }
}

@end
