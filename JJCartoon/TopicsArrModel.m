//
//  TopicsArrModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "TopicsArrModel.h"

@implementation TopicsArrModel

-(instancetype)initWithArray:(NSArray *)arr
{
    self = [super init];
    if (self) {
        if (![arr isKindOfClass:[NSNull class]]){
            for (NSDictionary *tempDic in arr) {
                [self.vertical_image_url addObject:tempDic[@"vertical_image_url"]];
                [self.cover_image_url addObject:tempDic[@"cover_image_url"]];
                [self.title addObject:tempDic[@"title"]];
                self.description1 = tempDic[@"description"];
                NSLog(@"%@", tempDic[@"id"]);
                [self.id1 addObject:tempDic[@"id"]];
                self.user = [[UserModel alloc]initWithDictionary:tempDic[@"user"]];
            }
        }
    }
    return self;
}
#pragma mark -- 数组的懒加载
- (NSMutableArray *) cover_image_url
{
    if (!_cover_image_url) {
        self.cover_image_url = [NSMutableArray array];
    }
    return _cover_image_url;    
}

- (NSMutableArray *) vertical_image_url
{
    
    if (!_vertical_image_url) {
        self.vertical_image_url = [NSMutableArray array];
    }
    return _vertical_image_url;
    
}
- (NSMutableArray *) title
{
    
    if (!_title) {
        self.title = [NSMutableArray array];
    }
    return _title;
}
- (NSMutableArray *) id1
{
    
    if (!_id1) {
        self.id1 = [NSMutableArray array];
    }
    return _id1;
}




-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@, %@", key, value);
}

-(void)dealloc
{
    _comics_count = nil;
    _cover_image_url = nil;
    _created_at = nil;
    _description1 = nil;
    _order = nil;
    _title = nil;
    _updated_at = nil;
    _user = nil;
    [super dealloc];
}
@end
