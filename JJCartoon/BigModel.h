//
//  BigModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/26.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicsArrModel.h"

@interface BigModel : NSObject
@property (nonatomic, retain) NSString *action;
@property (nonatomic, retain) NSString *title;
// 第二个Model
@property (nonatomic, retain) TopicsArrModel *topicsArrModel;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
