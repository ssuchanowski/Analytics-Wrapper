//
//  AnalyticsWrapper.h
//
//  Created by Sebastian Suchanowski on 07/12/13.
//  Copyright (c) 2013 Synappse Sebastian Suchanowski. All rights reserved.
//

#import "AnalyticsHeader.h"

@interface AnalyticsWrapper : NSObject

+ (void)setup;
+ (BOOL)shouldLogInfo;
+ (void)setUserAge:(int)age;
+ (void)setUserLocation:(CLLocation *)location;
+ (void)setUserSex:(BOOL)isMale;
+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName;
+ (void)trackExceptionWithDescription:(NSString *)desc fatal:(BOOL)fatal;
+ (void)trackPaymentWithCurrency:(NSString *)currency value:(NSNumber *)cost;

@end
