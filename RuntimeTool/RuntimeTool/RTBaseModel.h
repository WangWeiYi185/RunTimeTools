//
//  RTBaseModel.h
//  RuntimeTool
//
//  Created by 王维一 on 2019/5/25.
//  Copyright © 2019 王维一. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTBaseModel : NSObject<NSCoding>

- (void) resolveMethodData;
- (void) resolveProtocolData;


- (void)encoder:(NSCoder *)aCoder;
- (void)decoder:(NSCoder *)aDecoder;
@end


@interface backUpModel : NSObject

@end

NS_ASSUME_NONNULL_END
