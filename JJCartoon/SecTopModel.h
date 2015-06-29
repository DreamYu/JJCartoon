//
//  SecTopModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/28.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface SecTopModel : NSObject
@property (nonatomic, retain) NSString *comics_count;
@property (nonatomic, retain) NSString *cover_image_url;
@property (nonatomic, retain) NSString *created_at;
@property (nonatomic, retain) NSString *description1;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *vertical_image_url;
@property (nonatomic, retain) UserModel *user;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
