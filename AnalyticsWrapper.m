//
//  AnalyticsWrapper.m
//
//  Created by Sebastian Suchanowski on 07/12/13.
//  Copyright (c) 2013 Synappse Sebastian Suchanowski. All rights reserved.
//

#import "AnalyticsWrapper.h"
#ifdef CONST_TEST_FLIGHT_ID
#import "TestFlight.h"
#endif
#ifdef CONST_GOOGLE_ANALYTICS_ID
#import "GAI.h"
#endif
#ifdef CONST_FLURRY_SESSION_ID
#import "Flurry.h"
#endif

@implementation AnalyticsWrapper

+ (void)setup {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_TEST_FLIGHT_ID
    // Test Flight
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [TestFlight takeOff:CONST_TEST_FLIGHT_ID];
#endif
    
#ifdef CONST_FLURRY_SESSION_ID
    // Flurry Analytics!
    [Flurry startSession:CONST_FLURRY_SESSION_ID];
    [Flurry setUserID:[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]];
#endif
    
#ifdef CONST_GOOGLE_ANALYTICS_ID
    // Google Analytics
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[GAI sharedInstance] trackerWithTrackingId:CONST_GOOGLE_ANALYTICS_ID];
    [[GAI sharedInstance].defaultTracker setAnonymize:YES];
#endif
}

+ (void)setUserAge:(int)age {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_FLURRY_SESSION_ID
    [Flurry setAge:age];
#endif
}

+ (void)setUserLocation:(CLLocation *)location {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_FLURRY_SESSION_ID
    [Flurry setLatitude:location.coordinate.latitude
              longitude:location.coordinate.longitude
     horizontalAccuracy:location.horizontalAccuracy
       verticalAccuracy:location.verticalAccuracy];
#endif
}

+ (void)setUserSex:(BOOL)isMale {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_FLURRY_SESSION_ID
    if (isMale) {
        [Flurry setGender:@"m"];
    } else {
        [Flurry setGender:@"f"];
    }
#endif
}

+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_FLURRY_SESSION_ID
    [Flurry logEvent:eventName timed:timed];
#endif
}

+ (void)endTimedEvent:(NSString *)eventName {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_FLURRY_SESSION_ID
    [Flurry endTimedEvent:eventName withParameters:nil];
#endif
}

+ (void)trackExceptionWithDescription:(NSString *)desc fatal:(BOOL)fatal {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
#ifdef CONST_GOOGLE_ANALYTICS_ID
    [[GAI sharedInstance].defaultTracker trackException:fatal withDescription:desc];
#endif
}

+ (void)trackPaymentWithCurrency:(NSString *)currency value:(NSNumber *)cost {
    // don't run when test app!
    if (![self shouldLogInfo]) {
        return;
    }
    
    // TODO:[sebos]
}

void uncaughtExceptionHandler(NSException *exception) {
#ifdef CONST_FLURRY_SESSION_ID
    dispatch_async(dispatch_get_main_queue(), ^{
        [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
    });
#endif
}

+ (BOOL)shouldLogInfo {
#ifdef DEBUG
    return NO;
#endif
    if (CONST_DISABLE_ANALYTICS == YES) {
        return NO;
    }
    
    return YES;
}

@end
