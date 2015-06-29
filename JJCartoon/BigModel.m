//
//  BigModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "BigModel.h"

@implementation BigModel

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (![dic isKindOfClass:[NSNull class]]){
            [self setValuesForKeysWithDictionary:dic];
            self.topicsArrModel = [[TopicsArrModel alloc]initWithArray:dic[@"topics"]];
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
    _action = nil;
    _title = nil;
    [super dealloc];
}
@end
