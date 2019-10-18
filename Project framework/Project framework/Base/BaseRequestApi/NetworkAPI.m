//
//  NetworkAPI.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/29.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "NetworkAPI.h"


@interface NetworkAPI ()
@property(nonatomic,strong)AFHTTPSessionManager *managers;

@end

@implementation NetworkAPI
LFYSingletonM

- (AFHTTPSessionManager *)managers{
    _managers = [AFHTTPSessionManager manager];
    _managers.requestSerializer = [AFHTTPRequestSerializer serializer];
    _managers.responseSerializer = [AFHTTPResponseSerializer serializer];
    _managers.requestSerializer.timeoutInterval = 15;
    _managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    return _managers;
}


+(void)GET:(NSString *)url andWithParam:(NSDictionary *)param{
    AFHTTPSessionManager * manager = [NetworkAPI shareInstance].managers;
    
    //无网络状态
    if (![PPNetworkHelper isNetwork]) {
        
        return ;
    }
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        //        请求进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        请求成功
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([NetworkAPI shareInstance].delegate && [[NetworkAPI shareInstance].delegate respondsToSelector:@selector(requestSucesses:)]) {
                [[NetworkAPI shareInstance].delegate requestSucesses:dict];
            }
        } else {
            //windown 弹出提示框，暂无数据
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        请求失败
        if ([NetworkAPI shareInstance].delegate && [[NetworkAPI shareInstance].delegate respondsToSelector:@selector(requestError:)]) {
            [[NetworkAPI shareInstance].delegate requestError:error];
        }
    }];
}


//Post
+(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter{
    AFHTTPSessionManager * manager = [NetworkAPI shareInstance].managers;
    //无网络状态
    if (![PPNetworkHelper isNetwork]) {
        
        return ;
    }
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        请求成功
        if(responseObject){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([NetworkAPI shareInstance].delegate && [[NetworkAPI shareInstance].delegate respondsToSelector:@selector(requestSucesses:)]) {
                [[NetworkAPI shareInstance].delegate requestSucesses:dict];
            }
        } else {
            //windown 弹出提示框，暂无数据
            [kAppWindow makeToast:@"暂无数据"];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        请求失败
        if ([NetworkAPI shareInstance].delegate && [[NetworkAPI shareInstance].delegate respondsToSelector:@selector(requestError:)]) {
            [[NetworkAPI shareInstance].delegate requestError:error];
        }
        [kAppWindow makeToast:@"请求失败"];
    }];
    
}


@end
