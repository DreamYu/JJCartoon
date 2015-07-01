//
//  ContentViewController.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "BigModel.h"

@interface ContentViewController : UIViewController<EGOImageViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) EGOImageView *imageView;
@property (nonatomic, retain) UIButton *introButton;
@property (nonatomic, retain) UIButton *contentButton;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) UIScrollView *scroView;
@property (nonatomic, retain) UITableView *introTableView;
@property (nonatomic, retain) UITableView *contentTableView;

@property (nonatomic, retain) BigModel *model;
@property (nonatomic, assign) NSInteger index;


@end
