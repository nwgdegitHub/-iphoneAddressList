//
//  CYLSearchMainViewController.m
//  CYLSearchViewController
//
//  Created by http://weibo.com/luohanchenyilong/ on 15/4/29.
//  Copyright (c) 2015年 https://github.com/ChenYilong/CYLSearchViewController . All rights reserved.

//  此控制器是作者测试用的 , 使用时搞一个ViewController, 实现UISearchBar的代理方法 ，调用CYLSearchController对象的showInViewController方法即可引入搜索框架

//View Controllers
#import "CYLSearchMainViewController.h"
#import "CYLSearchController.h"
//Views
#import "CYLSearchBar.h"

@interface CYLSearchMainViewController ()
<
CYLSearchControllerDelegate,
UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource
>
{
    NSMutableArray *dataArray;
    UITableView *table;
}
@property (nonatomic, strong) UINavigationController *searchController;
@property (nonatomic, strong) CYLSearchBar *searchBar;

@end

@implementation CYLSearchMainViewController

#pragma mark - 💤 LazyLoad Method 熟睡

/**
 *  懒加载_searchBar
 *
 *  @return UISearchBar
 */
- (CYLSearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[CYLSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - ♻️ LifeCycle Method

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];//保证看得到蓝天白云
    [self.view addSubview:self.searchBar];
    self.title = @"通讯录";

}


#pragma mark - 🔌 CYLSearchHeaderViewDelegate Method

- (void)searchHeaderViewClicked:(id)sender {
    CYLSearchController *controller = [[CYLSearchController alloc] initWithNibName:@"CYLSearchController" bundle:nil];
    controller.delegate = self;
    self.searchController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller showInViewController:self];
}

#pragma mark - 🔌 CYLSearchControllerDelegate Method

- (void)questionSearchCancelButtonClicked:(CYLSearchController *)controller
{
    [controller hide:^{
        NSLog(@"questionSearchCancelButtonClicked");
    }];
}

#pragma mark - 🔌 UISearchBarDelegate Method

/**
 *  开始编辑
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self searchHeaderViewClicked:nil];
}


@end
