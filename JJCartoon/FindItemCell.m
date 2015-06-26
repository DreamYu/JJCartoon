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


#define kTitleViewWidth 5
#define kHeight 30
#define kSpace 10
#define kTitleLabelWidth 80
#define kMoreButtonWidth 50
#define kCollectionCellId @"CollectionCellId"
#define kHeaderIdentifire @"HeaderIdentifire"
// section 脚分区的重用标示符
#define kFooterIdentifire @"FooterIdentifire"
@interface FindItemCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

// 用来接受图片的地址
@property (nonatomic, retain) NSMutableArray *imageUrlArray;


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
- (void) addSubviews
{
    // 创建titleImage
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(kSpace, kSpace, kTitleViewWidth, kHeight)];
    self.titleView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.titleView];
    
    // 创建 titleLabel
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleView.frame.origin.x + self.titleView.frame.size.width + kSpace, self.titleView.frame.origin.y, kTitleLabelWidth, kHeight)];
    self.titleLabel.text = @"热门专题";
    [self addSubview:self.titleLabel];
    
     // 创建 moreButton
    self.moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.moreButton.frame = CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 5 * kSpace, self.titleLabel.frame.origin.y, kMoreButtonWidth, kHeight);
    [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:self.moreButton];
    // 创建collectionView
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(50, 80);
    // 设置滑动方向 ：横向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.titleView.frame.origin.x, self.titleView.frame.origin.y + self.titleView.frame.size.height + kSpace, self.frame.size.width + 2 * kSpace, self.frame.size.height - 3 * kSpace - self.titleView.frame.size.height) collectionViewLayout:layout];
    // 设置delegate
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 注册item
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:kCollectionCellId];
    // 注册页眉
    [self.collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:kHeaderIdentifire];
    // 注册页脚
    [self.collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:kFooterIdentifire];
    // 添加集合视图
    [self addSubview:self.collectionView];
    
    [self.collectionView release];
    [layout release];
    [self.titleView release];
    [self.imageView release];
    
}
#pragma mark - UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageUrlArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];
    NSString *imageStr = self.imageUrlArray[indexPath.row];
    cell.photoImage.imageURL = [NSURL URLWithString:imageStr];
    cell.titleLabel.text = [NSString stringWithFormat:@"第%ld个",indexPath.row + 1];

    return cell;
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
    [_collectionView release];
    [_moreButton release];
    [super dealloc];
}
@end
