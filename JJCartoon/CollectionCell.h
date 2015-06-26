//
//  CollectionCell.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;

@interface CollectionCell : UICollectionViewCell

@property (nonatomic, retain) EGOImageView *photoImage;
@property (nonatomic, retain) UILabel *titleLabel;

@end
