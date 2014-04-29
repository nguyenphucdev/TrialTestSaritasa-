//
//  PlaceCell.m
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import "PlaceCell.h"
#import "AFNetworking/UIImageView+AFNetworking.h"


@implementation PlaceCell
@synthesize lblCityName,lblPlaceName,imageViewPlace,place,_request;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - set data for Place cell
/**
 *  set data for Place cell
 */
- (void)setPlace {
    self.lblPlaceName.text=[NSString stringWithFormat:@"%@",place.text];
    self.lblCityName.text                   = [place.city isEqual:[NSNull null]] ?@"Unknow City":[NSString stringWithFormat:@"%@ City",place.city];

   _request=[NSURLRequest requestWithURL:[NSURL URLWithString:place.image] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20.0];
    __weak UIImageView *blockimageViewPlace = imageViewPlace;

    [imageViewPlace setImageWithURLRequest:_request placeholderImage:[UIImage imageNamed:@"load_image.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

    blockimageViewPlace.image               = image;


    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"failed loading: %@", error);


    }];

    // customize image size
    CGSize itemSize                         = CGSizeMake(60, 60);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect                        = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self.imageViewPlace.image  drawInRect:imageRect];
    self.imageViewPlace.image               = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setNeedsLayout];
}
#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lblPlaceName.numberOfLines=1;
    [self.lblPlaceName sizeToFit];
 
    self.imageViewPlace.frame = CGRectMake(imageViewPlace.frame.origin.x, imageViewPlace.frame.origin.y, 70.0f, 70.0f);

}


@end
