//
//  DetailsViewController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/30/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"
#import "TableViewController.h"


@interface DetailsViewController : UIViewController
{
    COMSAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableDictionary *passedDictionary;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
