//
//  ContentModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject

@property (nonatomic, retain) NSMutableArray *cover_image_url;
@property (nonatomic, retain) NSMutableArray *likes_count;
@property (nonatomic, retain) NSMutableArray *title;
@property (nonatomic, retain) NSMutableArray *topic_id;
@property (nonatomic, retain) NSMutableArray *url;

- (instancetype)initWithArray:(NSArray *)array;


@end
