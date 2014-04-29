//
//  BusinessMapViewController.m
//  DistributedD
//
//  Created by XZhai on 4/11/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "BusinessMapViewController.h"
#import "BusininessDetailViewController.h"

@interface BusinessMapViewController ()
{
    NSString *lat,*lng;
    CLLocationCoordinate2D currentLocation;
    CLLocation *curLocation;
    
}

@end

@implementation BusinessMapViewController

@synthesize mapView;

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
//    MKCoordinateSpan theSpan;
//    //The span of the map, the lower the more acurate
//    theSpan.latitudeDelta = 0.01;
//    theSpan.longitudeDelta = 0.01;
//    MKCoordinateRegion theRegion;
//    theRegion.center = [curLocation coordinate];
//    theRegion.span = theSpan;
//    [mapView setRegion:theRegion];
    
//    MKCoordinateRegion region = self.mapView.region;
//    region.center = curLocation;
//    region.span.longitudeDelta /= ratioZoomMax; // Bigger the value, closer the map view
//    region.span.latitudeDelta /= ratioZoomMax;
//    [self.mapView setRegion:region animated:YES]; // Choose if you want animate or not

    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];

    currentLocation.latitude = curLocation.coordinate.latitude;
    currentLocation.longitude = curLocation.coordinate.longitude;
    
    
    
    
    
    
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
    [self loadBusinessesFromCloud];
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

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"Hello!");
    NSLog(@"%@",view.annotation.title);
    DS_DDBusiness *chosenBiz = (DS_DDBusiness *)view.annotation;
    
    [[NSUserDefaults standardUserDefaults] setValue:chosenBiz.name forKey:@"biztitle"]; //pass value to next view
    [[NSUserDefaults standardUserDefaults] setValue:chosenBiz.ip forKey:@"bizip"];
    [[NSUserDefaults standardUserDefaults] setValue:chosenBiz.desc forKey:@"bizdesc"];
    
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
        static NSString* MyLocation = @"MyLocation";
        [mapView dequeueReusableAnnotationViewWithIdentifier:MyLocation];
        MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                                initWithAnnotation:annotation reuseIdentifier:MyLocation];
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }else{
    
        customPinView.canShowCallout = YES;
        // Create a UIButton object to add on the
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [customPinView setRightCalloutAccessoryView:rightButton];

    return customPinView;
    }
}






- (void)loadBusinesses
{
    

    NSManagedObjectContext *context = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DS_DDBusiness" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"b_id" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSArray *businesses = [context executeFetchRequest:fetchRequest error:nil];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    for(DS_DDBusiness *business in businesses){
        //DS_DDBusiness *business = [[DS_DDBusiness alloc] init];
        
        
        
//        [business setName:[[object valueForKey:@"name"] description]];
//        [business setLat: [f numberFromString:[[object valueForKey:@"lat"] description]]];
//        [business setLongtd: [f numberFromString:[[object valueForKey:@"longtd"] description]]];
        
        [mapView addAnnotation:business];
        
    }
    NSLog(@"loadBusinesses");
    
    
}

- (void)loadBusinessesFromCloud
{
    NSLog(@"Print again!!<%@,%@>",lat,lng);

    
    NSString *locationString = [NSString stringWithFormat:@"%@+%@",lat,lng];
    NSDictionary *location = @{ @"Location" : locationString};

    [[RKObjectManager sharedManager] getObjectsAtPath:@"/getallbiz" parameters:location success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        [self loadBusinesses];

        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"An Error Has Occurred" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}




@end
 
