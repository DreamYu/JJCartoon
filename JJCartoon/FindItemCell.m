//
//  FindItemCell.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "FindItemCell.h"
#import "CollectionCell.h"
#import "EGOImageView.h"
#import "NetworkEngine.h"
#import "BigModel.h"


#define kTitleViewWidth 5
#define kHeight 30
#define kSpace 10
#define kTitleLabelWidth 80
#define kMoreButtonWidth 50
#define kCollectionCellId @"CollectionCellId"
#define kHeaderIdentifire @"HeaderIdentifire"
// section 脚分区的重用标示符
#define kFooterIdentifire @"FooterIdentifire"
#define kCollectionViewHeight 200


@interface FindItemCell ()<NetworkEngineDelegate>


@property (nonatomic, retain) NSArray *array;
// 接受大Model的数组
@property (nonatomic, retain) NSMutableArray *modelArr;


@end



@implementation FindItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
    
}
#pragma mark - addSubviews
- (void) addSubviews
{
   
    // 创建titleImage
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(kSpace, kSpace, kTitleViewWidth, kHeight)];
    self.titleView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.titleView];
    [self.titleView release];
    
    // 创建 titleLabel
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleView.frame.origin.x + self.titleView.frame.size.width + kSpace, self.titleView.frame.origin.y, kTitleLabelWidth, kHeight)];

    [self addSubview:self.titleLabel];
    [self.titleLabel release];
    
     // 创建 moreButton
    self.moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.moreButton.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 20 * kSpace, self.titleLabel.frame.origin.y, kMoreButtonWidth, kHeight);
    [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:self.moreButton];
   
    
    // 创建collectionView
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 150);
    // 设置滑动方向 ：横向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.titleView.frame.origin.x,     self.titleView.frame.origin.y + self.titleView.frame.size.height + kSpace, self.frame.size.width + 2 * kSpace, kCollectionViewHeight - 3 * kSpace - self.titleView.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    // 设置delegate
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 注册item
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:kCollectionCellId];

    // 注册页眉
//    [self.collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:kHeaderIdentifire];
    // 注册页脚
//    [self.collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:kFooterIdentifire];
    
    // 添加集合视图
    [self addSubview:self.collectionView];

}
#pragma mark - imageUrlArray1 和  imageUrlArray2的懒加载
- (NSArray *) imageUrlArray1
{
    if (!_imageUrlArray1) {
        self.imageUrlArray1 = [NSArray array];
    }
    return _imageUrlArray1;
}
- (NSArray *) imageUrlArray2
{
    if (!_imageUrlArary2) {
        self.imageUrlArary2 = [NSArray array];
    }
    return _imageUrlArary2;
}
- (NSArray *) itemArray
{
    if (!_itemArray) {
        self.itemArray = [NSArray array];
    }
    return _itemArray;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.topicsArrModel.vertical_image_url.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];

    NSString *imageUrl = self.model.topicsArrModel.vertical_image_url[indexPath.row];
    cell.photoImage.imageURL = [NSURL URLWithString:imageUrl];
    NSLog(@"%@", self.model.topicsArrModel.title[indexPath.row]);
    cell.titleLabel.text = self.model.topicsArrModel.title[indexPath.row];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self setSelected:YES animated:YES];
//}


#pragma mark - modelArr 的懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];

    }
    return _modelArr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
    _titleLabel = nil;
    [_titleView release];
    [_moreButton release];
    [super dealloc];
}
@end
