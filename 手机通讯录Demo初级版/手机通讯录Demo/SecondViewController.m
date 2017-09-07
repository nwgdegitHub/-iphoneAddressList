//
//  SecondViewController.m
//  手机通讯录Demo
//
//  Created by qianfeng on 15/8/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(30, 30, 250, 30)];
    textField.placeholder=@"🔍搜索:";
    textField.backgroundColor=[UIColor whiteColor];
    textField.borderStyle= UITextBorderStyleRoundedRect;
    [textField becomeFirstResponder];//进入视图后就唤起键盘（考虑到用户体验）
    [self.view addSubview:textField];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(290, 30, 40, 30);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
}

-(void)pressBtn{
    [self.navigationController popViewControllerAnimated:YES];




}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
