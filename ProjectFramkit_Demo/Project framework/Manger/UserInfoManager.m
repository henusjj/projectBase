//
//  UserInfoManager.m
//  BaseKit
//
//  Created by GuoYanjun on 2019/4/1.
//  Copyright © 2019年 shiyujin. All rights reserved.
//

#import "UserInfoManager.h"
#import <objc/message.h>

static UserInfoManager *userinfo;
@implementation UserInfoManager

#pragma mark-系统方法（此时将方法进行交换）
+ (void)load{
    
    //将属性的所有setter、getter方法与自定义的方法互换
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        
        Ivar ivar = varList[i];
        //获取属性名称
        const char *attr = ivar_getName(ivar);
        NSString *attriName = [NSString stringWithFormat:@"%s",attr];
        attriName = [attriName substringFromIndex:1];
        NSString *firstAttriName = [attriName substringToIndex:1];
        firstAttriName = [firstAttriName uppercaseString];
        NSString *lastAttriName = [attriName substringFromIndex:1];
        //构造原setter方法
        SEL originalSetSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",firstAttriName,lastAttriName]);
        Method originalSetMethod = class_getInstanceMethod([self class], originalSetSelector);
        
        //构造原getter方法
        SEL originalGetSelector = NSSelectorFromString(attriName);
        Method originalGetMethod = class_getInstanceMethod([self class], originalGetSelector);
        
        //新setter方法
        SEL newSetSelector = @selector(setMyAttribute:);
        Method newSetMethod = class_getInstanceMethod([self class], newSetSelector);
        IMP newSetIMP = method_getImplementation(newSetMethod);
        //新getter方法
        SEL newGetSelector = @selector(getAttribute);
        Method newGetMethod = class_getInstanceMethod([self class], newGetSelector);
        IMP newGetIMP = method_getImplementation(newGetMethod);
        
        //Method Swizzling
        method_setImplementation(originalSetMethod, newSetIMP);
        method_setImplementation(originalGetMethod, newGetIMP);
        
    }
    
}

#pragma mark-自定义setter方法（将属性值都存储到用户偏好设置）
- (void)setMyAttribute:(id)attribute{
    
    //获取调用的方法名称
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    //对set方法进行属性字段的解析,并存储到用户偏好设置表
    NSString *attr = [selectorString substringFromIndex:3];
    attr = [attr substringToIndex:[attr length]-1];
    //对首字符进行小写
    NSString *firstChar = [attr substringToIndex:1];
    firstChar = [firstChar lowercaseString];
    NSString *lastAttri = [NSString stringWithFormat:@"%@%@",firstChar,[attr substringFromIndex:1]];
    //setValue 可以为nil，不会崩溃
    if ([attribute isEqual:[NSNull null]] ) {
        attribute =@"";
    }
    [[NSUserDefaults standardUserDefaults]setValue:attribute forKey:lastAttri];
    
}

#pragma mark-自定义的getter方法（将属性值从用户偏好设置中取出）
- (id)getAttribute{
    
    //获取方法名
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:selectorString];
    if ([result isEqual:[NSNull null]]) {
        result = nil;
    }
    return result;
    
}



#pragma mark -----初始化工具类
+(instancetype)UserShareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userinfo = [[UserInfoManager alloc]init];
    });
    return userinfo;
}

#pragma mark -----配置数据
+(void)configInfo:(NSDictionary *)infoDic{
    NSArray *allkeys = [infoDic allKeys];
    for (NSString *key in allkeys) {
        
        //首字母大写
        NSString *firstKey = [key substringToIndex:1];
        firstKey = [firstKey uppercaseString];
        NSString *lastKey = [key substringFromIndex:1];
        
        //构造setter方法
        NSString *selectorStr = [NSString stringWithFormat:@"set%@%@:",firstKey,lastKey];
        
        SEL setSeletor = NSSelectorFromString(selectorStr);
        
        //调用setter方法
        NSString *value = [infoDic objectForKey:key];
        UserInfoManager *manager = [UserInfoManager UserShareManager];
        [manager performSelector:setSeletor withObject:value];
    }
}

#pragma mark -----用户退出登录操作
+(void)LoginOut{
    //清除本地信息
    [self cleanLocalInfo];
    
    /*
     *
     如果业务逻辑上需要将用户登出的状态通知到服务器；在此处进行项目的网络操作
     network handle
     *
     */
    
}

//清除存储在用户偏好设置中的所有用户信息
+ (void)cleanLocalInfo{
    
    NSArray *allAttribute =  [self getAllProperties];
    for (NSString *attribute in allAttribute) {
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:attribute];
        
    }
    
}
//获取用户信息类的所有属性
+ (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}



/**
 * 在vc中使用示例
 //1.通过UserInfoManager的configInfo：接口进行信息的配置
 [UserInfoManager configInfo:infoDic];
 
 //2.通过用户管理工具类使用用户信息；例如：通过判断userID是否有值，判断用户是否为登录状态
 if([[UserInfoManager shareUser] userID]) {
 
 NSLog(@"用户处于登录状态--用户的真实姓名为：%@",[[UserInfoManager shareUser] userName]);
 
 }else{
 
 NSLog(@"用户处于非登录状态，进行非登录状态的处理");
 }
 
 //3.对用户的信息进行更新(适应场景：用户修改了昵称或者头像。。。)
 NSLog(@"没更新昵称前：%@",[[UserInfoManager shareUser]userName]);
 
 //对昵称属性进行更新
 [[UserInfoManager shareUser]setUserName:@"狗蛋"];
 
 NSLog(@"昵称更新之后：%@",[[UserInfoManager shareUser]userName]);
 
 //4.退出登录
 [UserInfoManager loginOut];
 *
 */

@end
