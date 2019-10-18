//
//  ViewController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/30.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "ViewController11.h"
#import "NetworkAPI.h"

@interface ViewController11 ()<NetworkDeleagte>

@end

@implementation ViewController11
/**
 * 基类包含  RootviewController（包含 tableView collectionView的懒加载）
 RootWebcontroller（有js交互类xlhandler）
 RootNavgationVController（背景颜色）
 MainTabbarController（第三方的Tabbar）
 *
 */

/**
* 宏定义
*1.快捷创建单例对象  LFYSingleton   用法 LFYSingletonH    LFYSingletonM   示例可以再网络封装代理查看
*2.第三方库，t头文件，系统单例，颜色，适配大小
*/


/**
* 关于界面空界面的
1··如果集成的是RootviewController ，有列表需要展示空界面，
则在 子类 [self  addEmptyView];

 2··如果是子视图的列表， 以tableView为例， 可以直接继承协议
//  DZNEmptyDataSetSource;
 // DZNEmptyDataSetDelegate;
 // _tableview.emptyDataSetSource = self;
 //_tableview.emptyDataSetDelegate = self;
  或者使用tableView的base基类
 collection同理
*
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * 网络请求用法
     * GlobeConst  接口全局变量
        NetworkAPI  代理回调
        PPNetworkHelper  block回调 内含yycache 缓存
     */

    [NetworkAPI shareInstance].delegate=self;
    
    [NetworkAPI GET:@"" andWithParam:@{@"key":@"2"}];
}
-(void)requestSucesses:(id)responseData{
}
-(void)requestError:(NSError *)error{
}
/**  PPNetworkHelper
 #pragma mark ====== 加载数据 ======
 - (void)loadNewData {
 __weak __typeof(self) ws = self;
 NSDictionary *paraDic = @{@"pdduid": @"6344734573"};
 [PPNetworkHelper POST:[KSHomeUrl getHomePageUrl] parameters:paraDic responseCache:^(id responseCache) {
 [ws resultData:responseCache];
 } success:^(id responseObject) {
 [ws resultData:responseObject];
 } failure:^(NSError *error) {
 [self ks_toastString:@"网络不给力"];
 }];
 }
 
 - (void)resultData:(id)responseObject {
 [self.dataAry removeAllObjects];
 __weak __typeof(self) ws = self;
 for (NSDictionary *dic in responseObject) {
 KSHomeModel *model = [KSHomeModel modelWithJSON:dic];
 [ws.dataAry addObject:model];
 }
 [ws.tableView reloadData];
 [ws.collectionView reloadData];
 [ws defaultSelectFirstRow];
 }
 **/
#pragma mark -  个人信息存储用法




/**
 * 个人信息存储用法
 * 在vc中使用示例
 //1.通过UserInfoManager的configInfo：接口进行信息的配置
 [UserInfoManager configInfo:infoDic];
 
 //2.通过用户管理工具类使用用户信息；例如：通过判断userID是否有值，判断用户是否为登录状态
 if([[UserInfoManager shareUser] userID]) {
 
 NSLog(@"用户处于登录状态--用户的真实姓名为：%@",[[UserInfoManager shareUser] userName]);
 
 }else{
 
 NSLog(@"用户处于非登录状态，进行非登录状态的处理");
 }
 
 //3.对用户的信息进行更新(适应场景：用户修改了昵称或者头像。。。)
 NSLog(@"没更新昵称前：%@",[[UserInfoManager shareUser]userName]);
 
 //对昵称属性进行更新
 [[UserInfoManager shareUser]setUserName:@"狗蛋"];
 
 NSLog(@"昵称更新之后：%@",[[UserInfoManager shareUser]userName]);
 
 //4.退出登录
 [UserInfoManager loginOut];
 *
 */


#pragma mark -  RootWebcontroller

/**
 * RootWebcontroller de 用法
 *
 RootwebView 可以作为基类，统一调用h5界面，
 也可以集成rootwebView，重新写子类，然后调用父类a方法
 
 RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:@"http://hao123.com"];
 webView.isShowCloseBtn = YES;
 RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:webView];
 [self presentViewController:loginNavi animated:YES completion:nil];
 
 //push
 //    RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:@"http://hao123.com"];
 //    [webView addNavigationItemWithTitles:@[@"测试"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1003]];
 //    [self.navigationController pushViewController:webView animated:YES];
 
 与js交互
 
 在xlweb 父类中 通过调用-(instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;
 方法， 此方法在 xljshandler.h 中的公共类中， 因此可以在 此类中写所有的h5jsj调用navctive方法，统一管理
 */


@end
