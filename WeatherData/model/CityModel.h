//
//  CityModel.h
//  WeatherData
//
//  Created by Jason_Xu on 16/8/28.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ReusltModel <NSObject>

@end

@protocol CityListModel <NSObject>

@end
//all cityModel
@interface CityModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, strong) NSDictionary<Ignore> *append_info;
@property (nonatomic, copy) NSString<Optional> *page_total;
@property (nonatomic, copy) NSString<Optional> *pagenumber;

@property (nonatomic, strong) NSArray<Optional, ReusltModel> *result;

@property (nonatomic, copy) NSString<Optional> *msg;
@property (nonatomic, copy) NSString<Optional> *result_count;
@end
//frist array model
@interface ReusltModel : JSONModel
@property (nonatomic, strong) NSArray<Optional, CityListModel> *city_list;
@property (nonatomic, copy) NSString *begin_key;
@end
//last array model
@interface CityListModel : JSONModel
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province_id;
@property (nonatomic, copy) NSString *province_name;
@end

