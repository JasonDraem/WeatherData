//
//  ClearSDImageCachesManager.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/28.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "ClearSDImageCachesManager.h"
#import <SDWebImage/SDImageCache.h>
@implementation ClearSDImageCachesManager
static ClearSDImageCachesManager *_shareInstance = nil;
/**
 *  单例
 *
 *  @return <#return value description#>
 */
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[ClearSDImageCachesManager alloc] init];
    });
    return _shareInstance;
}
/**
 *  清理缓存
 *
 *  @param path <#path description#>
 */
#pragma mark - 清除缓存
- (void) clearchCache:(NSString *)path {
    // caches's path
    //NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //添加判断条件，过滤掉不想删除的文件
//            if ([fileName isEqualToString:@""]) {
//                break;
//            }
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        //clear image caches
        [[SDImageCache sharedImageCache] cleanDisk];
    }
}
#pragma mark - 计算缓存大小
/**
 *  计算单个文件
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
- (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
/**
 *  计算目录大小
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
- (float)folderSizeAthPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize] /1024.0/1024.0;
        // NSLog(@"%.2f", folderSize);
        return folderSize;
    }
    return 0;
}
@end
