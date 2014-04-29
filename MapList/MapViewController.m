//
//  MapViewController.m
//  MapList
//
//  Created by VinhPhuc on 4/26/14.
//  Copyright (c) 2014 com.happy. All rights reserved.
//

#import "MapViewController.h"
#import "BridgeAnnotation.h"
#import "DBController.h"
@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView,dicLocation,place;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    flag                               = NO;

    // init map view
    mapView                            = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType                    = MKMapTypeHybrid;

    CLLocationCoordinate2D coord       = {.latitude =  place.latitude, .longitude = place.longtitude};
    MKCoordinateSpan span              = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    MKCoordinateRegion region          = {coord, span};
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];

    mapView.showsUserLocation          = TRUE;
    mapView.delegate                   = self;
    [self.view addSubview:mapView];
    /*Add UILongPressGestureRecognizer*/
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration          = 2.0;//user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];


	// Add toolBar
    UIToolbar *toolBar;
    toolBar                            = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    toolBar.barStyle                   = UIBarStyleDefault;
    [toolBar sizeToFit];
    UIBarButtonItem *flexibleSpace     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *menuButton        = [[UIBarButtonItem alloc] initWithTitle:@"ACTION" style:UIBarButtonItemStyleBordered target:self action:@selector(showActionSheet:)] ;

    UIBarButtonItem *doneButton        = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction:)];

    NSArray *barButton                 = [[NSArray alloc] initWithObjects:menuButton,flexibleSpace,doneButton,nil];
    [toolBar setItems:barButton];

    [self.view addSubview:toolBar];


}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)doneAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showActionSheet:(id)sender{

    UIActionSheet *actionSheet         = [[UIActionSheet alloc]
                                  initWithTitle:@"Touch and hold 2s a point on map to Drop a Pin"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Save with new pin point",@"About", nil];

    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet
/**
 *  Show action
 *
 *  @param actionSheet actionSheet description
 *  @param buttonIndex buttonIndex description
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle              = [actionSheet buttonTitleAtIndex:buttonIndex];

    if  ([buttonTitle isEqualToString:@"Save with new pin point"]) {
        if (flag)

            [DBController updatePosition:place];

        else


            [self showAlert:@"Message" withMessage:@"Please drop a pin! \n Touch and hold 2s a point on map to Drop a Pin"];

    }
    if ([buttonTitle isEqualToString:@"About"]) {
        [self showAlert:@" About" withMessage:@"Created by Nguyễn Phúc on 4/27/14. \n Email : nguyenphucdev@gmail.com \n Phone : 098 6768 502"];
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {

    }

}
#pragma mark - showAlert
/**
 *  showAlert
 *
 *  @param title
 *  @param mess  message
 */
-(void) showAlert:(NSString*) title withMessage:(NSString*) mess
{
    UIAlertView		*alertView            = [[UIAlertView alloc]initWithTitle:title
                                                        message:mess
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - handled Long Press Action
/**
 *  handle 2s touch on map
 *
 *  @param gestureRecognizer gestureRecognizer description
 */
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    [self.mapView removeAnnotations:self.mapView.annotations];

    CGPoint touchPoint                 = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    BridgeAnnotation *annot            = [[BridgeAnnotation alloc] init];
    annot.coord                        = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
    flag                               = YES;

}

@end
