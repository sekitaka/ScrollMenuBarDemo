//
// Created by 崇史 on 2014/03/03.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "Menu.h"


@implementation Menu {
    NSString *_title ;
}
static CGFloat const VIEW_WIDTH = 80.0 ;
static CGFloat const MIN_VIEW_WIDTH = 70.0 ;
static CGFloat const MAX_VIEW_WIDTH = 110.0 ;
static CGFloat const VIEW_HEIGHT = 35.0 ;
static CGFloat const TITLE_MARGIN = 5.0 ;

-(id)initWithString:(NSString *)string color:(UIColor *)color frame:(CGRect)frame{
    self = [super initWithFrame:frame] ;
    if(self){
        _title = string ;
        _color = color ;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initTitleLabel];
    }
    return self ;
}
-(id)initWithString:(NSString *)string color:(UIColor *)color{
    self = [super init];
    if(self){
        _title = string ;
        _color = color ;
        [self setBackgroundColor:[UIColor clearColor]];
        [self initTitleLabel];
        [self calcLayout];
    }
    return self ;
}
-(void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"%s", __func__) ;
//    _titleLabel.frame = CGRectInset(self.bounds, 2, 5) ;
//    self.frame = CGRectMake(0, 5, MIN_VIEW_WIDTH, VIEW_HEIGHT) ;
    [self calcLayout];
}
-(void)calcLayout{
    CGFloat width = CGRectGetWidth(_titleLabel.frame) + TITLE_MARGIN*2 ;
    if(width <= MIN_VIEW_WIDTH){
        width = MIN_VIEW_WIDTH ;
    } else if (width >= MAX_VIEW_WIDTH){
        width = MAX_VIEW_WIDTH ;
    }
    _titleLabel.center = CGPointMake(width/2, VIEW_HEIGHT/2) ;
    self.bounds = CGRectMake(0, 0, width , VIEW_HEIGHT) ;
}
-(void)initTitleLabel{
//    NSLog(@"%s", __func__) ;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.opaque = NO;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabel.shadowOffset = CGSizeMake(0, -0.5);
    _titleLabel.numberOfLines = 1 ;
//    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping ;
    _titleLabel.adjustsFontSizeToFitWidth = YES ;
    _titleLabel.text = _title ;
    CGSize size = [_titleLabel sizeThatFits:CGSizeMake(1000, VIEW_HEIGHT - 10)] ;
    CGFloat width = size.width ;
    if(width >= MAX_VIEW_WIDTH - TITLE_MARGIN*2) {
        width = MAX_VIEW_WIDTH - TITLE_MARGIN*2 ;
    }
    _titleLabel.frame = CGRectMake(TITLE_MARGIN, 5, width, VIEW_HEIGHT - TITLE_MARGIN*2) ;
//    NSLog(@"TEXT_WIDTH:%f",size.width) ;
    [self addSubview:_titleLabel];
}
-(void)drawRect:(CGRect)rect {
//    NSLog(@"%s", __func__) ;
//    NSLog(@"%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawBoarder:context];
    [self drawBody:context];
    return ;
}

-(void)drawBody:(CGContextRef)context{
    CGRect rect = self.bounds ;
    CGContextSaveGState(context) ;

    CGFloat radius = 9.0f ;
    CGFloat width = 1.0f ;
    CGContextSetFillColorWithColor(context, _color.CGColor) ;
    CGContextBeginPath(context);

    // 点Aに移動
    CGContextMoveToPoint( context, CGRectGetMinX(rect) + width, CGRectGetMaxY(rect));

    // 直線ABと直線BCを指定した半径で、スムーズにつなぐ円弧パスを追加
    CGContextAddArcToPoint( context, CGRectGetMinX(rect) + width, CGRectGetMinY(rect) + width, // 点B
            CGRectGetMidX(rect), CGRectGetMinY( rect ) + width,  // 点C
            radius );

    // 直線CDと直線DEを指定した半径で、スムーズにつなぐ円弧パスを追加
    CGContextAddArcToPoint( context, CGRectGetMaxX( rect ) - width, CGRectGetMinY( rect ) + width, // 点D
            CGRectGetMaxX( rect ) - width , CGRectGetMidY( rect ),  // 点E
            radius );

    // 点Eから点Fまでの直線のパスを追加
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - width , CGRectGetMaxY(rect)) ; // 点F
    CGContextClosePath( context );
    CGContextFillPath(context) ;

    CGContextRestoreGState(context) ;
}

-(void)drawBoarder:(CGContextRef)context{
    CGRect rect = self.bounds ;
    CGContextSaveGState(context) ;

    CGFloat radius = 10.0f ;
    CGContextSetFillColorWithColor(context, [self boarderColor].CGColor) ;
    CGContextBeginPath(context);

    // 点Aに移動
    CGContextMoveToPoint( context, CGRectGetMinX(rect), CGRectGetMaxY(rect));

    // 直線ABと直線BCを指定した半径で、スムーズにつなぐ円弧パスを追加
    CGContextAddArcToPoint( context, CGRectGetMinX(rect), CGRectGetMinY(rect), // 点B
            CGRectGetMidX(rect), CGRectGetMinY( rect ),  // 点C
            radius );

    // 直線CDと直線DEを指定した半径で、スムーズにつなぐ円弧パスを追加
    CGContextAddArcToPoint( context, CGRectGetMaxX( rect ), CGRectGetMinY( rect ), // 点D
            CGRectGetMaxX( rect ), CGRectGetMidY( rect ),  // 点E
            radius );

    // 点Eから点Fまでの直線のパスを追加
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect)) ; // 点F
    CGContextClosePath( context );
    CGContextFillPath(context) ;

    CGContextRestoreGState(context) ;
}

// ボーダーの色を取得する
// 基本は暗くする
-(UIColor *)boarderColor{
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [_color getRed:&red green:&green blue:&blue alpha:&alpha] ;
    UIColor *color = [UIColor colorWithRed:red*0.8 green:green*0.8 blue:blue*0.8 alpha:alpha] ;
    return color ;
}

-(CGFloat)validateColorElement:(CGFloat)val{
    return 0 ;
}
@end