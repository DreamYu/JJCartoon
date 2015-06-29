//
//  UserModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, retain) NSString *avatar_url;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *reg_type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
