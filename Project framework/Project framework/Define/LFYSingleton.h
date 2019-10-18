//
//  LFYSingleton.h
//  MyTest
//
//  Created by YSTLFY on 2017/5/3.
//  Copyright © 2017年 YSTLFY. All rights reserved.
//


#define LFYSingletonH +(instancetype)shareInstance;

#define LFYSingletonM static id _instance = nil;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
-(instancetype)copyWithZone:(NSZone *)zone\
{\
    return _instance;\
}\
+(instancetype)shareInstance\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance = [[self alloc]init];\
    });\
    return _instance;\
}
