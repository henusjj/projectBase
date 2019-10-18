//
//  HomeController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "HomeController.h"
#import "UIsearchControllerDemo.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"HomeDome";
    [self bulidUI];
    
    

}

#pragma mark -  BulidUi
-(void)bulidUI{
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -  tableView delegate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"idcell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.textLabel.text=@"uiSearchController";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[UIsearchControllerDemo new] animated:YES];
    }
}
@end
