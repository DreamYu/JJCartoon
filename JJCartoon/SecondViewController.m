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
#import "FindItemCell.h"
#import "FindItemCell2.h"
#import "BigModel.h"
#import "SecTopicsModel.h"
#import "SecTopModel.h"
#import "DetialController.h"
#import "ContentViewController.h"

#define kCycleViewHeight 220 //cycleView的高度
// getDataFromUrl 的URL
#define kCycleViewUrl @"http://api.kuaikanmanhua.com/v1/banners"
// tableview 中的 collectionView获取数据
#define kCollectionViewUrl @"http://api.kuaikanmanhua.com/v1/topic_lists/mixed"

@interface SecondViewController ()<NetworkEngineDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) SDCycleScrollView *cycleView;
@property (nonatomic, assign) NSInteger index;

@end



@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //cycleView从URL获取数据
    [self getDataFromUrl];
    // 搜索条
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarAction:)];
    self.navigationItem.rightBarButtonItem = search;
   
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.tableView;
    // 隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  // 给tabelview添加预留空间
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, kCycleViewHeight)];
    view.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = view;
    [self.tableView release];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - UITableView Delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}
// 设置cell 的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        NSString *findCell2ID = @"findCell2ID";
        FindItemCell2 *cell = [tableView dequeueReusableCellWithIdentifier:findCell2ID];
        if (nil == cell) {
            cell = [[FindItemCell2 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:findCell2ID];
        }
        SecTopicsModel *modle = [self.secModelArray objectAtIndex:0];
        cell.titleLabel.text = @"热门单篇";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = modle;
        cell.collectionView.delegate = self;
        return cell;
    }  else {
        NSString *findCellID = @"findCellID";
        FindItemCell *cell = [tableView dequeueReusableCellWithIdentifier:findCellID];
        if (nil == cell) {
            cell = [[FindItemCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:findCellID];
        }
        BigModel *model = [self.modelArr objectAtIndex:indexPath.row];
        cell.model = model;
        // 主题title
        cell.titleLabel.text = model.title;
        // 选中cell的颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.collectionView.delegate =  self;
        return cell;
    }
}
#pragma mark - Collection Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *cell = [collectionView superview];

    if ([[NSString stringWithFormat:@"%@", [cell class]] isEqual:@"FindItemCell2"]) {
        DetialController *detialVC = [[DetialController alloc]init];
        [self.navigationController pushViewController:detialVC animated:YES];
        SecTopicsModel *model = [self.secModelArray objectAtIndex:0];
        detialVC.model = model;
        detialVC.index = indexPath.row;
    } else {
        // 获取collection所在cell 的 NSIndexPath
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:(FindItemCell*)cell];
        ContentViewController *contentVC = [[ContentViewController alloc]init];
        contentVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //
//        [self.navigationController pushViewController:contentVC animated:YES]; // 导航条可以在完成跳转而不影响下面的数据传递
//        [self presentViewController:contentVC animated:YES completion:nil]; //  错误 ：在此跳转请求不到一些数据
       
        // 把Model传到下一界面
        BigModel *model = [self.modelArr objectAtIndex:selectedIndexPath.row];
        contentVC.model = model;
        contentVC.id1 = model.topicsArrModel.id1[indexPath.row];
        contentVC.index = indexPath.row;
        // 传递头部 URL 信息
        contentVC.headImageUrl = model.topicsArrModel.cover_image_url[indexPath.row];
         contentVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
         [self presentViewController:contentVC animated:YES completion:nil];
       
    }
}

#pragma mark - modelArr 的懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
#pragma mark - secModelArray的懒加载
- (NSMutableArray *)secModelArray
{
    if (!_secModelArray) {
        self.secModelArray = [NSMutableArray array];
    }
    return _secModelArray;
}
#pragma mark - getDataFromUrl
- (void) getDataFromUrl
{
    NSURL *url1 = [NSURL URLWithString:kCycleViewUrl];
    NSURL *url2 = [NSURL URLWithString:kCollectionViewUrl];
    
    NSArray *arr = @[url1, url2];
    for (NSURL *url in arr) {
        NetworkEngine *engine = [NetworkEngine netWorkEngineWithURL:url params:nil delegate:self];
        [engine start];
    }
}
#pragma mark - 数据请求成功的代理方法
- (void)netWorkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data 
{
    if ([engine.url isEqual:[NSURL URLWithString:kCycleViewUrl]]){
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
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
        [self.tableView reloadData];
        // 创建cycle 轮播
        self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kCycleViewHeight) imageURLsGroup:picUrls];
        self.cycleView.autoScrollTimeInterval = 2.0;
        self.cycleView.delegate = self;
        [self.tableView.tableHeaderView addSubview:self.cycleView];
    }
    if ([engine.url isEqual:[NSURL URLWithString:kCollectionViewUrl]]) {
    // findItemCell 里面的网络请求数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        // 其他四个主题
        NSArray *topicsArr = dataDic[@"topics"];
        for (NSDictionary *topDic in topicsArr) {
            BigModel *bigModel = [[BigModel alloc]initWithDictionary:topDic];
            [self.modelArr addObject:bigModel];
        }
        NSDictionary *itemDic = [NSDictionary dictionary];
        itemDic = [topicsArr objectAtIndex:1];
        // 定义字典里面的数组
        NSArray *itemArr = [NSArray array];
        itemArr = itemDic[@"comics"];
        NSLog(@"%@", itemArr);
        // 第二主题栏
        SecTopicsModel *secModel = [[SecTopicsModel alloc]initWithArray:itemArr];
        [self.secModelArray addObject:secModel];
    [self.tableView reloadData];
    }

}
#pragma mark - SDCycleView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetialController *detailVC = [[DetialController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
    SecTopicsModel *model = [self.secModelArray objectAtIndex:0];
    detailVC.model = model;
    detailVC.index = index;
}

// 懒加载 _allModelArray
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
    [_modelArr release];
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
