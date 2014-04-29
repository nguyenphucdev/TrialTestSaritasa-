//
//  PlaceDBEntity.h
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PlaceDBEntity : NSManagedObject

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

@end
