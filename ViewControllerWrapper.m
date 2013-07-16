//
//  ViewControllerWrapper.m
//
//  Created by Sebastian Suchanowski on 7/12/13.
//  Copyright (c) 2013 Synappse Sebastian Suchanowski. All rights reserved.
//

#import "ViewControllerWrapper.h"
#import "AnalyticsWrapper.h"

@implementation ViewControllerWrapper

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([AnalyticsWrapper shouldLogInfo]) {
        NSString *viewName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:CONST_VC_CLASS_NAME_POSTFIX withString:@""];
        self.trackedViewName = viewName;
        [AnalyticsWrapper logEvent:viewName timed:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([AnalyticsWrapper shouldLogInfo]) {
        NSString *viewName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:CONST_VC_CLASS_NAME_POSTFIX withString:@""];
        [AnalyticsWrapper endTimedEvent:viewName];
    }
}

@end
