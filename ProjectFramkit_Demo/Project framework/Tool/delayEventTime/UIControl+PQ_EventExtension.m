//
//  UIControl+PQ_EventExtension.m
//  PQDelayEventTime
//
//  Created by 盘国权 on 16/7/23.
//  Copyright © 2016年 PQ. All rights reserved.
//

#import "UIControl+PQ_EventExtension.h"
#import <objc/message.h>
@interface UIControl ()

@property (nonatomic,assign) NSTimeInterval pq_acceptTime;

@end

@implementation UIControl (PQ_EventExtension)
static char * const PQ_ACCEPTTIMEKEY = "pq_acceptTime";
static char * const PQ_DELAYINTERVALKEY = "pq_delayButtonInterVal";
// getter method
- (NSTimeInterval)pq_delayButtonInterVal{
    return [objc_getAssociatedObject(self, PQ_DELAYINTERVALKEY) doubleValue];
}

- (NSTimeInterval)pq_acceptTime{
    return [objc_getAssociatedObject(self, PQ_ACCEPTTIMEKEY) doubleValue];
}

// setter method
- (void)setPq_delayButtonInterVal:(NSTimeInterval)pq_delayButtonInterVal{
    objc_setAssociatedObject(self, PQ_DELAYINTERVALKEY, @(pq_delayButtonInterVal), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPq_acceptTime:(NSTimeInterval)pq_acceptTime{
    objc_setAssociatedObject(self, PQ_ACCEPTTIMEKEY, @(pq_acceptTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method systemMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method myselfMethod = class_getInstanceMethod([self class], @selector(pq_sendAction:to:forEvent:));
        BOOL isAdd = class_addMethod([self class], @selector(sendAction:to:forEvent:), method_getImplementation(myselfMethod), method_getTypeEncoding(myselfMethod));
        if (!isAdd) {
            method_exchangeImplementations(systemMethod, myselfMethod);
        }
    });
}

- (void)pq_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (NSDate.date.timeIntervalSince1970 - self.pq_acceptTime < self.pq_delayButtonInterVal) {
        NSLog(@"现在点我我也不鸟你");
        [kAppWindow makeToast:@"不要重复点击"];
        return;
    }
    if (self.pq_delayButtonInterVal > 0) {
        self.pq_acceptTime = NSDate.date.timeIntervalSince1970;
    }
    [self pq_sendAction:action to:target forEvent:event];
}

@end
