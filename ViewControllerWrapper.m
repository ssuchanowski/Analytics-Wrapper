//
//  ViewControllerWrapper.m
//  Tenerife Bay
//
//  Created by Sebastian Suchanowski on 7/12/13.
//  Copyright (c) 2013 Synappse Sebastian Suchanowski. All rights reserved.
//

#import "ViewControllerWrapper.h"
#import "AnalyticsWrapper.h"

@implementation ViewControllerWrapper

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.trackedViewName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"VC" withString:@""];
}

@end
