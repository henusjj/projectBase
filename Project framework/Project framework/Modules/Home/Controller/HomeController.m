//
//  HomeController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
//    UIView *views=[[UIView alloc]init];
//    [kAppWindow addSubview:views];
//    [views mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.view);
//        make.height.width.equalTo(@100);
//    }];
    UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(0, 90, 100, 100)];
    bt.backgroundColor=[UIColor yellowColor];
    [bt addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
}
-(void)push{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [kAppWindow.rootViewController.view makeToast:@"111"];
    UIView *views=[[UIView alloc]init];
    views.backgroundColor=[UIColor redColor];
    [kAppWindow.rootViewController.view addSubview:views];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.width.equalTo(@100);
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}


@end
