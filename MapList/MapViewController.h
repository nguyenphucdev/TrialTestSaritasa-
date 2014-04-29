//
//  MapViewController.h
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
@interface MapViewController : UIViewController<MKMapViewDelegate,MKAnnotation,UIActionSheetDelegate>
{
    MKPlacemark             *mPlacemark;
    Place                   *place;
    CLLocationCoordinate2D  location;
    BOOL                    flag;
}
@property(strong,nonatomic)MKMapView            *mapView;
@property(strong,nonatomic)NSMutableDictionary  *dicLocation;
@property(strong,nonatomic)Place                *place;


@end
