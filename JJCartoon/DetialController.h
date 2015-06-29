//
//  DetialController.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecTopicsModel.h"


@interface DetialController : UIViewController<UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) SecTopicsModel *model;
@property (nonatomic, assign) NSInteger index;

@end
