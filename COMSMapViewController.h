//
//  COMSMapViewController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 2/12/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "COMSAppDelegate.h"

@interface COMSMapViewController : UIViewController<CLLocationManagerDelegate>
{
    COMSAppDelegate *appDelegate;
}

@property (strong, nonatomic) id textPassed;
@property (strong, nonatomic) id typePassed;
@property (strong, nonatomic) IBOutlet MKMapView *MyMapView;

@property (strong, nonatomic) IBOutlet UINavigationBar *TitleLabel;

@property (strong, nonatomic) IBOutlet UISlider *mySlider;
- (IBAction)sliderChanged:(id)sender;

@end
