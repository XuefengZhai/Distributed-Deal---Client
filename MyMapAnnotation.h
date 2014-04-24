//
//  MyMapAnnotation.h
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyMapAnnotation : NSObject  <MKAnnotation>
@property (nonatomic,retain) NSNumber *lati;
@property (nonatomic,retain) NSNumber *longi;
@property (nonatomic, retain) NSString *name;

@end
