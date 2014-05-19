//
//  FavouriteDetailViewController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 4/4/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "FavouriteDetailViewController.h"
#import "COMSAppDelegate.h"

@interface FavouriteDetailViewController ()


@end

@implementation FavouriteDetailViewController
@synthesize passValue;
@synthesize photoRef;
@synthesize icon;
@synthesize name;
@synthesize type;
@synthesize address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


#pragma  --------- Updating the UIview ----------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
   
    self.passValue = appDelegate.favDictionary;
    
    self.name.text = [self.passValue objectForKey:@"name"];
    self.name.numberOfLines = 2;
    self.address.text = [self.passValue objectForKey:@"address"];
    self.address.numberOfLines = 2;
    self.type.text = [self.passValue objectForKey:@"type"];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.passValue objectForKey:@"photoURL"]]];
    
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    if([[self.passValue objectForKey:@"photoURL"] isEqualToString:@"noImage"])
    {
        self.photoRef.image = [UIImage imageNamed:@"no-photo-s.jpg"];
       

    }
    else
    {
        self.photoRef.image = img;
    }
    
    NSData *imageIcon = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.passValue objectForKey:@"icon"]]];
    UIImage *ic = [[UIImage alloc] initWithData:imageIcon];
    self.icon.image = ic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
