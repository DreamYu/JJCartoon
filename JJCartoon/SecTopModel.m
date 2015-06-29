//
//  SecTopModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/28.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "SecTopModel.h"

@implementation SecTopModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self) {
        if (![dic isKindOfClass:[NSNull class]]){
            [self setValuesForKeysWithDictionary:dic];
            self.description1 = dic[@"description"];
            self.user = [[UserModel alloc]initWithDictionary:dic[@"user"]];
        }

    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

-(void)dealloc
{
    _comics_count = nil;
    _cover_image_url = nil;
    _created_at = nil;
    _description1 = nil;
    _title = nil;
    _vertical_image_url = nil;
    _user = nil;
    [super dealloc];
}
@end
