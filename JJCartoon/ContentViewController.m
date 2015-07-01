//
//  ContentViewController.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentCell.h"
#import "NetworkEngine.h"
#import "ContentModel.h"

#define kContentUrl @"http://api.kuaikanmanhua.com/v1/topics/104?sort=0"


@interface ContentViewController ()<UITableViewDataSource, UITableViewDelegate, NetworkEngineDelegate>

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSMutableArray *modelArr;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromUrl];
    [self layoutView];
    
    // Do any additional setup after loading the view.
}
#pragma mark - modelArr 的懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

#pragma mark - getDataFromUrl
- (void) getDataFromUrl
{
//    NSString *append = [NSString stringWithFormat:@"%@", self.model.topicsArrModel.id1];
//    NSString *urlStr = [NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics/%@?sort=0", append];
    
    
    NetworkEngine *engine = [NetworkEngine netWorkEngineWithURL:[NSURL URLWithString:kContentUrl] params:nil delegate:self];
    [engine start];

}
#pragma mark - NetworkEngine Delegate
-(void)netWorkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *comics = dataDic[@"comics"];
    ContentModel *model = [[ContentModel alloc]initWithArray:comics];
    [self.modelArr addObject:model];
    [self.contentTableView reloadData];
}


#pragma mark - layoutView
- (void) layoutView {
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    // 顶部的图片 imageView
    self.urlStr = @"http://kuaikan-data.qiniudn.com/image/150502/e9w3eybf9.jpg-w640";
    self.imageView = [[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.imageView.imageURL = [NSURL URLWithString:[NSString stringWithString:self.urlStr]];
    self.imageView.placeholderImage = [UIImage imageNamed:@"image6"];
    self.tableView.tableHeaderView = self.imageView;
    
    // 简介Button
    self.introButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.introButton.frame = CGRectMake(0, self.imageView.frame.origin.y + self.imageView.frame.size.height, self.tableView.frame.size.width/2, 40);
    self.introButton.backgroundColor = [UIColor redColor];
    [self.introButton setTitle:@"简介" forState:UIControlStateNormal];
    // 添加点击事件
    [self.introButton  addTarget:self action:@selector(introButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.introButton];
    // 内容Button
    self.contentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.contentButton.frame = CGRectMake(self.introButton.frame.origin.x + self.introButton.frame.size.width, self.introButton.frame.origin.y, self.tableView.frame.size.width - self.introButton.frame.size.width, 40);
    [self.contentButton setTitle:@"内容" forState:UIControlStateNormal];
    // 添加点击事件
    [self.contentButton  addTarget:self action:@selector(contentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.contentButton.backgroundColor = [UIColor blueColor];
    [self.tableView addSubview:self.contentButton];
    
#pragma mark - 添加一个scrollorView
    self.scroView = [[UIScrollView alloc]init];
    self.scroView.frame = CGRectMake(0, self.introButton.frame.origin.y + self.introButton.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height - self.introButton.frame.size.height - self.imageView.frame.size.height);
    // 设置 scrollView 的contentView的尺寸
    [self setScroViewContentSize];
    self.scroView.backgroundColor = [UIColor cyanColor];
    [self.tableView addSubview:self.scroView];
    [self.scroView release];
    
}
#pragma mark - setScroViewContentSize
- (void) setScroViewContentSize
{
    self.scroView.contentSize = CGSizeMake(self.tableView.frame.size.width * 2, self.tableView.frame.size.height - self.imageView.frame.size.height - self.introButton.frame.size.height);
    // 添加contentTableView
    self.contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 600)];
    self.contentTableView.backgroundColor = [UIColor redColor];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.scroView addSubview:self.contentTableView];
    // 添加introTableView
    self.introTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.contentTableView.frame.origin.x + self.contentTableView.frame.size.width, 0, self.tableView.frame.size.width, 300)];
    self.introTableView.backgroundColor = [UIColor blueColor];
    [self.scroView addSubview:self.introTableView];
}
#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[ContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (self.modelArr.count > 0) {
            ContentModel *model = [self.modelArr objectAtIndex:0];
        NSLog(@"%@", model.title[indexPath.row]);
            cell.titleLabel.text = model.title[indexPath.row];
//            cell.headImage.imageURL = model.url[indexPath.row];
//            cell.likeLabel.text = model.likes_count[indexPath.row];
    }
    
    
    
//    cell.titleLabel.text = @"ABC";
//    cell.likeLabel.text = @"1585";
//    cell.dateLabel.text = @"20-20";
    return cell;
}


#pragma mark - introButton ，contentButton 的点击事件
- (void) introButtonAction:(UIButton *)sender{
    NSLog(@"introButtonAction");
    
};
    

- (void) contentButtonAction:(UIButton *)sender{
    NSLog(@"contentButtonAction");
}



#pragma mark - TableView Delegate
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    // 简介Button
    self.introButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.introButton.frame = CGRectMake(0, 0, self.tableView.frame.size.width/2, 40);
    self.introButton.backgroundColor = [UIColor redColor];
    [self.introButton setTitle:@"简介" forState:UIControlStateNormal];
    // 添加点击事件
    [self.introButton  addTarget:self action:@selector(introButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.introButton];
    // 内容Button
    self.contentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.contentButton.frame = CGRectMake(self.introButton.frame.origin.x + self.introButton.frame.size.width, self.introButton.frame.origin.y, self.tableView.frame.size.width - self.introButton.frame.size.width, 40);
    [self.contentButton setTitle:@"内容" forState:UIControlStateNormal];
    // 添加点击事件
    [self.contentButton  addTarget:self action:@selector(contentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.contentButton.backgroundColor = [UIColor blueColor];
    [view addSubview:self.contentButton];
    return view;
    
}
#pragma mark - introButton ，contentButton 的点击事件
- (void) introButtonAction:(UIButton *)sender{
    NSLog(@"introButtonAction");
}
- (void) contentButtonAction:(UIButton *)sender{
    NSLog(@"contentButtonAction");
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}
*/




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{   
    [_tableView release];
    [_imageView release];
    [_introButton release];
    [_contentButton release];
    [_scroView release];
    [_introTableView release];
    [_contentButton release];
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
