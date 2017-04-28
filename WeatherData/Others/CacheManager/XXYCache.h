//
//  XXYCache.h
//  XXYSoundRecorder
//
//  Created by Jason_Xu on 16/9/13.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXYCache : NSObject
/**
 *  缓存路径
 *
 *  @return
 */
+ (NSString*) cacheDirectory ;
/**
 *  重置缓存
 */
+ (void) resetCache;
/**
 *  存放缓存
 *
 *  @param data <#data description#>
 *  @param key  <#key description#>
 */
+ (void) setObject:(NSData*)data forKey:(NSString*)key;
/**
 *  键值
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
+ (id) objectForKey:(NSString*)key;

@end
