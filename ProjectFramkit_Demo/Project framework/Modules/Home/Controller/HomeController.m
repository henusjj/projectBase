//
//  HomeController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "HomeController.h"
#import "UIsearchControllerDemo.h"
#import "ButtonDelayTimeController.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSArray *demoTiTle;
@end

@implementation HomeController

- (void)viewDidLoad {
     NSLog(@"------------%s", __FUNCTION__);
    [super viewDidLoad];
    self.title =@"HomeDome";
    [self bulidUI];
    
    self.demoTiTle = @[@"搜索框",@"button点击等待",@"图片选择器",@"录制视频"];
    

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
    return self.demoTiTle.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"idcell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.textLabel.text=self.demoTiTle[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[UIsearchControllerDemo new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[ButtonDelayTimeController new] animated:YES];
    }
}



#pragma mark --- life circle

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"------------%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
     NSLog(@"------------%s", __FUNCTION__);
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib {
    [super awakeFromNib];
     NSLog(@"------------%s", __FUNCTION__);
}

// 加载视图(默认从nib)
- (void)loadView {
    NSLog(@"------------%s", __FUNCTION__);
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor redColor];
}

//视图控制器中的视图加载完成，viewController自带的view加载完成
//- (void)viewDidLoad {
//    NSLog(@"------------%s", __FUNCTION__);
//    [super viewDidLoad];
//}


//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"------------%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    NSLog(@"------------%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc {
    NSLog(@"------------%s", __FUNCTION__);
}
@end
