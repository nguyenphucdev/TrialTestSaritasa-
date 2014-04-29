//
//  Place.h
//  MapViewDemo
//
//  Created by VinhPhuc on 4/23/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
/*
 "latitude": 0,
 "longtitude": 0,
 "city": null,
 "text": "NorthPole",
 "image": "http: //upload.wikimedia.org/wikipedia/commons/thumb/2/25/Nordpole.png/220px-Nordpole.png"
 */
//

#import <Foundation/Foundation.h>
//#import <CoreData/CoreData.h>

@interface Place : NSObject
{
    double latitude;
    double longtitude;
    NSString *city;
    NSString *text;
    NSString *image;
}
@property (nonatomic,assign)double latitude;
@property (nonatomic,assign)double longtitude;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy) NSString *image;

+ (void)getPlaces:(void (^)(NSArray *ListPlace, NSError *error))block URL:(NSString *)uRLStr;
+(NSMutableArray*) getPlaces: (NSString*) urlStr;

@end
