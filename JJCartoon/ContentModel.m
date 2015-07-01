//
//  ContentModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel
-(instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        for (NSDictionary *dic in array) {
            [self.cover_image_url addObject:dic[@"cover_image_url"]];
            [self.likes_count addObject:dic[@"likes_count"]];
            [self.title addObject:dic[@"title"]];
            [self.topic_id addObject:dic[@"topic_id"]];
            [self.url addObject:dic[@"url"]];
        }
    }
    return self;
}
#pragma mark -  属性的懒加载
- (NSMutableArray *)cover_image_url
{
    if (!_cover_image_url) {
        self.cover_image_url = [NSMutableArray array];
    }
    return _cover_image_url;
}
- (NSMutableArray *)likes_count
{
    if (!_likes_count) {
        self.likes_count = [NSMutableArray array];
    }
    return _likes_count;
}
- (NSMutableArray *)title
{
    if (!_title) {
        self.title = [NSMutableArray array];
    }
    return _title;
}
- (NSMutableArray *)topic_id
{
    if (!_topic_id) {
        self.topic_id = [NSMutableArray array];
    }
    return _topic_id;
}
- (NSMutableArray *)url
{
    if (!_url) {
        self.url = [NSMutableArray array];
    }
    return _url;
}

-(void)dealloc
{
    _cover_image_url = nil;
    _likes_count = nil;
    _title = nil;
    _topic_id = nil;
    _url = nil;
    [super dealloc];

}
@end
