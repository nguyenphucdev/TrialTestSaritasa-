//
//  DBController.h
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceDBEntity.h"
#import "Place.h"

@interface DBController : NSObject
{
    PlaceDBEntity * placeDBEntity;
}
+ (void)createEntity: (PlaceDBEntity *) item;
+ (void)updatePosition:(Place *) item;

@end
