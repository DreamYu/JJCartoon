//
//  ContentModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic, retain) NSMutableArray *cover_image_url; // 左边的图片地址
@property (nonatomic, retain) NSMutableArray *likes_count;     // 点赞个数
@property (nonatomic, retain) NSMutableArray *title;           // cell 的题目
@property (nonatomic, retain) NSMutableArray *topic_id;
@property (nonatomic, retain) NSMutableArray *url;             // 跳转到下一页面的地址
@property (nonatomic, retain) NSMutableArray *updated_at;      // 更新时间


- (instancetype)initWithArray:(NSArray *)array;


@end
