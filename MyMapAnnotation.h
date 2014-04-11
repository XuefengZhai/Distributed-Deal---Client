//
//  MyMapAnnotation.h
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyMapAnnotation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
