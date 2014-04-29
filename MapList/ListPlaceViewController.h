//
//  ListPlaceViewController.h
//  MapList
//
//  Created by VinhPhuc on 4/24/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData+MagicalRecord.h"
#import "MBProgressHUD.h"
#include "PlaceCell.h"
#include "MapViewController.h"
#include "Place.h"
#include "PlaceDBEntity.h"
#import "DBController.h"

@class DBController;
@interface ListPlaceViewController : UITableViewController
{
    NSDictionary * sectionsDict;
    Place               * place;
    NSArray      * sectionArr;
}
@property(nonatomic)NSMutableArray *listPlaceCopy;

@end
