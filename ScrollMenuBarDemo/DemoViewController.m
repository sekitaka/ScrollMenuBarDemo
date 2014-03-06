//
// Created by 崇史 on 2014/03/06.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "DemoViewController.h"
#import "ScrollMenuBar.h"


@implementation DemoViewController {
    UILabel *_label ;

}
-(void)viewDidLoad {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    self.view.backgroundColor = [UIColor whiteColor] ;


    // メニューバー追加
    NSArray *menus = @[
            @{
                    @"title":@"トップ",
                    @"color":[ScrollMenuBar smartYellow]
            }, @{
                    @"title":@"エンタメ",
                    @"color":[ScrollMenuBar smartGreen]
            }, @{
                    @"title":@"スポーツ",
                    @"color":[ScrollMenuBar smartRed]
            }, @{
                    @"title":@"テクノロジー",
                    @"color":[ScrollMenuBar smartBlue]
            }, @{
                    @"title":@"政治",
                    @"color":[ScrollMenuBar smartOrange]
            }, @{
                    @"title":@"経済",
                    @"color":[ScrollMenuBar smartPurple]
            }, @{
                    @"title":@"設定",
                    @"color":[ScrollMenuBar smartGray]
            },
    ] ;
    ScrollMenuBar *scrollMenuBar = [[ScrollMenuBar alloc] initWithArray:menus
                                                            point:CGPointMake(0, 20)] ;
    scrollMenuBar.delegate = self ;
    [self.view addSubview:scrollMenuBar];

    // 確認ラベル
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] ;
    label.numberOfLines = 2 ;
    label.font = [UIFont systemFontOfSize:30] ;
    label.center = self.view.center ;
    label.text = @"Click menu" ;
    label.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:label];
    _label = label ;
}

-(void)scrollMenuBar:(ScrollMenuBar *)scrollMenuBar selected:(NSInteger)selectedIndex {
    NSLog(@"HH") ;
    _label.text = [NSString stringWithFormat:@"index:%d Clicked",selectedIndex] ;
}
@end