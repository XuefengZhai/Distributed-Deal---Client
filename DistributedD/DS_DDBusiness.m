//
//  DS_DDBusiness.m
//  DS_DD1
//
//  Created by Armando Aguileta on 25/04/14.
//  Copyright (c) 2014 Armando Aguileta. All rights reserved.
//

#import "DS_DDBusiness.h"


@implementation DS_DDBusiness

@dynamic b_id;
@dynamic desc;
@dynamic ip;
@dynamic lat;
@dynamic longtd;
@dynamic name;
@dynamic groups;

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
    coordinate.latitude = [self.lat doubleValue];
    coordinate.longitude = [self.longtd doubleValue];
    return coordinate;
}
@end
