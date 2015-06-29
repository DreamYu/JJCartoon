//
//  NetworkEngine.h
//  23WaterFlowDemo
//
//  Created by liuxiangyu on 15/6/15.
//  Copyright (c) 2015年 lanou3G.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkEngine;
@protocol NetworkEngineDelegate <NSObject>

@optional
// 请求成功时的代理协议
- (void)netWorkDidFinishLoading:(NetworkEngine *)engine withInfo:(NSData *)data;

// 开始请求时的代理协议
- (void)netWorkDidStartLoading:(NetworkEngine *)engine;

@end

@interface NetworkEngine : NSObject

// 请求地址
@property (nonatomic , retain) NSURL *url;

// 外界初始化网络请求的方法
+ (id)netWorkEngineWithURL:(NSURL *)url params:(NSDictionary *)params delegate:(id<NetworkEngineDelegate>)delegate;

// 设置请求方式
- (void)setHTTPType:(NSString *)method;

// 启动网络请求
- (void)start;

@end
