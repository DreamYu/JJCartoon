//
//  DetialController.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "DetialController.h"

@interface DetialController ()

@end

@implementation DetialController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    NSString *urlStr = self.model.url[self.index];
    NSLog(@"%@", urlStr);
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    
    
    
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_webView release];
    [super dealloc];
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
