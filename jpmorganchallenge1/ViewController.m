//
//  ViewController.m
//  jpmorganchallenge1
//
//  Created by Gurkaran Gulati on 7/29/15.
//  Copyright (c) 2015 Gurkaran Gulati. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"

@interface ViewController ()
@property (nonatomic) CLLocationDegrees *currentLocationLongitude;
@property (nonatomic) CLLocationDegrees *currentLocationLatitude;
@property (nonatomic, strong) NSMutableArray *locations;


@end

@implementation ViewController

@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
    #ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
            // Use one or the other, not both. Depending on what you put in info.plist
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
    #endif
        [self.locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D myLocation = [userLocation coordinate];
    self.currentLocationLatitude = &(myLocation.latitude);
    self.currentLocationLongitude = &(myLocation.longitude);
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation, 2500, 2500);
    [_mapView setRegion:zoomRegion animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        _mapView.showsUserLocation = YES;
        [_mapView setMapType:MKMapTypeStandard];
        [_mapView setZoomEnabled:YES];
        [_mapView setScrollEnabled:YES];

    }
    
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self fetchData];
}

- (void) fetchData{
    if(self.currentLocationLongitude != nil && self.currentLocationLatitude != nil){
        
        NSString *stringURL = [[NSString alloc] initWithFormat:@"https://m.chase.com/PSRWeb/location/list.action?lat=%f&lng=%f",self.currentLocationLongitude,self.currentLocationLatitude];
        NSLog(stringURL);
        NSURL *url = [NSURL URLWithString:stringURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 _locations = [[NSMutableArray alloc] init];
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                                  error:NULL];
                 NSArray *locationsArray = [dataDictionary objectForKey:@"locations"];
                 for (NSDictionary *locationDictionary in locationsArray){
                     Location *location = [[Location alloc]initWithDictionary:locationDictionary];
                     [_locations addObject:location];
                 }
             }
         }];
        
        
    }
    
}
@end
