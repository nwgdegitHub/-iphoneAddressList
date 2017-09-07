//
//  NavigationController.m
//  手机通讯录Demo
//
//  Created by 刘伟 on 2017/9/6.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import "NavigationController.h"
#import "AppDelegate.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //给AppDelegate的navigationController属性赋值(使用storyboard必须写)
    AppDelegate *delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    delegate.navigationController=self;
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
