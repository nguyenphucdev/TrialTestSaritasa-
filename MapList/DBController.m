//
//  DBController.m
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import "DBController.h"
@implementation DBController
PlaceDBEntity* placeDBEntity;
/**
 *  create and save entity data
 *
 *  @param Place object
 */
+ (void)createEntity: (Place *) item
{
    placeDBEntity =[PlaceDBEntity createEntity];
    [placeDBEntity setText:[NSString stringWithFormat:@"%@",item.text]];
    [placeDBEntity setCity:[NSString stringWithFormat:@"%@",item.city ]];
    [placeDBEntity setLatitude: item.latitude ];
    [placeDBEntity setLongtitude:item.longtitude];
    [placeDBEntity setImage:[NSString stringWithFormat:@"%@",item.image]];
    [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"saved");
    }];

}
#pragma mark -- Update Position
/**
 *  update Position
 *
 *  @param item Place object
 */
+ (void)updatePosition:(Place *) item
{
    
    [item setLatitude:item.latitude];
    [item setLongtitude:item.latitude];
    [[NSManagedObjectContext defaultContext] saveOnlySelfWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"Updated");
    }];
}

@end
