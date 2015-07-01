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
    // 拼接字符串 %@ 为 id的内容
    NSString *append = [NSString stringWithFormat:@"%@", self.model.topicsArrModel.id1[self.index]];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics/%@?sort=0", append];
    NetworkEngine *engine = [NetworkEngine netWorkEngineWithURL:[NSURL URLWithString:urlStr] params:nil delegate:self];
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
    self.imageView = [[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    // 头部的URL地址传入
    self.imageView.imageURL = [NSURL URLWithString:[NSString stringWithString:self.headImageUrl]];
    self.imageView.placeholderImage = [UIImage imageNamed:@"image6"];
    self.tableView.tableHeaderView = self.imageView;
    // 返回Button
    self.backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.backButton.frame = CGRectMake(10, 20, 50, 30);
    [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.tableView addSubview:self.backButton];
    // backButton 添加点击返回事件
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark - introButton , contentButton
    // 简介Button
    self.introButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.introButton.frame = CGRectMake(0, self.imageView.frame.origin.y + self.imageView.frame.size.height, self.tableView.frame.size.width/2, 40);
    self.introButton.backgroundColor = [UIColor blueColor];
    [self.introButton setTitle:@"简介" forState:UIControlStateNormal];
    // 添加点击事件
    [self.introButton  addTarget:self action:@selector(introButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.introButton];
    // 内容Button
    self.contentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.contentButton.frame = CGRectMake(self.introButton.frame.origin.x + self.introButton.frame.size.width, self.introButton.frame.origin.y, self.tableView.frame.size.width - self.introButton.frame.size.width, 40);
    [self.contentButton setTitle:@"内容" forState:UIControlStateNormal];
    // contentButton 添加点击事件
    [self.contentButton  addTarget:self action:@selector(contentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.contentButton.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:self.contentButton];
#pragma mark - 添加一个scrollorView
    self.scroView = [[UIScrollView alloc]init];
    self.scroView.frame = CGRectMake(0, self.introButton.frame.origin.y + self.introButton.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height - self.introButton.frame.size.height - self.imageView.frame.size.height);
    // 整页滑动按钮打开
    self.scroView.pagingEnabled = YES;
    // 设置 scrollView 的contentView的尺寸
    [self setScroViewContentSize];
    // 添加scroView的背景
//    self.scroView.backgroundColor = [UIColor cyanColor];
    [self.tableView addSubview:self.scroView];
    [self.scroView release];
    
}
#pragma mark - backButton 点击事件
- (void)backButtonAction:(UIButton *)sender
{NSLog(@"backButton");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setScroViewContentSize
- (void) setScroViewContentSize
{
    self.scroView.contentSize = CGSizeMake(self.tableView.frame.size.width * 2, self.tableView.frame.size.height - self.imageView.frame.size.height - self.introButton.frame.size.height);
    // 添加contentTableView 内容
    self.contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height - self.contentButton.frame.size.height - self.imageView.frame.size.height)];
    // 设置 contentTableView背景
//    self.contentTableView.backgroundColor = [UIColor redColor];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    [self.scroView addSubview:self.contentTableView];
    // 添加introTableView
    self.introTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.contentTableView.frame.origin.x + self.contentTableView.frame.size.width, 0, self.tableView.frame.size.width, self.tableView.frame.size.height - self.contentButton.frame.size.height - self.imageView.frame.size.height)];
// 把tableview上的分割线隐藏
    self.introTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.introTableView.backgroundColor = [UIColor blueColor];
    [self.scroView addSubview:self.introTableView];
    // 添加introTableView 的子视图
    [self addChildSubview];
}
#pragma mark - introTableView
- (void)addChildSubview
{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, self.scroView.frame.origin.y - 235, self.tableView.frame.size.width, 40)];
    textView.backgroundColor = [UIColor redColor];
    
    textView.text = @"AFDSFHGHDJFNMLKNKKMKLCJKCDLNMKCKJMD";
    [self.introTableView addSubview:textView];
    
    
    
}
#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.modelArr.count != 0) {
        ContentModel *model = [self.modelArr objectAtIndex:0];
        return model.cover_image_url.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
// 设置cell头部的视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}
// 设置头部文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"专题列表";
}
// 设置头部的高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
            cell.titleLabel.text = model.title[indexPath.row];
        // 显示题目 第XXX话
        if ([model.likes_count[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.likeLabel.text = model.likes_count[indexPath.row];
        } else {
            // 显示点赞数目
            cell.likeLabel.text = [NSString stringWithFormat:@"%@", model.likes_count[indexPath.row]];
        }
        // 设置时间Label
    
        NSTimeInterval timeInteral = [model.updated_at[indexPath.row] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInteral];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM-dd"];
        // 设置cell 的日期Label
        cell.dateLabel.text = [dateFormatter stringFromDate:date];
    
        // cell里的图片
        cell.headImage.placeholderImage = [UIImage imageNamed:@"image6.png"];
        cell.headImage.imageURL =  [NSURL URLWithString:model.cover_image_url[indexPath.row]];
    }

    return cell;
}


#pragma mark - introButton ，contentButton 的点击事件
- (void) introButtonAction:(UIButton *)sender{
    NSLog(@"introButtonAction");
    
};
    

- (void) contentButtonAction:(UIButton *)sender{
    NSLog(@"contentButtonAction");
}

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
    [_backButton release];
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
