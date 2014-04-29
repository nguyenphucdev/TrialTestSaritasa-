//
//  Place.m
//  MapViewDemo
//
//  Created by VinhPhuc on 4/23/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import "Place.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation Place

@synthesize city,image,latitude,longtitude,text;
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.latitude=[[attributes valueForKey:@"latitude"] floatValue];
    self.longtitude=[[attributes valueForKey:@"longtitude"]floatValue ];
    self.city=[attributes valueForKey:@"city"];
    self.image=[attributes valueForKey:@"image"];
    self.text=[attributes valueForKey:@"text"];
    return self;
}
#pragma mark -

+ (void)getPlaces:(void (^)(NSArray *listPlace, NSError *error))block URL:(NSString *)uRLStr
{

    NSError *error;
    NSURL *url = [[NSURL alloc] initWithString:uRLStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        NSArray *arrResponse = [JSON objectForKey:@"places"];
        NSMutableArray *places=[NSMutableArray arrayWithCapacity:[arrResponse count]];
        
        for (NSDictionary *attributes in arrResponse) {
            Place *place = [[Place alloc] initWithAttributes:attributes];
            [places addObject:place];
        }

        if (block) {
            block([NSArray arrayWithArray:places], error);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];

}

+(NSMutableArray*) getPlaces: (NSString*) urlStr
{
    __block NSMutableArray *places;
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"%@", JSON);
        NSArray *arrResponse = [JSON objectForKey:@"places"];
        places=[NSMutableArray arrayWithCapacity:[arrResponse count]];
        
        for (NSDictionary *attributes in arrResponse) {
            Place *place = [[Place alloc] initWithAttributes:attributes];
            [places addObject:place];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
    

    return places;
}


@end
