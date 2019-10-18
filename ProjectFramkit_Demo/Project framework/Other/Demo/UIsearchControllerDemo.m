//
//  UIsearchControllerDemo.m
//  Project framework
//
//  Created by shijingjing on 2019/10/18.
//  Copyright © 2019 ZXY. All rights reserved.
//

#import "UIsearchControllerDemo.h"

@interface UIsearchControllerDemo ()
@property(nonatomic,strong)UISearchController *searchVC;

@end

@implementation UIsearchControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark -  layze
- (UISearchController *)searchVC{
    if (!_searchVC) {
        _searchVC =[[UISearchController alloc]init];
    }
}

@end
