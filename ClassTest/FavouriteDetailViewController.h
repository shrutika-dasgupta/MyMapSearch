//
//  FavouriteDetailViewController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 4/4/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"

@interface FavouriteDetailViewController : UIViewController
{
    COMSAppDelegate *appDelegate;
}
@property (nonatomic,retain) NSDictionary *passValue;
@property (strong, nonatomic) IBOutlet UIImageView *photoRef;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *address;


@end
