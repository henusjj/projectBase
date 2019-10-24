//
//  ButtonDelayTimeController.m
//  Project framework
//
//  Created by shijingjing on 2019/10/21.
//  Copyright © 2019 ZXY. All rights reserved.
//

#import "ButtonDelayTimeController.h"
#import "UIControl+PQ_EventExtension.h"
#import "UIButton+ImageTitleSpacing.h"

@interface ButtonDelayTimeController ()
@property(nonatomic,strong)UIButton *delayBtn;
@property(nonatomic,strong)UIButton *BtnStyle;
@end

@implementation ButtonDelayTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.delayBtn];
    self.delayBtn.pq_delayButtonInterVal = 3.0;
    
    [self.view addSubview:self.BtnStyle];
    
    [self.BtnStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@50);
        make.height.equalTo(@70);
    }];

    [self.BtnStyle setImage:[UIImage imageNamed:@"ic"] forState:UIControlStateNormal];
//    [self.BtnStyle layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:7];
}
-(void)clickme:(UIButton *)sender{
    
}
-(UIButton *)delayBtn{
    if (!_delayBtn) {
        _delayBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 30)];
        [_delayBtn setTitle:@"不可连续点击" forState:UIControlStateNormal];
        [_delayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_delayBtn addTarget:self action:@selector(clickme:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delayBtn;
}

- (UIButton *)BtnStyle{
    if (!_BtnStyle) {
        _BtnStyle =[[UIButton alloc]init];//WithFrame:CGRectMake(0, 0, 50, 70)];//需要提前设置frame
        _BtnStyle.backgroundColor=[UIColor yellowColor];
        _BtnStyle.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_BtnStyle setTitle:@"年检" forState:UIControlStateNormal];
//        [_BtnStyle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _BtnStyle;
}
@end
