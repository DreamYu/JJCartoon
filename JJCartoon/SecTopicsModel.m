//
//  SecTopicsModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "SecTopicsModel.h"

@implementation SecTopicsModel


-(instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        if (![array isKindOfClass:[NSNull class]]){
            NSDictionary *dic = [NSDictionary dictionary];
            for (int i = 0; i < array.count; i++) {
                dic = [array objectAtIndex:i];
                [self.cover_image_url addObject:dic[@"cover_image_url"]];
                self.secTopModel = [[SecTopModel alloc]initWithDictionary:dic[@"topic"]];
                [self.url addObject:dic[@"url"]];
                [self.secTopArray addObject:self.secTopModel];
            }
        }
    }
    return self;
    
}
#pragma mark - 懒加载
- (NSMutableArray *)url
{
    if (!_url) {
        self.url = [NSMutableArray array];
    }
    return _url;
}

- (NSMutableArray *)secTopArray
{
    if (!_secTopArray) {
        self.secTopArray = [NSMutableArray array];
    }
    return _secTopArray;
}
- (NSMutableArray *)cover_image_url
{
    if (!_cover_image_url) {
        self.cover_image_url = [NSMutableArray array];
    }
    return _cover_image_url;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

-(void)dealloc
{
    _cover_image_url = nil;
    _title = nil;
    _url = nil;
    _secTopModel = nil;
    [super dealloc];
}



@end
