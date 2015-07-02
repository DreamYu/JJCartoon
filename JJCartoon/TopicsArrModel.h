//
//  TopicsArrModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface TopicsArrModel : NSObject

@property (nonatomic, retain) NSMutableArray *comics_count;
@property (nonatomic, retain) NSMutableArray *cover_image_url;
@property (nonatomic, retain) NSMutableArray *created_at;
@property (nonatomic, retain) NSMutableArray *description1;
@property (nonatomic, retain) NSMutableArray *order;
@property (nonatomic, retain) NSMutableArray *title;
@property (nonatomic, retain) NSMutableArray *updated_at;
@property (nonatomic, retain) NSMutableArray *vertical_image_url;
@property (nonatomic, retain) NSMutableArray *id1;
@property (nonatomic, retain) NSMutableArray *userModelArr; // 装user的数组

// user 的字典
@property (nonatomic, retain) UserModel *user;

- (instancetype)initWithArray:(NSArray *)arr;


@end
