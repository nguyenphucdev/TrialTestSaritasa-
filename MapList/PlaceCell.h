//
//  PlaceCell.h
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "MBProgressHUD.h"

@interface PlaceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceName;
@property (weak, nonatomic) IBOutlet UILabel *lblCityName;
@property (nonatomic,strong) Place *place;
@property (nonatomic,weak)NSURLRequest *_request;
- (void)setPlace;
@end
