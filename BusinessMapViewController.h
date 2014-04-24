//
//  BusinessMapViewController.h
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyMapAnnotation.h"
#import "AppDelegate.h"


@interface BusinessMapViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet MKMapView *mapView;
    CLLocationManager *lm;

}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;


@end


