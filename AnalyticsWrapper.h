//
//  AnalyticsWrapper.h
//
//  Created by Sebastian Suchanowski on 07/12/13.
//  Copyright (c) 2013 Synappse Sebastian Suchanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONST_DISABLE_ANALYTICS                         YES // set YES to disable logging stats on non-production builds
//#define CONST_FLURRY_SESSION_ID                         @"XXXXXXXXX"
//#define CONST_GOOGLE_ANALYTICS_ID                       @"UA-XXXXXXX-1"
//#define CONST_TEST_FLIGHT_ID                            @"XXXXXXX"

@interface AnalyticsWrapper : NSObject

+ (void)setup;
+ (void)setUserAge:(int)age;
+ (void)setUserLocation:(CLLocation *)location;
+ (void)setUserSex:(BOOL)isMale;
+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName;
+ (void)trackExceptionWithDescription:(NSString *)desc fatal:(BOOL)fatal;
+ (void)trackPaymentWithCurrency:(NSString *)currency value:(NSNumber *)cost;

@end
