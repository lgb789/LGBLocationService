//
//  LGBLocationService.m
//  qcjrgj
//
//  Created by lgb on 16/7/7.
//  Copyright © 2016年 com.dnj. All rights reserved.
//

#import "LGBLocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface LGBLocationService () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager*    manager;
@property (nonatomic, copy) LGBLocationServiceBlock block;
@end

@implementation LGBLocationService

#pragma mark - 公有方法

- (void)startLocation:(LGBLocationServiceBlock)block
{
    self.block = block;

    if ([self.manager respondsToSelector:@selector (requestWhenInUseAuthorization)])
    {
        [self.manager requestWhenInUseAuthorization];
    }
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
}

-(void)stopLocation
{
    [_manager stopUpdatingLocation];
}

#pragma mark - 重写父类方法

#pragma mark - 代理

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    __weak typeof(self) weakSelf = self;

    CLGeocoder* reverse = [[CLGeocoder alloc] init];

    [reverse reverseGeocodeLocation:locations[0]
                  completionHandler:^(NSArray<CLPlacemark*>* _Nullable placemarks, NSError* _Nullable error) {

                    CLPlacemark* placeMark = nil;

                    if (placemarks && placemarks.count)
                    {
                        placeMark = [placemarks objectAtIndex:0];
                    }

                    if (weakSelf.block)
                    {
                        weakSelf.block (placeMark.addressDictionary, error);
                    }
                  }];
}

#pragma mark - 事件处理

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置

- (CLLocationManager*)manager
{
    if (_manager == nil)
    {
        _manager          = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

@end
