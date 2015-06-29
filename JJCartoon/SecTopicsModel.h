//
//  SecTopicsModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecTopModel.h"


@interface SecTopicsModel : NSObject

@property (nonatomic, retain) NSMutableArray *cover_image_url;
@property (nonatomic, retain) NSMutableArray *title;
@property (nonatomic, retain) NSMutableArray *url;
@property (nonatomic, retain) NSMutableArray *secTopArray;

@property (nonatomic, retain) SecTopModel *secTopModel;
-(instancetype)initWithArray:(NSArray *)array;




@end
