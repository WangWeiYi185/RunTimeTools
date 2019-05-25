//
//  NSObject+RTTool.m
//  RuntimeTool
//
//  Created by 王维一 on 2019/5/25.
//  Copyright © 2019 王维一. All rights reserved.
//

#import "NSObject+RTTool.h"
#import <objc/runtime.h>

@implementation NSObject (RTTool)

+ (void)load{
    
    // 方法交换
    
    static dispatch_once_t onceToken;
    /*单例保证并行情况下不会有问题*/
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(forwardInvocation:);
        SEL swizzledSelector = @selector(my_forwardInvocation:);
        
        /*获取原来的方法*/
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        /*获取要替换的方法*/
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        /*originalSelector是否有实现，如果存在返回YES，不存在返回NO*/
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success)
        {
            /*修改要替换的方法实现为原有实现*/
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            /*表示待交换的两个方法的实现*/
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
    
    
}

- (void)my_forwardInvocation:(NSInvocation *)invocation{
    [self forwardInvocation:invocation];
    NSLog(@"处理invocation 可还行");
    
}

- (void)setIvars:(NSMutableArray *)ivars{

    objc_setAssociatedObject(self, @selector(ivars), ivars,    OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)ivars{
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setMethodLists:(NSMutableArray *)methodLists{
    objc_setAssociatedObject(self, @selector(methodLists), methodLists, OBJC_ASSOCIATION_RETAIN);
    
}
- (NSMutableArray *)methodLists{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setProtocols:(NSMutableArray *)protocols{
    objc_setAssociatedObject(self, @selector(protocols), protocols, OBJC_ASSOCIATION_RETAIN);
    
}

- (NSMutableArray *)protocols{
    
   return objc_getAssociatedObject(self, _cmd);
}

#pragma mark 消息转发




@end
