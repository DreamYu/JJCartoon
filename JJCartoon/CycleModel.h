//
//  CycleModel.h
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CycleModel : NSObject

@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *value;

- (instancetype) cyecleModelWithDictionary:(NSDictionary *)dic;

@end
