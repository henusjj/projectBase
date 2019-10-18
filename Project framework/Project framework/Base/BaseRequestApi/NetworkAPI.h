//
//  NetworkAPI.h
//  Project framework
//
//  Created by GuoYanjun on 2019/9/29.
//  Copyright © 2019年 ZXY. All rights reserved.
//




#import <Foundation/Foundation.h>
/**
 * 封装AFN，使用代理
 *
 */


NS_ASSUME_NONNULL_BEGIN

@protocol NetworkDeleagte <NSObject>

-(void)requestSucesses:(id)responseData;
-(void)requestError:(NSError *)error;

@end

@interface NetworkAPI : NSObject
@property(nonatomic,weak)id <NetworkDeleagte> delegate;
LFYSingletonH
//get请求
+(void)GET:(NSString *)url andWithParam:(NSDictionary *)param;
//post请求
+(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter;

@end

NS_ASSUME_NONNULL_END

