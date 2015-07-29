//
//  ViewController.h
//  jpmorganchallenge1
//
//  Created by Gurkaran Gulati on 7/29/15.
//  Copyright (c) 2015 Gurkaran Gulati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController : UIViewController <MKMapViewDelegate,  CLLocationManagerDelegate>

@property (strong,nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end

