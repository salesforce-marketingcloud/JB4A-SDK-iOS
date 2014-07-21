//
//  PUDServiceProvider.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/5/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDServiceProvider.h"

// Services
#import "PUDFuelService.h"

@interface PUDServiceProvider ()

@property (nonatomic, strong) id<PUDFuelServiceProtocol> fuelService;

@end

@implementation PUDServiceProvider

#pragma mark - initialization methods

+ (instancetype)sharedProvider {
    static PUDServiceProvider *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - service provider methods

+ (id<PUDFuelServiceProtocol>)fuelService {
    PUDServiceProvider *serviceProvider = [self sharedProvider];
    
    if (!serviceProvider.fuelService) {
        serviceProvider.fuelService = [[PUDFuelService alloc] init];
    }
    
    return serviceProvider.fuelService;
}

@end
