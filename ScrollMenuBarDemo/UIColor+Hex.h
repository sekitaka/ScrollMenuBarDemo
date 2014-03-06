//
// Created by 崇史 on 2014/03/05.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHex:(uint32_t)hex;
+ (UIColor*)colorWithHexString:(NSString*)string;
@end