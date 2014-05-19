//
//  DetailsViewController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/30/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "DetailsViewController.h"
#import "TableViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize passedDictionary;
@synthesize addressLabel;
@synthesize imageLabel;
@synthesize nameLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma ------ code for setting the default UI values ----------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Creating a delegate for passing the data from one view to the other using appDelegate
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    //Getting the shared dictionary for the cell row that is selected
    self.passedDictionary = appDelegate.sharedDictionary;
    
  // Retrieving the values from the dictionary and setting the UI elements.
    NSDictionary *photoDict = [[self.passedDictionary objectForKey:@"photos"] objectAtIndex:0];
    NSString *photoRef = [photoDict objectForKey:@"photo_reference"];
    NSString *api_key =@"AIzaSyD7p3lc_bVBa8W9DYkC0fu5tyaQhAdmHYA";
    NSURL *url;
    UIImage *img;
    
    if(photoRef==nil)
    {
        // Sets a default image if the no photo refrence is present
        img = [UIImage imageNamed:@"no-photo-s.jpg"];
        self.imageLabel = [[UIImageView alloc] initWithImage:img];
        [self.view addSubview:self.imageLabel];
        url = nil;
    }
    else
    {
        url =[NSURL URLWithString: [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef,api_key ]];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        img = [[UIImage alloc] initWithData:data];
    }

    self.imageLabel.image = img;
    self.nameLabel.text = [self.passedDictionary valueForKey:@"name"];
    self.nameLabel.numberOfLines = 3;
    self.addressLabel.text = [self.passedDictionary valueForKey:@"vicinity"];
    self.addressLabel.numberOfLines = 3;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
