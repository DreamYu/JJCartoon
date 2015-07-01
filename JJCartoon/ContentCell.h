//
//  ContentCell.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "ContentModel.h"

@interface ContentCell : UITableViewCell
@property (nonatomic, retain) EGOImageView *headImage;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *likeLabel;


@end
