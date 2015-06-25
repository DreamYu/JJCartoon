//
//  SecondViewController.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "SecondViewController.h"
#import "SDCycleScrollView.h"


#define kCycleViewHeight 220 //cycleView的高度
@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarAction:)];
    self.navigationItem.rightBarButtonItem = search;
// 创建 SDCycleScrollView 需要的array
    NSArray *cycleArr = [NSArray array];
    UIImage *image1 = [UIImage imageNamed:@"11"];
    UIImage *image2 = [UIImage imageNamed:@"12"];
    cycleArr = @[image1, image2];
    
    // 创建 SDCycleScrollView
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, kCycleViewHeight) imagesGroup:cycleArr];
    [self.view addSubview:cycleView];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - searchBarAction
- (void) searchBarAction:(UIBarButtonItem *)sender
{
    NSLog(@"搜索功能待完善");
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
