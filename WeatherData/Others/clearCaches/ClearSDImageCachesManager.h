//
//  ClearSDImageCachesManager.h
//  WeatherData
//
//  Created by Jason_Xu on 16/8/28.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearSDImageCachesManager : NSObject
//单例
+ (instancetype)shareInstance;
//清除缓存
- (void)clearchCache:(NSString *)path;
//计算文件大小
- (float)fileSizeAtPath:(NSString *)path;
//计算缓存大小
- (float)folderSizeAthPath:(NSString *)path;
@end
