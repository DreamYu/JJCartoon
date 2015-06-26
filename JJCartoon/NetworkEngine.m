//
//  NetworkEngine.m
//  23WaterFlowDemo
//
//  Created by liuxiangyu on 15/6/15.
//  Copyright (c) 2015年 lanou3G.com. All rights reserved.
//

#import "NetworkEngine.h"







@interface NetworkEngine ()

@property (nonatomic , assign) id<NetworkEngineDelegate> delegate;

// 参数
@property (nonatomic , retain) NSDictionary *params;

// 请求地址
@property (nonatomic , retain) NSURL *url;

// 请求方式
@property (nonatomic , retain) NSString *HTTPMethod;

// 由参数拼接成的字符串
@property (nonatomic , retain) NSString *stringFromParams;

@end




@implementation NetworkEngine

- (void)dealloc
{
    _delegate = nil;
    [_url release];
    _params = nil;
    _HTTPMethod = nil;
    _stringFromParams = nil;
    [super dealloc];
}

+ (id)netWorkEngineWithURL:(NSURL *)url params:(NSDictionary *)params delegate:(id<NetworkEngineDelegate>)delegate
{
    NetworkEngine *engine = [[NetworkEngine alloc] init];
    engine.delegate = delegate;
    engine.url = url;
    engine.params = params;
    engine.HTTPMethod = @"GET";
    return [engine autorelease];
}

// 设置请求方式(不要写成HTTPMethod的setter方法)
- (void)setHTTPType:(NSString *)method
{
    if (!method) {
        return;
    }
    // 保存请求方式
    self.HTTPMethod = method;
}


#pragma mark - 把参数列表转变成字符串
- (NSString *)returnStringFromParams:(NSDictionary *)params
{
    // 准备一个可变数组
    NSMutableArray *array = [NSMutableArray array];
    
    // 循环遍历
    for (NSString *key in params) {
        NSString *currentString = [NSString stringWithFormat:@"%@=%@" , key , params[key]];
        [array addObject:currentString];
    }
    
    // 按照特定的字符，把这些字符串从数组里面拼接出来
    NSString *resultStr = [array componentsJoinedByString:@"&"];
    return resultStr;
    
}


#pragma mark - 设定参数列表(params属性的setter方法)
- (void)setParams:(NSDictionary *)params
{
    if (!params) {
        return;
    }
    
    // 如果参数字典存在，直接调用私有方法，将该参数转变成参数列表字符串
    self.stringFromParams = [self returnStringFromParams:params];
}


#pragma mark - 启动网络的方法
- (void)start
{
    if ([self.HTTPMethod isEqualToString:@"GET"] && self.stringFromParams) {
        NSString *getUrlString = [self.url.absoluteString stringByAppendingFormat:@"?%@" , self.stringFromParams];
        self.url = [NSURL URLWithString:getUrlString];
    }
    
    // 创建可变的请求体对象
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    // 设置请求方式
    requst.HTTPMethod = self.HTTPMethod;
    
    if ([self.HTTPMethod isEqualToString:@"POST"]) {
        // 使用POST请求，需要给可变的请求体属性赋值参数字符串
        requst.HTTPBody = [self.stringFromParams dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    // 使用异步方式来连接
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (_delegate && [_delegate respondsToSelector:@selector(netWorkDidFinishLoading:withInfo:)]) {
            [_delegate netWorkDidFinishLoading:self withInfo:data];
        }
    }];
    
    
}


@end
