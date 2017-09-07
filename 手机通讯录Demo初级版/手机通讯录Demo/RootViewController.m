//
//  RootViewController.m
//  手机通讯录Demo
//
//  Created by qianfeng on 15/8/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"
#import "CYLSearchController.h"
//Views
#import "CYLSearchBar.h"

#import "NavigationController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchDisplayDelegate,CYLSearchControllerDelegate>
{
    NSMutableArray *dataArray;
    UITableView *table;
}
@property (nonatomic, strong) UINavigationController *searchController;
@property (nonatomic, strong) CYLSearchBar *searchBar;

@end

@implementation RootViewController

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

-(void)setUpData{
    //创建联系人名字
    NSMutableArray *arrayA=[NSMutableArray arrayWithObjects:@"德玛",@"德邦",@"皇子", nil];
    NSMutableArray *arrayB=[NSMutableArray arrayWithObjects:@"寒冰",@"奥巴马",@"卡利斯塔", nil];
    NSMutableArray *arrayC=[NSMutableArray arrayWithObjects:@"剑圣",@"瞎子",@"梦魇", nil];
    NSMutableArray *arrayD=[NSMutableArray arrayWithObjects:@"卡牌",@"不详",@"三只手", nil];
    NSMutableArray *arrayE=[NSMutableArray arrayWithObjects:@"锤石",@"牛头",@"风女", nil];
    
    dataArray =[NSMutableArray arrayWithObjects:arrayA,arrayB,arrayC,arrayD,arrayE,nil];
}
-(void)setUpUI{
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //设置table
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    UILabel *phoneNum = [[UILabel alloc]initWithFrame:table.tableHeaderView.frame];
    phoneNum.text = @"本机号码:  +86 188-5642-5363";
    [table.tableHeaderView addSubview:phoneNum];
    table.delegate=self;
    table.dataSource= self;
    [self.view addSubview:table];
//    //设置导航栏按钮
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(pressLeft)];
//    
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(pressRight)];
//    
    //设置搜索框
//      [self setUpSearch1];
//      [self setUpSearch2];
//      [self setUpSearch3];
    
    
}

-(void)setUpSearch1{
    //不上移
    //创建搜索条(是按钮？弹出另一个页面才是textField？呵呵，不是的)
    //UISearchBar是系统提供的一个控件 它有一个代理UISearchBarDelegate
    _searchBar = [[CYLSearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _searchBar.delegate=self;
    [self.view addSubview:_searchBar];
}
-(void)setUpSearch2 {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //[self.view addSubview:searchBar];
    table.tableHeaderView = searchBar;
    UISearchDisplayController *searchController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar                                       contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    //iOS 8之前 UISearchDisplayController 之后被抛弃了
    
}
-(void)setUpSearch3{
    ///搜索模块
    SecondViewController *searchResultVC = [SecondViewController new];
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:searchResultVC];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    //table.tableHeaderView = searchController.searchBar;
    [self.view addSubview:searchController.searchBar];
    //searchController.dimsBackgroundDuringPresentation = NO;
    [searchController.searchBar sizeToFit];
    //搜索框颜色
    searchController.searchBar.barTintColor = [UIColor orangeColor];
    //searchController.definesPresentationContext=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];//这个searchBar和CYLSearchController中的searchBar是两个不同的
    self.title = @"手机通讯录";
    [self setUpData];
    [self setUpUI];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view.window makeKeyWindow];
}

//#pragma mark ---UIAlertViewDelegate
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0)
//    {
//        return;
//    }
//    else
//    {
//        UITextField *sectionField=[alertView textFieldAtIndex:0];
//        UITextField *rowField=[alertView textFieldAtIndex:1];
       
//        //删除联系人
//        [table deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[rowField.text integerValue] inSection:[sectionField.text integerValue]], nil] withRowAnimation:UITableViewRowAnimationFade];
        
//        [table reloadData];
    
//    }
//}

#pragma mark--UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section]count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text=dataArray[indexPath.section][indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"king2.png"];
    return cell;
}
//给分组添加标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return [[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",nil] objectAtIndex:section];
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *array=[dataArray objectAtIndex:sourceIndexPath.section];
    [array removeObjectAtIndex:sourceIndexPath.row];
    [table reloadData];
}
#pragma mark 返回每组标题索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSLog(@"生成组索引");
//    NSMutableArray *indexs=[[NSMutableArray alloc]init];
//    for(KCContactGroup *group in _contacts){
//        [indexs addObject:group.name];
//    }
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

#pragma mark -- UISearchBarDelegate
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    return NO;
//}                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"called when text starts editing");
    CYLSearchController *controller = [[CYLSearchController alloc] initWithNibName:@"CYLSearchController" bundle:nil];
    controller.delegate = self;
    self.searchController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller showInViewController:self];

}                     // called when text starts editing
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    return NO;
//}                        // return NO to not resign first responder
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"called when text ends editing");
//}                       // called when text ends editing
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"called when text changes (including clear)");
//}   // called when text changes (including clear)
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
//    return YES;
//} // called before text changes

//输入结束，回车开始搜索
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//      NSLog(@"searchBarSearchButtonClicked");
//}

#pragma mark -- UISearchDisplayDelegate
//在搜索关键字发生改变时调用
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString{
    return YES;
}

//在搜索表视图加载完毕后调用
-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{

}

#pragma mark --UISearchControllerDelegate
//要显示搜索结果,你必须手动刷新表视图
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{


}

#pragma mark - 🔌 CYLSearchControllerDelegate Method

- (void)questionSearchCancelButtonClicked:(CYLSearchController *)controller
{
    [controller hide:^{
        NSLog(@"questionSearchCancelButtonClicked");
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
