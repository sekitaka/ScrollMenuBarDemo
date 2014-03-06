//
// Created by 崇史 on 2014/03/03.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScrollMenuBar;

@protocol ScrollMenuBarDelegate
-(void)scrollMenuBar:(ScrollMenuBar *)scrollMenuBar selected:(NSInteger)selectedIndex ;
@end

@interface ScrollMenuBar : UIView
@property (nonatomic, weak)id<ScrollMenuBarDelegate> delegate ;
- (id)initWithArray:(NSArray *)array point:(CGPoint)point;

+ (UIColor *)smartYellow;

+ (UIColor *)smartBlue;

+ (UIColor *)smartGreen;

+ (UIColor *)smartRed;

+ (UIColor *)smartOrange;

+ (UIColor *)smartGray;

+ (UIColor *)smartPurple;
@end