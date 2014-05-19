//
//  COMSMapViewController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 2/12/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "COMSMapViewController.h"
#import <COMSMapManager/COMSMapManager.h>
#import "COMSBaseViewController.h"
#import "TableViewController.h"
#import <math.h>


@interface COMSMapViewController ()
//private location manager
@property (nonatomic, strong)CLLocationManager *locationManager;


@end

@implementation COMSMapViewController


-(void)awakeFromNib{
    
    //instantiate location manager
    self.locationManager = [[CLLocationManager alloc] init];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.locationManager = [CLLocationManager new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Creating a delegate for passing the data from one view to the other using appDelegate
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    //we must subscribe as the delegate to the location manager
    self.locationManager.delegate = self;
    //Shows the user location on the map
    [self.MyMapView setShowsUserLocation:YES];
    //zoom is enabled when the location is found
    [self.MyMapView setZoomEnabled:YES];
    //Image for slider button when its in Normal mode
    [self.mySlider setThumbImage:[UIImage imageNamed:@"golde.png"] forState:UIControlStateNormal ];
    //Image for slider button when in activity
    [self.mySlider setThumbImage:[UIImage imageNamed:@"bluee.png"] forState:UIControlStateHighlighted ];
    
    //go ahead and start reading locations. The updates will come through the delegate methods
    [self.locationManager startUpdatingLocation];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Automatically called by location manager because we are it's delegate
 */
#pragma ------------------Updating locations---------------------------
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [self.MyMapView removeAnnotations:[self.MyMapView annotations]];
    //extract the 2d coordinate for better readability
    CLLocation *loc = locations[0];
    CLLocationCoordinate2D coord = loc.coordinate;

    CLLocation *calcLoc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];

    //  NSMutableArray *namelist = [[NSMutableArray alloc] init];

    //String defined stores the description of the value passed from the segue
    NSString *query = [self.textPassed description];
    NSString *typeOfSearch = [self.typePassed description];
    // NSLog(@"_______________________%@",typeOfSearch);
    if([typeOfSearch isEqualToString:@"All"])
    {
      //  NSLog(@"search: %@",typeOfSearch);
        typeOfSearch = @"";
    }


    //Multiple words handled in the string for better search
    query = [query stringByReplacingOccurrencesOfString: @" " withString:@"+"];
    //query server for results
    //disabled because without API key, it will crash
    //   NSLog(@"slider value: %f",[self.mySlider value]);
    [GoogleMapManager nearestVenuesForLatLong:coord
                                 withinRadius:[self.mySlider value]
                                     forQuery:query queryType:typeOfSearch
                             googleMapsAPIKey:@"AIzaSyD7p3lc_bVBa8W9DYkC0fu5tyaQhAdmHYA"
                             searchCompletion:^(NSMutableArray *results) {
                                 
                               // NSLog(@"%@",results);
                              //   NSLog(@"type of search:-------->%@",[self.typePassed description]);
                                 
                            //Setting the appDelegate Property with the result
                                 
                          //  NSLog(@"count: %d",[results count]);
                             //conditin to check if the results found are valid or not. If no results are found for the string then the count is 0
                             
                            if( ([results count] == 0) || [query isEqualToString:@""] )
                            {
                                   //alert box is displayed when on results are found
                                   UIAlertView *alert = [[UIAlertView alloc]
                                                         initWithTitle:@"RESULTS"
                                                         message: @"No results found!"
                                                         delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                                   [alert show];
                                //the location manager stops updating
                                   [self.locationManager stopUpdatingLocation];
                                   
                            }
                            else
                            {
                              //removing all the previously annotated pins
                                
                               [self.MyMapView removeAnnotations:[self.MyMapView annotations]];
                              /*For-loop for extracting all the results as a dictionary and then extracting the longitude and latitude, the name and address of the search result
                               
                               */
                                NSMutableArray *pass = [[NSMutableArray alloc]init];
                                
                                for(int i= 1; i < [results count]; i++ )
                                 {
                                     NSMutableDictionary *resDict = [NSMutableDictionary dictionaryWithDictionary:[ results objectAtIndex:i]];
                                     NSMutableDictionary *geomDict = [ resDict valueForKey:@"geometry"];
                                     NSMutableDictionary *locDict = [ geomDict valueForKey:@"location"];
                                     NSString *lat = [locDict valueForKey:@"lat"];
                                     NSString *lng = [locDict valueForKey:@"lng"];
                                     NSString *name = [resDict valueForKey:@"name"];
                                     //[namelist addObject:name];
                                     
                                     NSString *addr = [resDict valueForKey:@"vicinity"];
                                    //Making an object of CLLocation to of each result and giving it the longitude and latitude extracted
                                     CLLocationCoordinate2D location;
                                     location.latitude = [lat doubleValue];
                                     location.longitude = [lng doubleValue];
                                     //Sets the region of the map that is to be displayed on the GUI of the application
                                     MKCoordinateRegion myCood = MKCoordinateRegionMakeWithDistance(coord, [self.mySlider value], [self.mySlider value]);
                                     //Sets the annotation withlocation, name, and address
                                     MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
                                     annot.coordinate = location;
                                     annot.title = name;
                                     annot.subtitle = addr;
                                     
                                     //Steps for adding the annotations
                                     [self.MyMapView addAnnotation:annot];
                                     [self.MyMapView setRegion:myCood animated:YES];
                                     
                                     CLLocation *restLoc = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
                                     CLLocationDistance distanceCLL = [ restLoc distanceFromLocation: calcLoc];
                                     
                                     NSNumber *numDist =  [[NSNumber alloc] initWithInt:distanceCLL];
                                     
                                     [resDict setObject:numDist  forKey:@"distance"];
                                     
                                     [pass addObject:resDict];
                                     
                                 }
                                
                                 //Stop updating the location manager after the results are found and the pins are dropped
                                
                                NSSortDescriptor *aSortDesc = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
                                [pass sortUsingDescriptors:[NSMutableArray arrayWithObject:aSortDesc]];
                                
                                
                                appDelegate.tableData = pass;
                                 [self.locationManager stopUpdatingLocation];
                            }
                    }];

}

//the funtion for slider bar: whenever the slider is changed, the locationManager starts updating the location.
- (IBAction)sliderChanged:(id)sender {
   // NSLog(@"*** changed slider ****");
    [self.locationManager startUpdatingLocation];
}

@end
