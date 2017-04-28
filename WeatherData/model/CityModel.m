//
//  CityModel.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/28.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end

@implementation ReusltModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end

@implementation CityListModel
+ (BOOL) propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end