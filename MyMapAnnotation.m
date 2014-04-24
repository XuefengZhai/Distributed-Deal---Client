//
//  MyMapAnnotation.m
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "MyMapAnnotation.h"


@implementation MyMapAnnotation
@synthesize lati;
@synthesize longi;
@synthesize name;

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@""];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.lati doubleValue];
    coordinate.longitude = [self.longi doubleValue];
    return coordinate;
}

@end
