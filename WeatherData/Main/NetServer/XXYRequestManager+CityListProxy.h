//
//  XXYRequestManager+CityListProxy.h
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "XXYRequestManager.h"

@interface XXYRequestManager (CityListProxy)
/**
 *  get allCityList
 *
 *  @param sessionId <#sessionId description#>
 *  @param reasult   <#reasult description#>
 */
+ (void)getCityListWithSessionId:(NSString *)sessionId
                     backReasult:(BackReasultBlock)reasult;
@end
