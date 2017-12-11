//
//  BaseCache.m
//  mengyaProject
//
//  Created by n on 2017/10/18.
//  Copyright © 2017年 n. All rights reserved.
//

#import "BaseCache.h"

@implementation BaseCache

+ (instancetype)shareBaseCache{

    static BaseCache *_cache=nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _cache = [BaseCache cacheWithName:BaseCache_Name];
        
    });
    
    return _cache;
}

@end
