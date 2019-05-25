//
//  NSObject+RTTool.h
//  RuntimeTool
//
//  Created by 王维一 on 2019/5/25.
//  Copyright © 2019 王维一. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RTTool)

@property (nonatomic , strong) NSMutableArray *ivars;
@property (nonatomic , strong) NSMutableArray *protocols;
@property (nonatomic , strong) NSMutableArray *methodLists;



@end

NS_ASSUME_NONNULL_END
