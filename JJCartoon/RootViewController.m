//
//  RootViewController.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
#pragma mark 快看
    FirstViewController *firstVC= [[FirstViewController alloc] init];
    firstVC.title = @"快看";
    UINavigationController *firstNC = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    secondVC.title = @"发现";
    UINavigationController *secondNC = [[UINavigationController alloc]initWithRootViewController:secondVC];
    
    
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
    thirdVC.title = @"个人";
    UINavigationController *thirdNC = [[UINavigationController alloc]initWithRootViewController:thirdVC];
    
    
    
    self.viewControllers = @[firstNC, secondNC, thirdNC];

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
