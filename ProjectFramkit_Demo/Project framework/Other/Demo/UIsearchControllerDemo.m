//
//  UIsearchControllerDemo.m
//  Project framework
//
//  Created by shijingjing on 2019/10/18.
//  Copyright © 2019 ZXY. All rights reserved.
//

#import "UIsearchControllerDemo.h"

@interface UIsearchControllerDemo ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UISearchController *searchView;
@property(nonatomic,strong)UITableView *searchTableView;
// 数据源数组
@property (nonatomic, strong) NSMutableArray *datas;
// 搜索结果数组
@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation UIsearchControllerDemo


#pragma mark -  layze

- (UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _searchTableView.delegate=self;
        _searchTableView.dataSource=self;
//        空界面展示
        _searchTableView.emptyDataSetSource=self;
        _searchTableView.emptyDataSetDelegate=self;
    }
    return _searchTableView;
}
- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithCapacity:0];
    }
    return _datas;
}
- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    return _results;
}

- (UISearchController *)searchView{
    if (!_searchView) {
//      创建UISearchController, 这里使用当前控制器来展示结果，controller为nil，如果不是当前控制器，就是新建TableviewController，传值
//        搜索框+table初始化
        _searchView =[[UISearchController alloc]initWithSearchResultsController:nil];
//      searchResultsUpdater设置结果更新代理
        _searchView.searchResultsUpdater = self;
//        因为在当前控制器展示结果，所以不需要这个透明视图
        _searchView.dimsBackgroundDuringPresentation=NO;
//        设置是否隐藏导航栏
        _searchView.hidesNavigationBarDuringPresentation = YES ;
    _searchView.searchBar.barTintColor=self.navigationController.navigationBar.barTintColor;//先把颜色设置成导航颜色
        //      这是将searchBar 下面的线去掉
          [_searchView.searchBar setBackgroundImage:[self  createImageWithColor:self.navigationController.navigationBar.barTintColor]];
        self.searchView.searchBar.backgroundColor = CNavBgColor;
        //添加一张白色的图片(方法自己上网搜索)
        UIImage *image =[UIImage imageWithColor:[UIColor whiteColor]];
              //把白色的图片弄成自己想要的样子(图片处理大小和切圆角,方法自己上网搜索)
        image = [self createRoundedRectImage:image size:CGSizeMake(self.view.frame.size.width, 34) radius:34/2];;
        [_searchView.searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
//       导航栏隐藏时偏移-64解决方法
        self.definesPresentationContext = YES;

        self.searchTableView.tableHeaderView =_searchView.searchBar;
    }
    return _searchView;
}



/**
 *UISearchController设置导航栏隐藏时偏移-64解决方法
 *这行代码是声明，哪个viewcontroller显示UISearchController，苹果开发中心的demo中的对这行代码，注释如下
 // know where you want UISearchController to be displayed
 a、如果不添加上面这行代码，在设置hidesNavigationBarDuringPresentation这个属性为YES的时候，搜索框进入编辑模式会导致，searchbar不可见，偏移-64;
 在设置为NO的时候，进入编辑模式输入内容会导致高度为64的白条，猜测是导航栏没有渲染出来
 b、如果添加了上面这行代码，在设置hidesNavigationBarDuringPresentation这个属性为YES的时候，输入框进入编辑模式正常显示和使用;在设置为NO的时候，搜索框进入编辑模式导致向下偏移64作者：不会算卦的杨大仙
 链接：https://www.jianshu.com/p/012b0d08db90
 *self.definesPresentationContext = YES;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索框";
    for (int i = 0; i < 100; i++) {
        NSString *str = [NSString stringWithFormat:@"测试数据%d", i];
        [self.datas addObject:str];
    }
    
    [self.view addSubview:self.searchTableView];

}

#pragma mark -  tableView&delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchView.active) {
        
        return self.results.count;
    }
    
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchView.active ) {
        cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchView.active) {
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
    } else {
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
    }
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            [self.results addObject:str];
        }
    }
    
    [self.searchTableView reloadData];
}


#pragma mark -----DZNEmptyDataSet source delegate ，列表空数据的展示
#pragma mark - DZNEmptyDataSetSource
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    if (![CXDAppDotNetAPIClient sharedClient].reachabilityManager.isReachable) {无网
//        return [UIImage imageNamed:@"emptyView_noNet_bgimg"];
//    }
    return [UIImage imageNamed:@"emptyView_noData_bgimg"];
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -Height_NavBar;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
//    [self getNetData];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

-(void)dealloc{
    DLog(@"delloc----%@",NSStringFromClass([self class]));
}

//把颜色转成image
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UIImage*)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)radius{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    UIImage*img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect =CGRectMake(0,0, w, h);
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    return img;

}
static void addRoundedRectToPath(CGContextRef context,CGRect rect,float ovalWidth,float ovalHeight){

    float fw, fh;
    if( ovalWidth ==0|| ovalHeight ==0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw =CGRectGetWidth(rect) / ovalWidth;
    fh =CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh,1);  // Top right corner
    CGContextAddArcToPoint(context,0, fh,0, fh/2,1);// Top left corner
    CGContextAddArcToPoint(context,0,0, fw/2,0,1);// Lower left corner
    CGContextAddArcToPoint(context, fw,0, fw, fh/2,1);// Back to lower right
    CGContextClosePath(context);
    CGContextRestoreGState(context);

}

//设置状态栏背景颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication].delegate.window valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
@end
