//
//  SecondViewController.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "SecondViewController.h"
#import "SDCycleScrollView.h"
#import "NetworkEngine.h"
#import "CycleModel.h"

#define kCycleViewHeight 220 //cycleView的高度
// getDataFromUrl 的URL
#define kCycleViewUrl @"http://api.kuaikanmanhua.com/v1/banners"
#define kCollectionViewUrl @"http://api.kuaikanmanhua.com/v1/topic_lists/mixed"

@interface SecondViewController ()<NetworkEngineDelegate>
@property (nonatomic, retain) UITableView *tableView;

@end




@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.tableView;
    [self.tableView release];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarAction:)];
    
    self.navigationItem.rightBarButtonItem = search;
//    cycleView从URL获取数据
    [self getDataFromUrl];
  // tableview 中的 collectionView获取数据
    [self getCollectionViewDataFromUrl];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - getCollectionViewDataFromUrl
- (void) getCollectionViewDataFromUrl
{
    
}


#pragma mark - getDataFromUrl
- (void) getDataFromUrl
{
    NetworkEngine *engine = [NetworkEngine netWorkEngineWithURL:[NSURL URLWithString:kCycleViewUrl] params:nil delegate:self];
    [engine start];
    
}
#pragma mark - 数据请求成功的代理方法
- (void)netWorkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data
{

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *banner_group = dataDic[@"banner_group"];
  
    // 把得到的数据存放到数组当中
    for (NSDictionary *itemDic in banner_group) {
        CycleModel *Model = [[CycleModel alloc]cyecleModelWithDictionary:itemDic];
        [self.allModelArray addObject:Model];
    }
   
    NSMutableArray *picUrls = [NSMutableArray array];
    for (CycleModel *model in self.allModelArray) {
        NSString *picUrl = model.pic;
        NSURL *url = [NSURL URLWithString:picUrl];
        [picUrls addObject:url];
    }
    
    // 创建cycle 轮播
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kCycleViewHeight) imageURLsGroup:picUrls];
    cycleView.autoScrollTimeInterval = 2.0;
    [self.tableView addSubview:cycleView];

}
// 懒加载 allModel
- (NSMutableArray *)allModelArray
{
    if (!_allModelArray) {
        self.allModelArray = [NSMutableArray array];
    }
    return _allModelArray;
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

-(void)dealloc
{
    [_allModelArray release];
    [_tableView release];
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
