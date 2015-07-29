//
//  Location.m
//  jpmorganchallenge1
//
//  Created by Gurkaran Gulati on 7/29/15.
//  Copyright (c) 2015 Gurkaran Gulati. All rights reserved.
//

#import "Location.h"

@implementation Location


- (id) initWithDictionary:(NSDictionary*) objectDictionary{
    _address = [objectDictionary objectForKey:@"address"];
    _city = [objectDictionary objectForKey:@"city"];
    _zip = [objectDictionary objectForKey:@"zip"];
    _phone = [objectDictionary objectForKey:@"phone"];
    NSString *latitudeString = [objectDictionary objectForKey:@"lat"];
    NSString *longitudeString = [objectDictionary objectForKey:@"lng"];
    _distance = [[objectDictionary objectForKey:@"distance"] floatValue];
    _location = [[CLLocation alloc] initWithLatitude:[longitudeString doubleValue] longitude:[latitudeString doubleValue]];
    return self;
}


@end
