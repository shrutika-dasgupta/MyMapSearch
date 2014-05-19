//
//  TableViewController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/28/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSMapViewController.h"
#import "COMSAppDelegate.h"
#import "MapDataModel.h"

@interface TableViewController : UITableViewController
{
    COMSAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSMutableArray *passedResults;
@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) IBOutlet UITableView *myTable;
@property (nonatomic,retain) NSMutableArray *fetchedFavList;

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@end
