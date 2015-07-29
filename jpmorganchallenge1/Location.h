//
//  Location.h
//  jpmorganchallenge1
//
//  Created by Gurkaran Gulati on 7/29/15.
//  Copyright (c) 2015 Gurkaran Gulati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) float distance;


- (id) initWithDictionary:(NSDictionary*) objectDictionary;

@end
