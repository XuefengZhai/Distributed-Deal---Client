//
//  BusinessMapViewController.m
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "BusinessMapViewController.h"

@interface BusinessMapViewController ()
{
    NSString *lat,*lng;
    CLLocationCoordinate2D currentLocation;
    CLLocation *curLocation;
    
    
}

@end

@implementation BusinessMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lm = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        lm.delegate = self;
        lm.desiredAccuracy = kCLLocationAccuracyBest;
        lm.distanceFilter = 1000.0f;
        [lm startUpdatingLocation];
        
    }
    /*
     *Init the map view to the current location;
     */
    MKCoordinateSpan theSpan;
    //The span of the map, the lower the more acurate
    theSpan.latitudeDelta = 2;
    theSpan.longitudeDelta = 2;
    MKCoordinateRegion theRegion;
    theRegion.center = [curLocation coordinate];
    theRegion.span = theSpan;
    [mapView setRegion:theRegion];
    
    MyMapAnnotation *annotation = [[MyMapAnnotation alloc] initWithName:@"test" address:@"test" coordinate:currentLocation] ;
    [_mapView addAnnotation:annotation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation{
    
    
    lat = [[NSString alloc] initWithFormat:@"%g",
           newLocation.coordinate.latitude];
    
    lng = [[NSString alloc] initWithFormat:@"%g",
           newLocation.coordinate.longitude];
    
    currentLocation.latitude = newLocation.coordinate.latitude;
    currentLocation.longitude = newLocation.coordinate.longitude;
    
    curLocation = newLocation;
    
    
    NSLog(@"<%@,%@>",lat,lng);
}




- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error {
    NSString *msg = @"Error obtaining location";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:msg
                          delegate:nil
                          cancelButtonTitle: @"Done"
                          otherButtonTitles:nil];
    [alert show];
}

/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyMapAnnotation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

*/


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MyMapAnnotation class]]) {
        // try to dequeue an existing pin view first
        static NSString* travellerAnnotationIdentifier = @"TravellerAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:travellerAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKAnnotationView* customPinView = [[MKAnnotationView alloc]
                                                initWithAnnotation:annotation reuseIdentifier:travellerAnnotationIdentifier];
            customPinView.canShowCallout = YES;  //很重要，运行点击弹出标签
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                        action:@selector (toDetail)
                        forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            customPinView.opaque = YES;
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}



-(void)toDetail
{
    [self performSegueWithIdentifier:@"detail" sender:self];
}


@end
 
