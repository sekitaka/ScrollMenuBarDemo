//
// Created by 崇史 on 2014/03/03.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Menu;

@interface Menu : UIView
- (id)initWithString:(NSString *)string color:(UIColor *)color frame:(CGRect)frame;

- (id)initWithString:(NSString *)string color:(UIColor *)color;

- (void)select ;
- (void)deselect ;
@property (nonatomic)UILabel *titleLabel ;
@property (nonatomic)BOOL isSelected ;
@property (nonatomic)UIColor *color ;
@end