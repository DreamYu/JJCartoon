//
//  FindItemCell.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigModel.h"

@interface FindItemCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *moreButton;
@property (nonatomic, retain) UICollectionView *collectionView;
// 用来接受图片的地址
//@property (nonatomic, retain) NSMutableArray *imageUrlArray;
@property (nonatomic, retain) NSArray *imageUrlArray1;
@property (nonatomic, retain) NSArray *imageUrlArary2;
// 主题
@property (nonatomic, retain) NSArray *itemArray;
@property (nonatomic, retain) BigModel *model;

@end
