//
//  RTBaseModel.m
//  RuntimeTool
//
//  Created by 王维一 on 2019/5/25.
//  Copyright © 2019 王维一. All rights reserved.
//

#import "RTBaseModel.h"
#import <objc/runtime.h>


@implementation RTBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)resolveMethodData{
    // 获取方法
    unsigned int count = 0;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count ; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        IMP imp = method_getImplementation(method);
        // 函数参数 返回值都可以获取, 待验证
        
        NSLog(@"%@ %p",NSStringFromSelector(sel)  , imp);
        
    }
}


- (void) resolveProtocolData{
    // 获取代理
    unsigned int count = 0;
    Protocol * __unsafe_unretained *list  = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count ; i++) {
        Protocol *pro = list[i];
        NSLog(@"%@",NSStringFromProtocol(pro));
    }
    
    
    //Protocol
    //BOOL isConforms2 = [self conformsToProtocol:pro];
}



#pragma mark - 消息转发处理
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    
//    return YES;
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    
//    return YES;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    
//
//    
//}
//
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    //如果返回为nil则进行手动创建签名
////    if ([super methodSignatureForSelector:aSelector]==nil) {
////        NSMethodSignature * sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
////        return sign;
////    }
////    return [super methodSignatureForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    
//    
//    
//    
//}
//

#pragma mark 归档 反归档
//NSKeyedArchiver
- (void)encoder:(nonnull NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];//cahr
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    //在OC中使用了Copy、Creat、New类型的函数，需要释放指针！（注：ARC管不了C函数）
    free(ivars);
}

//NSKeyedUnarchiver
- (void)decoder:(NSCoder *)aDecoder {
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
    free(ivars);
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
    
        [self decoder:aDecoder];
    }
    return self;
}

@end



