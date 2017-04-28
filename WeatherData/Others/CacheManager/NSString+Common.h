//
//  NSString+Common.h
//  XXYSoundRecorder
//
//  Created by Jason_Xu on 16/9/13.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
/**
 *  加密
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
NSString * URLEncodedString(NSString *str);
/**
 *  MD5加密
 *
 *  @param aString <#aString description#>
 *
 *  @return <#return value description#>
 */
NSString * MD5Hash(NSString *aString);
@end
