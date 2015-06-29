//
//  UserModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"%@", key);
}

-(instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (![dic isKindOfClass:[NSNull class]]){
            [self setValuesForKeysWithDictionary:dic];
        }
    }
    return self;
}


-(void)dealloc
{
    _avatar_url = nil;
    _nickname = nil;
    _reg_type= nil;
    [super dealloc];
    
}
@end
