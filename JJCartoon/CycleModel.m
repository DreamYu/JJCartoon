//
//  CycleModel.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "CycleModel.h"

@implementation CycleModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (instancetype)cyecleModelWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
//        self.pic = dic[@"pic"];
//        self.value = dic[@"value"];
        [self setValuesForKeysWithDictionary:dic];
        
        
    }
    return  self;
}
-(void)dealloc
{
    _pic = nil;
    _value = nil;
    [super dealloc];
}

@end
