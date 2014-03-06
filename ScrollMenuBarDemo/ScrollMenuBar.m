//
// Created by 崇史 on 2014/03/03.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ScrollMenuBar.h"
#import "Menu.h"
#import "UIColor+Hex.h"


@implementation ScrollMenuBar {
    UIScrollView *_scrollView ;
    UIView *_separateView ;
    NSArray *_array ;
    NSArray *_tabs ;
}
static CGFloat const VIEW_HEIGHT = 40.0 ;
static CGFloat const VIEW_WIDTH = 320.0 ;
static CGFloat const TAB_HEIGHT = 35.0 ;
static CGFloat const SEPARATE_VIEW_HEIGHT = 2.0 ;
static NSInteger const TAG_TAB_BASE = 1000;
-(id)initWithArray:(NSArray *)array point:(CGPoint)point {
    CGRect frame = CGRectMake(point.x, point.y , VIEW_WIDTH, VIEW_HEIGHT) ;
    self = [super initWithFrame:frame] ;
    if(self){
        _array = array ;
        _tabs = nil ;
        [self initScrollView];
    }
    return self ;
}
-(void)initScrollView{
    CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT) ;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame] ;
    scrollView.showsHorizontalScrollIndicator = NO ;
    [self addSubview:scrollView];
    _scrollView = scrollView ;

    int i = 0 ;
    NSMutableArray *array = [NSMutableArray new];
    CGFloat offsetX = 0 ;
    for (NSDictionary *menu in _array){
        Menu *tab = [[Menu alloc] initWithString:[menu valueForKey:@"title"]
                                         color:[menu objectForKey:@"color"]
                                         ] ;
//        NSLog(@"OFF:%f",offsetX);
//        NSLog(@"H%f",CGRectGetWidth(tab.frame)) ;
        tab.frame = CGRectMake(offsetX, 3, CGRectGetWidth(tab.bounds), CGRectGetHeight(tab.bounds)) ;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabTaped:)] ;
        [tab addGestureRecognizer:recognizer];
        tab.tag = [self tagWithIndex:i] ;
        [scrollView addSubview:tab];
        [array addObject:tab];
//        NSLog(@"H%f",CGRectGetWidth(tab.frame)) ;
        offsetX += CGRectGetWidth(tab.bounds) ;
        i++ ;
    }
    scrollView.contentSize = CGSizeMake( offsetX ,VIEW_HEIGHT- SEPARATE_VIEW_HEIGHT) ;

    [self initSeparateView:offsetX];
}

-(NSInteger)tagWithIndex:(NSInteger)index{
    return TAG_TAB_BASE + index ;
}
-(NSInteger)indexWithTag:(NSInteger)tag{
    return tag - TAG_TAB_BASE ;
}

-(void)tabTaped:(UITapGestureRecognizer *)recognizer{
    for (Menu *view in _tabs){
        view.isSelected = NO ;
    }

    Menu *tab = recognizer.view ;
    tab.isSelected = YES ;

    // 選択中のタブを全面に出す
    NSInteger selectedTabIndex = [_scrollView.subviews indexOfObject:tab] ;
    NSInteger separateViewIndex = [_scrollView.subviews indexOfObject:_separateView] ;
    NSInteger lastIndex = [_scrollView.subviews indexOfObject:[_scrollView.subviews lastObject]] ;
    [_scrollView exchangeSubviewAtIndex:separateViewIndex withSubviewAtIndex:lastIndex-1];
    [_scrollView exchangeSubviewAtIndex:selectedTabIndex withSubviewAtIndex:lastIndex];

    // セパレターの色を替える
    _separateView.backgroundColor = tab.color ;

    // オフセット計算
    CGFloat offsetX = tab.frame.origin.x + tab.frame.size.width/2 - VIEW_WIDTH/2 ;
//    NSLog(@"_W:%f", _scrollView.contentSize.width );
//    NSLog(@"origin.x:%f",tab.frame.origin.x) ;
//    NSLog(@"size.width:%f",tab.frame.size.width) ;
//    NSLog(@"offsetX:%f",offsetX) ;
    if(offsetX <= 0){
        offsetX = 0 ;
    } else if (offsetX >= _scrollView.contentSize.width - VIEW_WIDTH ){
        offsetX = _scrollView.contentSize.width - VIEW_WIDTH ;
    }
    CGPoint point = CGPointMake(offsetX, 0);
    [_scrollView setContentOffset:point animated:YES];

    // 通知
    NSLog(@"SELECT") ;
    [self.delegate scrollMenuBar:self selected:[self indexWithTag:tab.tag]];
}


-(void)initSeparateView:(CGFloat)width{
//    NSLog(@"W:%f",width) ;
    CGRect frame = CGRectMake(-640, VIEW_HEIGHT - SEPARATE_VIEW_HEIGHT, width + 640*2, SEPARATE_VIEW_HEIGHT ) ;
    UIView *view = [[UIView alloc] initWithFrame:frame] ;
    view.layer.shadowOpacity = 0.5f ;
    view.layer.shadowColor = [UIColor grayColor].CGColor ;
    view.layer.shadowOffset = CGSizeMake(0, -2) ;
    view.layer.shadowRadius = 1 ;
    [_scrollView addSubview:view];
    view.backgroundColor = [UIColor greenColor] ;

    _separateView = view ;
}
//-(void)layoutSubviews {
////    NSLog(@"%s", __func__) ;
//}

+(UIColor*)smartYellow{
    return [UIColor colorWithHexString:@"FFCC00FF"] ;
}
+(UIColor*)smartBlue{
    return [UIColor colorWithHexString:@"34AADCFF"] ;
}
+(UIColor*)smartGreen{
    return [UIColor colorWithHexString:@"4CD964FF"] ;
}
+(UIColor*)smartRed{
    return [UIColor colorWithHexString:@"FF3B30FF"] ;
}
+(UIColor*)smartOrange{
    return [UIColor colorWithHexString:@"FF9500FF"] ;
}
+(UIColor*)smartGray{
    return [UIColor colorWithHexString:@"BDBEC2FF"] ;
}
+(UIColor*)smartPurple{
    return [UIColor colorWithHexString:@"C643FCFF"] ;
}

@end