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
    theSpan.latitudeDelta = 0.01;
    theSpan.longitudeDelta = 0.01;
    MKCoordinateRegion theRegion;
    theRegion.center = [curLocation coordinate];
    theRegion.span = theSpan;
    [mapView setRegion:theRegion];
    
    currentLocation.latitude = 42.44469;
    currentLocation.longitude = -78.94886;
    
    NSLog(@"loadBusinesses");
    [self loadBusinessesFromCloud];
    
    
    
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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MyMapAnnotation class]]) {
        // try to dequeue an existing pin view first
        static NSString* MyLocation = @"MyLocation";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
        [mapView dequeueReusableAnnotationViewWithIdentifier:MyLocation];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKAnnotationView* customPinView = [[MKAnnotationView alloc]
                                                initWithAnnotation:annotation reuseIdentifier:MyLocation];
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


- (void)loadBusinesses
{
    
    NSManagedObjectContext *context = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Business" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *businesses = [context executeFetchRequest:fetchRequest error:nil];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    for(NSManagedObject *object in businesses){
        MyMapAnnotation *business = [[MyMapAnnotation alloc] init];
        [business setName:[[object valueForKey:@"name"] description]];
        [business setLati: [f numberFromString:[[object valueForKey:@"lat"] description]]];
        [business setLongi: [f numberFromString:[[object valueForKey:@"long"] description]]];
        
        
        [_mapView addAnnotation:business];
        
    }
    
    
}

- (void)loadBusinessesFromCloud
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/getallbiz" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        [self loadBusinesses];

        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Has Occurred" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}




@end
 
