//
//  ListPlaceViewController.m
//  MapList
//
//  Created by VinhPhuc on 4/24/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import "ListPlaceViewController.h"
#import "Reachability.h"
#import "CGLAlphabetizer.h"

#define ISCONNECTINGNETWORK	(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)||([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable))

@interface ListPlaceViewController ()

@end

@implementation ListPlaceViewController
@synthesize listPlaceCopy;
NSMutableArray *sortedPlaces ;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
           }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{

    listPlaceCopy= [[NSMutableArray alloc] initWithArray:[PlaceDBEntity findAll]];
    if([listPlaceCopy count]==0) // if data is empty -> call function to connect and get data from URL
    {
        if (![self isConnectingNetwork])
            return;
        else
         [self getData];
       
    }
    else // have data -> sort data and show data on table view
    {
        [self sortAlphabeticaly];
  

    }
   
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    sectionsDict=[[NSDictionary alloc] init];
    sectionArr  = [[NSMutableArray alloc]init];
    place=[[Place alloc] init];


    if(![self isConnectingNetwork])
        return;
    

    
}
#pragma mark - sort Data fuction - sort list place Array
/**
 *  sort Data fuction - sort list place Array
 */


-(void) sortAlphabeticaly
{
    sectionsDict = [CGLAlphabetizer alphabetizedDictionaryFromObjects:listPlaceCopy usingKeyPath:@"city"];
    sectionArr = [CGLAlphabetizer indexTitlesFromAlphabetizedDictionary:sectionsDict];
    [self.tableView reloadData];
    
}


#pragma mark - connect and get data from saritasa_URL

-(void)getData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    listPlaceCopy =[[NSMutableArray alloc] init];
    [Place getPlaces:^(NSArray *listPlace, NSError *error) {
        if(listPlace.count>0)
        {
            listPlaceCopy = [NSMutableArray arrayWithArray:listPlace];
            
            [self sortAlphabeticaly];
            for (int i=0;i< [listPlaceCopy count];i++)
            {
                [DBController createEntity:[listPlaceCopy objectAtIndex:i]];
            }

            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    } URL:URL_Json_saritasa ];
}

- (Place *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionIndexTitle = sectionArr[indexPath.section];
    return sectionsDict[sectionIndexTitle][indexPath.row];
}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return sectionArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionIndexTitle = sectionArr[section];
    return [sectionsDict[sectionIndexTitle] count];
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return sectionArr[section];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        UILabel *textLabel = [(UITableViewHeaderFooterView *)view textLabel];
        textLabel.textColor = [UIColor blueColor];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if (!cell) {
    cell            = [[PlaceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.place=[self objectAtIndexPath:indexPath];
    [cell setPlace];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    MapViewController * mapView=[[MapViewController alloc] init];
    place=[[sectionArr objectAtIndex:indexPath.section ] objectAtIndex:(NSUInteger)indexPath.row];
    if(![self isConnectingNetwork])
        return;
    else
    mapView.place = place;
    [self presentViewController:mapView animated:YES completion:nil];

}
#pragma mark - Orientation


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Connections
/**
 *  Description
 *
 *  @return true ->have connection
 */
- (BOOL)isConnectingNetwork {
    if( !ISCONNECTINGNETWORK ) {
        UIAlertView		*alertView       = [[UIAlertView alloc]initWithTitle:nil
															message:@"Check your internet connection"
														   delegate:nil
												  cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
		return NO;
	}
	return YES;
}
@end
